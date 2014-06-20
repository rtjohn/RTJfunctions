function AFQ_exportDataMIND(data1, data2, filename, property, sub_ids)
% Export AFQ results as text files that can be read into excel or spss.
% 
% AFQ_exportData(data, filename, property)
%
% Inputs:
% data     = data output from AFQ
% filename = name of the file to write including the path
% property = a string denoting which diffusion property to plot. 
%             options are 'fa' 'rd' 'ad' 'md'
% sub_ids  = a cell array of subject names or a vector of subject numbers
%
% Example:
%
% [patient_data control_data] = AFQ_run(sub_dirs, sub_group); % See AFQ_run
% % Pull out the subject ids for the controls
% sub_ids = sub_dirs(logical(sub_group));
% % Export the data as a .csv to the AFQ data directory
% [AFQbase AFQdata] = AFQ_directories;
% AFQ_exportDataMIND(control_data, [AFQdata '/results'], 'fa', sub_ids);
%
% (c) Jason D. Yeatman, Vista Team, 4/3/2012
%

%Making the sub_ids variable prettier for MIND data structure
if length(char(sub_ids)) > 60
    idx = 54:63;
else
    idx = 42:51;
    %idx = 39:48;
end
for ii = 1:length(sub_ids)
    prettier{1,ii} = sub_ids{1,ii}(idx);
end
sub_ids = prettier;


%% Argument checking
if ~exist('property','var') || isempty(property)
    property = 'FA';
    % Check that the property was defined in the right case
elseif isfield(data1,lower(property))
    property = lower(property); 
elseif isfield(data1,upper(property))
    property = upper(property);
else
    error('Not a valid property')
end

if exist('sub_ids','var') && ~isempty(sub_ids)
    % Make sub_ids a column
    if size(sub_ids,2) > size(sub_ids,1)
        sub_ids = sub_ids';
    end
    % Make sure there are as many sub_ids as there are rows in data
    %if size(sub_ids,1) ~= size(data1(1).(property),1)
    %    error('There must be a subject ID for each row of data')
    %end
    
end

%% Writing the .csv files

% These are the names of the fiber groups
fgNames={'Left_Thalmic_Radiation','Right_Thalmic_Radiation','Left_Corticospinal','Right_Corticospinal', 'Left_Cingulum_Cingulate', 'Right_Cingulum_Cingulate'...
    'Left_Cingulum_Hippocampus','Right_Cingulum_Hippocampus', 'Callosum_Forceps_Major', 'Callosum_Forceps_Minor'...
    'Left_IFOF','Right_IFOF','Left_ILF','Right_ILF','Left_SLF','Right_SLF','Left_Uncinate','Right_Uncinate','Left_Arcuate','Right_Arcuate'};
% write out data for each fiber group as a separate file
dsheet1 = [];
dsheet2 = [];
for jj = 1:length(data1)
    %Create a column that contains an average score for each subject
    n = (data1(jj).(property));
    avg = mean(n,2);
    %q = horzcat(avg, n);
    % Convert the data into a cell array
    m = num2cell(avg);
    % Add in the subject ids as the first column if they were supplied
    % Write out the data file
    dsheet1 = horzcat(dsheet1,m);
end

for jj = 1:length(data2)
    %Create a column that contains an average score for each subject
    n = (data2(jj).(property));
    avg = mean(n,2);
    %q = horzcat(avg, n);
    % Convert the data into a cell array
    m = num2cell(avg);
    % Add in the subject ids as the first column if they were supplied
    % Write out the data file
    dsheet2 = horzcat(dsheet2,m);
end
    total = vertcat(dsheet1,dsheet2);
    withids = horzcat(sub_ids,total);

cell2csv([filename '_' property '.csv'], withids);

return

%% Origional less efficient code
% switch(property)
%     case 'fa'
%         for jj = 1:length(data)
%             csvwrite([filename '_' fgNames{jj} '_' property], data(jj).FA);
%         end
%     case 'rd'
%         for jj = 1:length(data)
%             csvwrite([filename '_' fgNames{jj} '_' property], data(jj).RD);
%         end
%     case 'ad'
%         for jj = 1:length(data)
%             csvwrite([filename '_' fgNames{jj} '_' property], data(jj).AD);
%         end
%     case 'md'
%         for jj = 1:length(data)
%             csvwrite([filename '_' fgNames{jj} '_' property], data(jj).MD);
%         end
% end
