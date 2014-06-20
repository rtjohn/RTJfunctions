%% Rendering videos of the cortex and fiber tracts
%
% This tutorial will show how to render a mesh of the cortical surface and
% underlying fiber tracts and animate them in a video.  You need
% segmentation of the white matter (the higher the resolution the better)
% saved as a binary nifti image and .mat or .pdb files of the fiber tracts.
%
% Copyright Jason D. Yeatman November 2012

%% Load the example data

% Get AFQ directories
AFQdata = '/Users/Ryan/Documents/MATLAB/AFQ/data';
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


%[AFQbase AFQdata AFQfunc AFQutil AFQdoc AFQgui] = AFQ_directories;
% The subject's data is saved in the mesh directory
%sdir = fullfile(AFQdata,'mesh');
%cd(sdir);

dt = dtiLoadDt6(fullfile(sub_dirs{1},'dt6.mat'));

% Load up the manual segmentations of the left arcuate and inferior
% longitudinal fasciculus from Quench

fg = dtiReadFibers(fullfile(sub_dirs{1},'fibers','WholeBrainFG.mat'));

%arc = dtiLoadFiberGroup('L_Arcuate.pdb');
%ilf = dtiLoadFiberGroup('L_ILF.pdb');

% Remove the endpoints of the fibers so they don't show through the cortex.
% This is not necessary but I did not want the fibers to poke through the
% cortex.
for ii = 1:length(fg.fibers)
    fg.fibers{ii} = fg.fibers{ii}(:,5:end-5);
end

%% Render the fibers and cortex
% First we render the first fiber tract in a new figure window
%lightH = AFQ_RenderFibers(arc,'color',[0 .5 1],'numfibers',500,'newfig',1);

numfibers = 4185;
lightH = AFQ_RenderFibers(fg, 'radius', [.7 5], 'jittercolor', .1, 'numfibers', numfibers, 'cmap', white);

% Next add the other fiber tract to the same figure window
%AFQ_RenderFibers(ilf,'color',[1 .5 0],'numfibers',500,'newfig',0);

% Add a rendering of the cortical surface to the same figure.
% segmentation.nii.gz is a binary image with ones in every voxel that is
% white matter and zeros everywhere else
%p = AFQ_RenderCorticalSurface('segmentation.nii.gz', 'boxfilter', 5, 'newfig', 0);

cortex = fullfile(AFQdata,'mesh','segmentation.nii.gz');
[p, msh] = AFQ_RenderCorticalSurface(cortex, 'boxfilter', 5, 'newfig', 0);

% Delete the light object and put a new light to the right of the camera
delete(lightH);
lightH=camlight('right');
% Turn of the axes
axis('off');
colorbar('delete');

%% Make a video showing the cortex and underlying tracts

% These next lines of code perform the specific rotations that I desired
% and capture each rotation as a frame in the video. After each rotation we
% move the light so that it follows the camera and we set the camera view
% angle so that matlab maintains the same camera distance.

a = 1; % Start off with an alpha of 1
for ii = 1:10
    % Slowly make the cortex fade away
    a = a-.05;
    alpha(p,a);
    % Caputure the frame
    mov(ii)=getframe(gcf);
end
%alpha should be at .5 here

 for ii = 11:54
     a = a -0.015;
    % Don't let the alpha go below 0 (causes an error)
    if a < 0
        a = 0;
    end
    alpha(p,a);
    camorbit(0, 2);
    % Set the view angle so that the image stays the same size
    set(gca,'cameraviewangle',8);
    % Move the light to follow the camera
    camlight(lightH,'right');
    % Capture the current figure window as a frame in the video
    mov(ii)=getframe(gcf);
end;
%alpha should be at 0 here

for ii = 55:99 
    camorbit(-2,-2);
    set(gca,'cameraviewangle',8);
    camlight(lightH,'right');
    mov(ii)=getframe(gcf);
end;

for ii = 99:143
    camorbit(2,0);
    set(gca,'cameraviewangle',8);
    camlight(lightH,'right');
    mov(ii)=getframe(gcf);
end;

% Now that we are back to our starting point bring the cortex back
for ii = 144:178
    a = a+.05;
    if a > 1
        a = 1;
    end
    alpha(p,a);
    mov(ii)=getframe(gcf);
end

%% Save the movie as a .avi file to be played by any movie program

movie2avi(mov,'WhiteMatter.avi','compression','none','fps',15)


return

