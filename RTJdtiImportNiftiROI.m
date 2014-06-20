function roi = RTJdtiImportNiftiROI
% 
% roi = dtiImportRoiFromNifti(roi_img, [outFile])
% 
% Creates a mrDiffusion ROI structure from a binary NIFTI image and saves
% that structure to disk if the user supplies 'outFile'
% 
% INPUTS:
%       roi_img - path to a nifti ROI
%       outFile - file name for the new .mat ROI. Note: all filenames 
%                 should have prefixes only. IF this variable is not
%                 defined the ROI will not be saved to disk, it will only
%                 be returned. 
% 
% OUTPUTS:
%       roi     - mrDiffusion ROI structure. 
% 
% 
% EXAMPLE USAGE:
%       roi_img = '/path/to/niftiRoi.nii.gz';
%       outFile = 'niftiRoiName';
%       roi = dtiImportRoiFromNifti(roi_img, outFile);
% 
% 
% WEB RESOURCES:
%       mrvBrowseSVN('dtiImportRoiFromNifti');
% 
% 
% (C) Stanford University, VISTA LAB 
% 

% HISTORY:
% 2008.04.21 ER wrote it.
% 2012.02.21 RTJ batched it and set it up for MIND database structure.
% Also fixed(?) error in naming ROI


%% 

% NIFTI filename 
cd '/Volumes/data/data/APP/Projects/Amygdala/ROIFA/temporarystorage';
bmpFiles = dir('/Volumes/data/data/APP/Projects/Amygdala/ROIFA/temporarystorage/*.nii');

for k = 1:length(bmpFiles);
    filename = bmpFiles(k).name;
    roi_img = filename;
    roiImg = readFileNifti(roi_img); %has to be in '12345' format then it works

    % Pull out the coordinates from roiImg.data
    [x1,y1,z1] = ind2sub(size(roiImg.data), find(roiImg.data));

    % Initialize roi structrue
    name = filename;
    %roi_img.fname,'short');
    roi  = dtiNewRoi(prefix(name));

    % Xform the coordianates based on the Xform in the nifti image
    roi.coords = mrAnatXformCoords(roiImg.qto_xyz, [x1,y1,z1]);
    
    % Save the nifti if the user passed in outFile
    dtiWriteRoi(roi, filename);
    fprintf('Saved %s \n',filename);
    renamefile(filename,'.nii','.mat')
end

fprintf('You should now have a bunch of .mat files in temporary storage')

exit

