function AFQ_exportDataMINDnodes(data1, data2, filename, property, sub_ids)
% Export AFQ results as text files that can be read into excel or spss.
% 
% AFQ_exportData(data1, data2, filename, property)
%
% Inputs:
% data1    = data output from AFQ
% data2    = another data output from AFQ
% filename = name of the file to write including the path
% property = a string denoting which diffusion property to plot. 
%             options are 'fa' 'rd' 'ad' 'md'
% sub_ids  = a cell array of subject names or a vector of subject numbers
%
% Example:
%
% [patient_data control_data] = AFQ_run(sub_dirs, sub_group); % See AFQ_run
% % Pull out the subject ids from each set of data
% sub_ids = sub_dirs
% % Export the data as a .csv to the AFQ data directory
% [AFQbase AFQdata] = AFQ_directories;
% AFQ_exportDataMINDnodes(patient_data, control_data, [AFQdata '/results'], 'fa', sub_ids);
%
% (c) Jason D. Yeatman, Vista Team, 4/3/2012
%

%Making the sub_ids variable prettier for MIND data structure
if length(char(sub_ids)) > 60
    %idx for preupgrades
    idx = 54:63;
    %idx = 39:48;
else
    %indx for postupgrades
    idx = 42:51;
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
    %Make sure there are as many sub_ids as there are rows in data
    if size(sub_ids,1) ~= size(data1(1).(property),1)
    %error('There must be a subject ID for each row of data')
    end
    
end

%% Writing the .csv files

% These are the names of the fiber groups.  Data columns will always be
% exported in this order
fgNames={'Left_Thalmic_Radiation','Right_Thalmic_Radiation','Left_Corticospinal','Right_Corticospinal', 'Left_Cingulum_Cingulate', 'Right_Cingulum_Cingulate'...
    'Left_Cingulum_Hippocampus','Right_Cingulum_Hippocampus', 'Callosum_Forceps_Major', 'Callosum_Forceps_Minor'...
    'Left_IFOF','Right_IFOF','Left_ILF','Right_ILF','Left_SLF','Right_SLF','Left_Uncinate','Right_Uncinate','Left_Arcuate','Right_Arcuate'};
dsheet1 = [];
dsheet2 = [];
% write out data for each fiber group for the first data array(data1) as a separate file
for jj = 1:length(data1)
    % Convert the data into a cell array
    dsheet1 = num2cell(data1(jj).(property));
    dsheet2 = num2cell(data2(jj).(property));
    % Stack the data1 and data2 columns vertically
    total = vertcat(dsheet1, dsheet2);
    % Add in the subject ids as the first column if they were supplied
    withids = horzcat(sub_ids, total);
    %Write out the spreadsheet containing both data1 and data2 node
    %scores for the specified property
    cell2csv([filename '_' fgNames{jj}, '_' property '.csv'], withids);
 end

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
