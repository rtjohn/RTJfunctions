function MakeGroupFiberDensityMapMIND(MoriNum,endptFlag,dilate,subSpace,outName)

%% Example
%
% To being you must create a variable called subCodes listing the STS#s of
% who you want processed
%
% MoriNum is the desired fibergroup within the MoriGroups structure below
% 1 Anterior thalamic radiation L
% 2 Anterior thalamic radiation R 
% 3 Corticospinal tract L 
% 4 Corticospinal tract R 
% 5 Cingulum (cingulate gyrus) L
% 6 Cingulum (cingulate gyrus) R 
% 7 Cingulum (hippocampus) L
% 8 Cingulum (hippocampus) R
% 9 Forceps major
% 10 Forceps minor
% 11 Inferior fronto-occipital fasciculus L
% 12 Inferior fronto-occipital fasciculus R
% 13 Inferior longitudinal fasciculus L
% 14 Inferior longitudinal fasciculus R
% 15 Superior longitudinal fasciculus L
% 16 Superior longitudinal fasciculus R
% 17 Uncinate fasciculus L
% 18 Uncinate fasciculus R
% 19 Superior longitudinal fasciculus (temporal part) L
% 20 Superior longitudinal fasciculus (temporal part) R
%
% endptFlag: 1 if you want the map to be made just for fiber endpoints and
% 0 if you want it made for the full fiber group.  If you want to display on
% the cortical surface set endptFlag=1
%
% dilate: 1 if you want each subjects fiber group to be smoothed and dilated
% before making the group map. 2 if you want each subjects fiber group to be
% dilated and smoothed twice before making the group map.  This creates more
% overlap and is more analagous to the SPM methodology of smoothing the heck
% out of everything
%
% subSpace: 1 if you want the map to be output in the native space of a
% single subject 0 if you want it in MNI space.  YOu can set which subject
% below
%
% outname: the output name as a string including the path to where you want the files saved
%
% Implementation 
% subCodes = {'108750-200'...
% '109703-100'...
% '108471-100'...
% '109531-100'}
% MakeGroupFiberDensityMapMIND(10,1,1,0,'/Users/Ryan/Documents/MATLAB/Densities/CST_TDBoys')

%% get subject directory structure
AFQ = '/Users/Ryan/Documents/MATLAB/AFQ';
AFQdata = fullfile(AFQ,'data');
fgName = 'MoriGroups_clean_D5_L4.mat';
fibPath = '/dti30/fibers';

% Use subCodes variable in workspace to define subjects
subCodes = evalin('base','subCodes')
gg = length(subCodes);
subDirs = cell(gg,1);
subList = cell(gg,1);
for ii=1:length(subCodes)
    subDirs{ii,:}=fullfile(AFQdata,subCodes{ii});
    subList{ii,:}=fullfile(AFQdata,subCodes{ii},'dti30','dt6.mat');
end

% Template to be used as a reference image from which we will construct our group map.  This reference
% image is modified rather than creating a nifti from scratch
tdir = fullfile(fileparts(which('mrDiffusion.m')), 'templates');
if subSpace==1
    ref=readFileNifti(fullfile('/biac3/wandell4/data/reading_longitude/dti_adults/rfd070508/dti06trilinrt','bin','b0.nii.gz'));
else
    refImage = fullfile(tdir,'MNI_T1.nii.gz');
    ref = readFileNifti(refImage);
end

%% If you want the map output in the native space of a single supbject then
%put the path to that subjects dt6 file here.  This is useful if you want
%to visualize results on a 3d mesh.  Otherwise the map will be saved in MNI
%space
if subSpace==1
    subDt6=dtiLoadDt6('/biac3/wandell4/data/reading_longitude/dti_adults/rb080930/dti06trilin/dt6');
    [snSub, defSub]=dtiComputeDtToMNItransform(subDt6);
