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
smoothKernel = 4;

cd ('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/LeftCleaned');
theseFiles = dir('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/LeftCleaned/*.mat');

for k = 1:length(theseFiles);
    filename = theseFiles(k).name;
    fname = filename(2:end);
    movefile(filename, fname);
end

delete('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/LeftCleaned/L*.mat');
theseFiles = dir('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/LeftCleaned/*.mat');

for k = 1:length(theseFiles);
    filename = theseFiles(k).name;  
    [p,n,e] = fileparts(filename);
    fname = n;
    f = fullfile('/Volumes/data/APP/Projects/Amygdala/Amy_DTI', n);
    cd(f);
    if(~exist('ROIs','dir'));
        mkdir ROIs;
    end
    disp(['Processing ' fname ' Left ROI']);
    
    cd ('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/LeftCleaned')
    movefile (filename, f)
    cd(f)
    movefile (filename, 'ROIs')
    roiPath = fullfile((f), 'ROIs');
    cd(f);
    %cd('dti30trilinrt');
    %movefile ('dt6.mat', filename);
    %dt = load(filename);
    %cd(f);
    %cd('ROIs');
    
    %left ROI: load, clean,restrict, write
    LroiOldName = fname;
    LroiNewName = 'Lamy_cleaned';
    Lroi = dtiReadRoi(fullfile(roiPath, LroiOldName));
    Lroi = dtiRoiClean(Lroi, smoothKernel, 'fillhole removesat');
    Lroi.name = LroiNewName;
    dtiWriteRoi(Lroi, fullfile(roiPath,LroiNewName));
    %clear ic sz keep imgIndices keepCoordInd;
    
    %Exporting ROI Properties to a text file
    dt6Path = fullfile((f), 'dti30trilinrt', 'dt6.mat');
    LRoiPath = fullfile((f), 'ROIs', LroiNewName);
    [FA,MD,radialADC,axialADC] = dtiROIProperties(dt6Path, LRoiPath);
    fileID = fopen('Left_FA,MD,radialADC,axialADC.txt','a+');
    fprintf(fileID, '%s\t', fname);
    fprintf(fileID,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n', FA, MD, radialADC, axialADC);
    fclose(fileID);
    %x = int2str(fname);
    y = 'LeftGMDTI';
    dtifile = strcat(fname,y);
    movefile('Left_FA,MD,radialADC,axialADC.txt', dtifile);
    copyfile(dtifile, '/Volumes/data/APP/Projects/Amygdala/ROIFA/FAFiles');
    %Prints out values from ROI in this order: subject, FAmin, FAmean,
    %FAmax, MDmin, MDmen, MDmax, RadialADCmin, RadialADCmean, RadialADCmax,
    %AxialADCmin, AxialADCmean, AxialADCmax
end

clear all
cd ('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/RightCleaned');
theseFiles = dir('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/RightCleaned/*.mat');
smoothKernel = 3;

for k = 1:length(theseFiles);
    filename = theseFiles(k).name;
    fname = filename(2:end);
    movefile(filename, fname);
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
    disp(['Processing ' fname ' Right ROI']);
    
    cd ('/Volumes/data/APP/Projects/Amygdala/ROIFA/temporarystorage/RightCleaned')
    movefile (filename, f)
    cd(f)
    movefile (filename, 'ROIs')
    roiPath = fullfile((f), 'ROIs');
    cd(f);
    %cd('dti30trilinrt');
    %movefile ('dt6.mat', filename);
    %dt = load(filename);
    %cd(f);
    %cd('ROIs');
    
    %Right ROI: load, clean,restrict, write
    RroiOldName = fname;
    RroiNewName = 'Ramy_cleaned';
    Rroi = dtiReadRoi(fullfile(roiPath, RroiOldName));
    Rroi = dtiRoiClean(Rroi, smoothKernel, 'fillhole removesat');
    Rroi.name = RroiNewName;
    dtiWriteRoi(Rroi, fullfile(roiPath,RroiNewName));
    %clear ic sz keep imgIndices keepCoordInd;
    
    %Exporting ROI Properties to a text file
    dt6Path = fullfile((f), 'dti30trilinrt', 'dt6.mat');
    RRoiPath = fullfile((f), 'ROIs', RroiNewName);
    [FA,MD,radialADC,axialADC] = dtiROIProperties(dt6Path, RRoiPath);
    fileID = fopen('Right_FA,MD,radialADC,axialADC.txt','a+');
    fprintf(fileID, '%s\t', fname);
    fprintf(fileID,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n', FA, MD, radialADC, axialADC);
    fclose(fileID);
    %x = int2str(fname)
    y = 'RightGMDTI';
    dtifile = strcat(fname,y);
    movefile('Right_FA,MD,radialADC,axialADC.txt', dtifile);
    copyfile(dtifile, '/Volumes/data/APP/Projects/Amygdala/ROIFA/FAFiles');
    %Prints out valeus from ROI in this order: subject, FAmin, FAmean,
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
    f = fullfile('/Volumes/data/APP/Projects/Amygdala/Amy_DTI', fname, 'dti30trilinrt/ROIs');
    movefile(filename, f);
end    
    
fprintf('Cleaned ROIs have been moved to subjects DTI folder along with the Binary ROIs.  FA text files have been exported to the FAFiles folder')

exit