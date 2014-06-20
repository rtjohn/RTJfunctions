%
% This script will take a list of t1 nfti files specified in the
% subCodeList and saved in the t1Dir and modify the header so that the
% origin is set to [0,0,0]. The resulting file will also be saved in the
% t1Dir. 
% 
% Note: The subCodeList file should be a .txt file. If you would like to
% save the new files out with a different file name that reflects that the
% file has been fixed, uncomment line 35. 
%
%
% History: 
% 08.25.09 - LMP wrote the thing.
% 11.30.2009 -  RFD provided a fix for left/right flips not being accounted for in the header.
%
t1Dir = '/Volumes/data/data/APP/Images/DTI/t1_flip';
subCodeList = '/Volumes/data/data/APP/Images/DTI/t1flip.txt';

subCodeNifti = textread(subCodeList, '%s');
cd(t1Dir);

for ii=1:numel(subCodeNifti);

    ni = readFileNifti(subCodeNifti{ii});
    % NOTE: Assume that data are left-right flipped:
    % original scale = [-ni.pixdim(1) ni.pixdim(2:3)];
    scale = [ni.pixdim(1) ni.pixdim(2:3)];
    origin = [ni.dim(1)+1-91 127 73];

    ni = niftiSetQto(ni, inv(affineBuild(origin, [0 0 0], scale)), true);
    
    disp(['Processing ' subCodeNifti{ii}]);

    % We only modify the header, so it is safe to overwrite the original. But if you want to
    % save the header-fixed version in a different file, set the filename here:
    %ni.fname = [fixed_' ni.fname];

    writeFileNifti(ni);
end

disp('Origin reset and hemispheres flipped')
exit