end
%% Loop through subjects
% Form a count of subjects being processed
numSubs=0;
for ii=1:length(subCodes)
    fibDir=fullfile(subDirs{ii},fibPath);
    fibFile=fullfile(fibDir, fgName);
    if exist(fibFile,'file')
        disp(subCodes{ii});
        numSubs=numSubs+1
        dt=dtiLoadDt6(subList{ii});
        fg=dtiReadFibers(fibFile);
        target_fg=fg(MoriNum);
        %fg=mtrImportFibers(fibFile, dt.xformToAcpc);
        if ~isempty(target_fg.fibers)

            %compute MNI transformation

            [sn, def]=dtiComputeDtToMNItransform(dt);

            %Normalize fibers

            target_fg = dtiXformFiberCoords(target_fg, def);

            if subSpace==1
                target_fg = dtiXformFiberCoords(target_fg, snSub);
                target_fg = dtiXformFiberCoords(target_fg, subDt6.xformToAcpc);
            end

            %convert fibers to ROI if endpoints flag = 0 then do for the whole
            %fiber group.  if ==1 then only for fiber endpoints
            if endptFlag==0
                roi = dtiNewRoi([target_fg.name,'_fiberROI'], target_fg.colorRgb./255, unique(round(horzcat(target_fg.fibers{:}))','rows'));
            elseif endptFlag==1
                for kk=1:length(target_fg.fibers)
                    endpts(:,kk)=target_fg.fibers{kk}(:,end);
                    startpts(:,kk)=target_fg.fibers{kk}(:,1);
                end
                roi = dtiNewRoi([target_fg.name,'_fiberROI'], target_fg.colorRgb./255, unique(round(horzcat(endpts,startpts))','rows'));
                clear startpts endpts;
            end
            %get rid of an NaNs
            roi.coords=roi.coords(~isnan(roi.coords(:,1)),:);
            %Clean ROI if desired
            if dilate==1
                roi=dtiRoiClean(roi,3,{'dilate' 'fillHoles'});
            end
            if dilate==2
                roi=dtiRoiClean(roi,3,{'dilate' 'fillHoles'});
                roi=dtiRoiClean(roi,4,'dilate');
            end
            if dilate==3
                roi=dtiRoiClean(roi,3,{'dilate' 'fillHoles'});
                roi=dtiRoiClean(roi,4,'dilate');
                roi=dtiRoiClean(roi,5,'dilate');
            end

            %% Convert ROI to nifti image in MNI spae

            % transform ROI coords to MNI image space
            c = mrAnatXformCoords(ref.qto_ijk, roi.coords);
            c = round(c);
            roiIm = ref;
            roiIm.data = zeros(size(roiIm.data),'uint8');
            roiIm.data(sub2ind(size(roiIm.data), c(:,1), c(:,2), c(:,3))) = 1;
            %roiIm.fname = strcat(outFile,'.nii.gz');

            %% make a group combintion of all the images
            if ~exist('groupIm','var')
                groupIm=roiIm.data;
            else
                groupIm=groupIm+roiIm.data;
            end
        else
            fprintf('\n%s does not exist for subject %s\n',fgName,subCodes{ii})
            continue
        end

    end
end
%% Write group file
roiIm.data=groupIm;
roiIm.scl_slope=1;
roiIm.fname = [outName '.nii.gz'];
writeFileNifti(roiIm);

%% if you want to write thresholded maps for any reason
% roiIm.data=uint8(thresh40);
% roiIm.fname = fullfile(outDir,[outName  '55thresh40.nii.gz']);
% writeFileNifti(roiIm);
%
% roiIm.data=uint8(thresh45);
% roiIm.fname = fullfile(outDir,[outName '55thresh45.nii.gz']);
% writeFileNifti(roiIm);
%
% roiIm.data=uint8(halfSubs);
% roiIm.fname = fullfile(outDir,[outName  '55HalfSubs.nii.gz']);
% writeFileNifti(roiIm);


