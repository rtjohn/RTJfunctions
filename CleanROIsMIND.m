% adjust ROIs for new dt6s
%load each dt6, get FA data too, load the L_new, ROcc_new rois, edit
%ROI: dilate with a 3mm kernel+fill holes, and then restrict to FA>0.2
%save new ROI as LOcc_adjusted, ROcc_adjusted. 
%track fibers from each ROI and save fiber groups.
%
% 20050423 mbs wrote it
% 20120302 RTJ made it fit MIND APP filestructure, changed clean settings

%params for restrict and smooth old ROI
%faThresh = 0.2;
smoothKernel = 3;

cd ('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/LeftCleaned');
theseFiles = dir('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/LeftCleaned/*.mat');

for k = 1:length(theseFiles);
    filename = theseFiles(k).name;
    fname = filename(2:end);
    save(fname);
end

delete('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/LeftCleaned/L*.mat');
theseFiles = dir('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/LeftCleaned/*.mat');

for k = 1:length(theseFiles);
    filename = theseFiles(k).name;  
    [p,n,e] = fileparts(filename);
    fname = n
    f = fullfile('/Volumes/data/APP/Projects/Amygdala/Amy_DTI', n)
    cd(f)
    if(~exist('ROIs','dir'));
        mkdir ROIs;
    end
    disp(['Processing ' fname ' Left ROI']);

    cd ('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/LeftCleaned')
    movefile (filename, f)
    cd(f)
    movefile (filename, 'ROIs')
    roiPath = fullfile((f), 'ROIs')
    %fiberPath = fullfile((f), 'fibers');
    cd(f);
    cd('dti30trilinrt');
    movefile ('dt6.mat', filename);
    %dt = load(filename);
    cd(f);
    cd('ROIs');
    %dt.dt6(isnan(dt.dt6)) = 0;
    %dt.xformToAcPc = dt.anat.xformToAcPc*dt.xformToAnat;
    %[eigVec, eigVal] = dtiSplitTensor(dt.dt6);
    %clear eigVec;
    %fa = dtiComputeFA(eigVal);
    %clear eigVal;
    
    %left ROI: load, clean,restrict, write
    %clean the left ROI
    LroiOldName = fname;
    LroiNewName = 'Lamy_cleaned';
    fullfile(roiPath, LroiOldName)
    Lroi = dtiReadRoi(fullfile(roiPath, LroiOldName))
    Lroi = dtiRoiClean(Lroi, smoothKernel, {'fillhole'}, {'removesat'});
    %restrict to fa thresh
    %ic = mrAnatXformCoords(inv(dt.xformToAcPc), Lroi.coords);% 
    %sz = size(fa);
    %ic = round(ic);
    %first throw out any coords that's outside the frame
    %keep = ic(:,1)>1 & ic(:,1)<=sz(1) & ic(:,2)>1 & ic(:,2)<=sz(2) & ic(:,3)>1 & ic(:,3)<=sz(3);
    %ic = ic(keep,:);
    %Lroi.coords = Lroi.coords(keep,:);
    %imgIndices = sub2ind(sz, ic(:,1), ic(:,2), ic(:,3));
    %keepCoordInd = fa(imgIndices)>=faThresh;
    %Lroi.coords = Lroi.coords(keepCoordInd, :);
    Lroi.name = LroiNewName;
    dtiWriteRoi(Lroi, fullfile(roiPath,LroiNewName));
    %clear ic sz keep imgIndices keepCoordInd;

    %Lfg = dtiFiberTrack(dt.dt6, Lroi.coords, dt.mmPerVox, dt.xformToAcPc, LroiNewName,opts);
    %Rfg = dtiFiberTrack(dt.dt6, Rroi.coords, dt.mmPerVox, dt.xformToAcPc, RroiNewName,opts);
    %dtiWriteFiberGroup(Lfg, fullfile(fiberPath, Lfg.name), 1, 'acpc');
    %dtiWriteFiberGroup(Rfg, fullfile(fiberPath, Rfg.name), 1, 'acpc');
    %clear Lfg Rfg Lroi Rroi;
    
    %Exporting ROI Properties to a text file
    [FA,MD,radialADC,axialADC] = dtiROIProperties('dti30trilinrt/dt6.mat', LroiNewName);
    fileID = fopen('Left_FA,MD,radialADC,axialADC.txt','w+');
    fprintf(fileID, '%s\t', fname);
    fprintf(fileID,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n', FA, MD, radialADC, axialADC);
    fclose(fileID);
    copyfile('Left_FA,MD,radialADC,axialADC.txt', '/Volumes/data/APP/Projects/Amygdala/ROIFA/FAFiles')
    %Prints out valeus from ROI in this order: subject, FAmin, FAmean,
    %FAmax, MDmin, MDmen, MDmax, RadialADCmin, RadialADCmean, RadialADCmax,
    %AxialADCmin, AxialADCmean, AxialADCmax
end 

clear all

cd ('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/RightCleaned');
theseFiles = dir('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/RightCleaned/*.mat');

for k = 1:length(theseFiles);
    filename = theseFiles(k).name;
    fname = filename(2:end);
    save(fname);
end

delete('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/RightCleaned/R*.mat');
theseFiles = dir('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/RightCleaned/*.mat');


for k = 1:length(theseFiles);
    filename = theseFiles(k).name;
    [p,n,e] = fileparts(filename);
    fname = n;
    f = fullfile('/Volumes/data/APP/Projects/Amygdala/Amy_DTI', n);
    cd(f);
    if(~exist('ROIs','dir'));
        mkdir ROIs;
    end
    disp(['Processing ' fname 'Right ROI']);
     
    cd ('/Volumes/data/APP/Projects/Amygdala/ROIFA/BinaryROIs/temporarystorage/RightCleaned');
    movefile (fname, f)
    movefile (fname, 'ROIs');
    roiPath = fullfile((f), 'ROIs');
    %fiberPath = fullfile((f), 'fibers');
    cd('dti30trilinrt');
    movefile ('dt6.mat',filename);
    %dt = load(filename);
    cd(f);
    cd('ROIs');
    %dt.dt6(isnan(dt.dt6)) = 0;
    %dt.xformToAcPc = dt.anat.xformToAcPc*dt.xformToAnat;
    %[eigVec, eigVal] = dtiSplitTensor(dt.dt6);
    %clear eigVec;
    %fa = dtiComputeFA(eigVal);
    %clear eigVal;
    
    %left ROI: load, clean,restrict, write
    %clean the left ROI
    RroiOldName = fname;
    RroiNewName = 'Ramy_cleaned';
    Rroi = dtiReadRoi(fullfile(roiPath,RroiOldName));
    Rroi = dtiRoiClean(Rroi, smoothKernel, {'fillhole'}, {'removesat'});
    %restrict to fa thresh
    %ic = mrAnatXformCoords(inv(dt.xformToAcPc), Lroi.coords);% 
    %sz = size(fa);
    %ic = round(ic);
    %first throw out any coords that's outside the frame
    %keep = ic(:,1)>1 & ic(:,1)<=sz(1) & ic(:,2)>1 & ic(:,2)<=sz(2) & ic(:,3)>1 & ic(:,3)<=sz(3);
    %ic = ic(keep,:);
    %Lroi.coords = Lroi.coords(keep,:);
    %imgIndices = sub2ind(sz, ic(:,1), ic(:,2), ic(:,3));
    %keepCoordInd = fa(imgIndices)>=faThresh;
    %Lroi.coords = Lroi.coords(keepCoordInd, :);
    Rroi.name = RroiNewName;
    dtiWriteRoi(Rroi, fullfile(roiPath,RroiNewName));
    %clear ic sz keep imgIndices keepCoordInd;

    %Lfg = dtiFiberTrack(dt.dt6, Lroi.coords, dt.mmPerVox, dt.xformToAcPc, LroiNewName,opts);
    %Rfg = dtiFiberTrack(dt.dt6, Rroi.coords, dt.mmPerVox, dt.xformToAcPc, RroiNewName,opts);
    %dtiWriteFiberGroup(Lfg, fullfile(fiberPath, Lfg.name), 1, 'acpc');
    %dtiWriteFiberGroup(Rfg, fullfile(fiberPath, Rfg.name), 1, 'acpc');
    %clear Lfg Rfg Lroi Rroi;
    
    %Exporting ROI Properties to a text file
    [FA,MD,radialADC,axialADC] = dtiROIProperties('dti30trilinrt/dt6.mat', RroiNewName);
    fileID = fopen('Right_FA,MD,radialADC,axialADC.txt','w+');
    fprintf(fileID, '%s\t', fname);
    fprintf(fileID,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n', FA, MD, radialADC, axialADC);
    fclose(fileID);
    copyfile('Right_FA,MD,radialADC,axialADC.txt', '/Volumes/data/APP/Projects/Amygdala/ROIFA/FAFiles')
    %Prints out values from ROI in this order: subject, FAmin, FAmean,
    %FAmax, MDmin, MDmen, MDmax, RadialADCmin, RadialADCmean, RadialADCmax,
    %AxialADCmin, AxialADCmean, AxialADCmax
end 

clear all

%Below is simply cleaning out the Binary ROIs folder by moving the .nii
%ROIs to their correct subject folder
cd ('/Volumes/data/APP/Projects/Amygdala/ROIFA/BinaryROIs');
sortFiles = dir('/Volumes/data/APP/Projects/Amygdala/ROIFA/BinaryROIs/*.nii');

for k = 1:length(sortFiles);
    filename = sortFiles(k).name;
    [p,n,e] = fileparts(filename);
    fname = n(2:end);
    f = fullfile('/Volumes/data/APP/Projects/Amygdala/Amy_DTI', fname)
    movefile (k, f)
    cd(f)
    movefile (k,'ROIs')
end

fprintf('Cleaned ROIs have been moved to subjects DTI folder and FA text files have been exported to FAFiles folder')
