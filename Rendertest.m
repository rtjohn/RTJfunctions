function Rendertest(Subject, Tract, Target, Cmap, Combo)
%RENDERTEST 
%Summary of this function goes here

%Subject - individual whose tract you want to render
%Tract - AFQ tract identifying number
%Target - Specific array you want graphed
%Cmap - color map you want to use

%Example usage
%L_THR_TDFA = [1 2 3 4]
%L_THR_ASDFA = [4 3 2 1]
%L_THR_ASDmFA = [5 6 7 8]
%L_UNC_TDFA = [1 2 3 4]
%L_UNC_ASDFA = [4 3 2 1]
%L_UNC_ASDmFA = [5 6 7 8]
%Combo = vertcat(THR_TDFA, THR_ASDFA, THR_ASDmFA, UNC_TDFA, UNC_ASDFA, UNC_ASDmFA)
%Subject = 5;
%Tract = 1;
%Target = L_THR_ASDAD;
%Cmap = 'jet'
%Rendertest(Subject, Tract, Target, Cmap, Combo)

%Fiber group index:
% 1. Left Thalmic Radiation
% 2. Right Thalmic Radiation
% 3. Left Corticospinal
% 4. Right Corticospinal
% 5. Left Cingulum Cingulate
% 6. Right Cingulum Cingulate
% 7. Left Cingulum Hippocampus
% 8. Right Cingulum Hippocampus
% 9. Forceps Major
% 10. Forceps Minor
% 11. Left IFOF
% 12. Right IFOF
% 13. Left ILF
% 14. Right ILF
% 15. Left SLF
% 16. Right SLF
% 17. Left Uncinate
% 18. Right Uncinate
% 19. Left Arcuate
% 20. Right Arcuate

%Set color range based upon all tracts in the figure:
low = min(Combo(:));
high = max(Combo(:));
crange = [low high]
cmap = Cmap;

%Load the TD subjects files:
AFQdata = '/Users/Ryan/Documents/MATLAB/AFQ/APPdata';
sub_dirs = {[AFQdata '/110021-100/dti30']...
[AFQdata '/110024-100/dti30']...
[AFQdata '/108546-100/dti30']...
[AFQdata '/109776-100/dti30']...
[AFQdata '/109868-100/dti30']...
[AFQdata '/109956-100/dti30']...
[AFQdata '/109543-100/dti30']...
[AFQdata '/109568-100/dti30']...
[AFQdata '/109709-100/dti30']...
[AFQdata '/109775-100/dti30']...
[AFQdata '/109455-100/dti30']...
[AFQdata '/109470-100/dti30']...
[AFQdata '/109493-100/dti30']...
[AFQdata '/109092-100/dti30']...
[AFQdata '/108703-100/dti30']...
[AFQdata '/108755-100/dti30']...
[AFQdata '/108602-100/dti30']...
[AFQdata '/108676-100/dti30']...
[AFQdata '/108678-100/dti30']...
[AFQdata '/108681-100/dti30']...
[AFQdata '/108698-100/dti30']...
[AFQdata '/108243-300/dti30']};

%Read fibers from subject argument and load the same subject's dt6:
sub = Subject;
fg = dtiReadFibers(fullfile(sub_dirs{sub},'fibers','MoriGroups_clean_D5_L4.mat'));
dt = dtiLoadDt6(fullfile(sub_dirs{sub},'dt6.mat'));

%Specify the numbers of nodes and fibers and create Tractprofile array
numNodes = 99;
[fa md rd ad cl TractProfile] = AFQ_ComputeTractProperties(fg,dt,numNodes);

%Create an array containing the statistics of interest (probably F-values copy and pasted from SPSS)
dw = Target;

%Create a vals field in Tractprofile containing the transformed array
tr = Tract;
TractProfile(tr).vals.pvals = dw;

%Render the fiber with the profile
[p] = AFQ_RenderFibers(fg(tr),'color',[.3 .2 .4],'tractprofile',TractProfile(tr),'val','pvals','cmap',cmap,'crange',crange,'radius',[.5 7]);

%Turn off extra lines and save the figure
axis off;
xlim('auto');
ylim('auto');
zlim('auto');
set(gca, 'box', 'off');
%Names = {'L_THR','R_THR','L_CST','R_CST','L_CNG','R_CNG','LBAD','RBAD','FMa','Fmi','L_IFF','R_IFF','L_ILF','R_ILF','L_SLF','R_SLF','L_UNC','R_UNC','L_ARC','R_ARC'};
%tname = Names(tr);
dname = inputname(3);
fname = strcat(dname);
saveas(gcf, fname, 'tif')
saveas(gcf, fname, 'fig')
end

