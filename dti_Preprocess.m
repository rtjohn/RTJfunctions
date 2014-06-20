% dti_Preprocess.m
%
% This script will read in a list of subjects (subCodeList) and run dtiInit
% (with tri-linear interpolation and robust tensor fitting) on each of
% those subjects. After this step, dtiRawFitTensor.m will be run with
% robust tensor fitting set to 'on', which implements the RESTORE
% algorithm.
% 
% The code assumes a few things:
% 1. All the subjectes directories are in the same directory (baseDir).
% 2. All subjects were scanned with the same protocol.
% 3. All dti data has been run through dcm2nii and is in the raw directory
%    with a raw dti nifti file name that ends with 001.nii.gz (let michael know
%    if this is not the case).
% 4. The t1 file is saved in a t1 directory. (eg.
%    subCode/t1/subCode_t1.nii.gz).
% 5. Assumed data structure. 
%    *subCode*/raw/*rawDtiData*.nii.gz
%    *subCode*/raw/*rawDtiData*.bvals
%    *subCode*/raw/*rawDtiData*.bvecs
%    *subCode*/t1/*subCode*t1.nii.gz
% 6. Should leave you with:
%    *subCode*/dti30trilin/dt6.mat...
%    *subCode*/dti30trilinrt/dt6.mat...
% 
% % Set the parameters for preprocessing. 
%     dwPrams                 = dtiInitParams;
%     dwParams.fitMethod      = 'lsrt'; 
%     dwParams.clobber        = 1;
%     dwParams.dt6BaseName    = outDir;
%     dwParams.phaseEncodeDir = 2;
%     dwParams.rotateBvecsWithCanXform = 1;
% % Run preprocessing. 
%     dtiInit(niftiRaw, t1, dwParams);
%
% HISTORY:
% 09.11.09 - LMP wrote the thing.
% 02.04.11 - LMP Added a call to dtiRawFixDcm2niiXform to fix the raw dti
%            nifti's xform.
% 12.20.11 - LMP changed preprocessing call to dtiInit.
% 01.05.12 - LMP changed the dwParams structure to rotate the bvecs with
%            the cannonical xform
% 10.10.12 - RTJ set it up for MIND data structure


%% Run Preprocessing From Beginning
baseDir = '/Volumes/data/data/APP/Images/DTI/';
subCodeList = '/Volumes/data/data/APP/Images/DTI/ProcessNow.txt';
subs = textread(subCodeList, '%s'); fprintf('\nWill process %d subjects...\n\n',numel(subs));

% Set params for preprocessing
outDir                  = 'dti30trilin';
dwParams                = dtiInitParams;
dwParams.fitMethod      = 'lsrt';
dwParams.clobber        = 1;
dwParams.dt6BaseName    = outDir;
dwParams.phaseEncodeDir = 2;
dwParams.rotateBvecsWithCanXform = 1;
%dwParams.excludeVols = 36;

%%
for ii=1:length(subs)
    disp(['Processing (' subs{ii} ')...']);
    
    subDir = fullfile(baseDir,subs{ii});
    rawDir = fullfile(subDir,'raw');
    t1Dir  = fullfile(subDir,'t1');
    
    cd(t1Dir);
    
    t1 = dir([subs{ii},'*t1.nii.gz']);
    t1 = fullfile(t1Dir,t1.name);
    
    cd(rawDir);
    
    % Assumes that the file with 001.nii.gz at the end is
    % the raw nifti file.
    nifti    = dir('*001.nii.gz');
    niftiRaw = fullfile(rawDir,nifti.name);
    
    if ~exist(fullfile(subDir,outDir),'file')
        try
            % Run preprocessing. 
            dtiInit(niftiRaw, t1, dwParams);
        catch ME
            fprintf('FAILURE. Check subject: %s\n\n',subs{ii});
        end
    else
        fprintf('Subject %s has already been processed!\n\n', subs{ii});
    end
end

disp('***DONE!***');

return

%%
% * No longer used * 
% dtiRawPreprocess(dwRawFileName, t1FileName, bvalue, gradDirsCode, clobber, dt6BaseName, assetFlag, numBootStrapSamples, eddyCorrect, excludeVols, bsplineInterpFlag, phaseEncodeDir))
% dtiRawFitTensor([dwRaw=uigetfile],[bvecsFile=uigetfile], [bvalsFile=uigetfile], [outBaseDir=uigetdir],[bootstrapParams=[]], [fitMethod='ls'],[adcUnits=dtiGuessAdcUnits], [xformToAcPc=dwRaw.qto_xyz])
% if ~exist(fullfile(subDir,outDir),'file')
%         try
%             outName = fullfile(subDir, outDir);
%             % Run initial preprocessing.
%             dtiRawPreprocess(niftiRaw, t1, [], [], true, outDir, [], [], [], [], false, 2);
%             [tmp outBaseDir] = fileparts(niftiRaw);
%             [junk outBaseDir] = fileparts(outBaseDir);
%             outBaseDir = fullfile(tmp,[outBaseDir,'_aligned_trilin']);
%             % fit the tensor again with the RESTORE method.
%             dtiRawFitTensor([outBaseDir '.nii.gz'], [outBaseDir '.bvecs'], [outBaseDir '.bvals'], [outName 'rt'], [], 'rt');
%         catch ME
%             disp('FAILED.');
%         end
%     else
%         disp(['This subject, ' subs{ii} ', has already been processed through dtiRawPreProcess.m']);
%         if exist(fullfile(subDir,outDir),'file') && ~exist(fullfile(subDir,[outDir 'rt']),'file')
%             disp(['Running RESTORE algorithm on ',subs{ii}, '!']);
%             try
%                 [tmp outBaseDir] = fileparts(niftiRaw);
%                 [junk outBaseDir] = fileparts(outBaseDir);
%                 outBaseDir = fullfile(tmp,[outBaseDir,'_aligned_trilin']);
%                 dtiRawFitTensor([outBaseDir '.nii.gz'], [outBaseDir '.bvecs'], [outBaseDir '.bvals'], [dt 'rt'], [], 'rt');
%             catch ME
%                 disp('FAILED.');
%             end
%         end
%     end