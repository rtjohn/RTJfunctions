function [stdout] = Packing(STDIN, dimensions)

%% Check Inputs
if notDefined('max'), error('No max to specified');  end
if ~exist('dimensions', 'var') || isempty(dimensions), error('Must provide list of dimensions'); end





fid = fopen('STDIN.txt');
A = textscan(fid, '%f %f');d



for ii=1:length(STDIN)

needtofind first singledigit

firstinput = onlysingledigit

length  = firstinput



%%  Loop over every subject
for ii=1:length(dimensions)

if length(sub_group) ~= length(sub_dirs)
    error('Mis-match between subject group description and subject data directories');