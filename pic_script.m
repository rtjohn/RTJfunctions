%%
%This script should go through a list of endpoint files, create a figure
%with a brain mesh and endpoint overlay, save .tif images of 4 angles for
%each one.
pointdir = dir('/Users/Ryan/Documents/MATLAB/Densities2/*nii.gz'); 
pointlist = {pointdir.name};
thresh = 0.1;
crange = [1 3.5];
cortex = '/Users/Ryan/Documents/MATLAB/AFQ/data/mesh/segmentation.nii.gz';

%%Specify which endpoint files to load
for ii=1:length(pointlist)
    pointfile = fullfile('/Users/Ryan/Documents/MATLAB/Densities2',pointlist{ii});
    name = pointlist{ii};
    name = name(1:end-10);
    %%Create a mesh for the figure
    overlay = pointfile;
    p = AFQ_RenderCorticalSurface(cortex, 'overlay' , overlay, 'boxfilter', 5, 'crange', crange, 'thresh', thresh, 'cmap', 'white');
    %%Prepare the figure
    axis off;
    xlim('auto');
    ylim('auto');
    zlim('auto');
    set(gca, 'box', 'off');
    
    %Save left sagittal view
    L = 'L_';
    fname = strcat(L, name);
    saveas(gcf, fname, 'tif');
    
    %Save right saggital view
    rdir = [0 0 1];
    rotate(p, rdir, 180);
    R = 'R_';
    fname = strcat(R, name);
    saveas(gcf, fname, 'tif');
    rotate(p, rdir, -180);
    
    %Save bottom axial view
    rdir = [0 1 0];
    rotate(p, rdir, 90);
    rdir = [1 0 0];
    rotate(p, rdir, 90);
    B = 'B_';
    fname = strcat(B, name);
    saveas(gcf, fname, 'tif');
    rdir = [1 0 0];
    rotate(p, rdir, -90);
    rdir = [0 1 0];
    rotate(p, rdir, -90);
    
    %Save top axial view
    rdir = [0 1 0];
    rotate(p, rdir, -90);
    rdir = [1 0 0];
    rotate(p, rdir, 90);
    T = 'T_';
    fname = strcat(T, name);
    saveas(gcf, fname, 'tif');
    close(gcf);
end
    
   
  








