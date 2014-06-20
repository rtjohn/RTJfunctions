function MIND_renderF(subject, tract_number, vector, crange, numNodes, color, cmap, radius)
    %MIND_renderF Renders a tract profile fro the MIND data set using a
    %vector of statistics
    % REQUIRED ARGUMENTS
    % subject -  the SSID of the subject you want to use
    % tract_number the index number (from below) of the tract you want
        % Fiber group index:
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
    % vector -  a vector of statistics you want plotted
    
    % OPTIONAL ARGUMENTS
    % numNodes - the number of nodes you want - MUST be the same length as
    % vector. DEFAULTS to length of vector
    % color -  a [] of 3 digits corresponding to [RGB] for the color of the
    % tract. DEFAULTS to purplish gray
    % cmap - which color scheme to use. DEFAULTS to 'hot'
    % radius - the size of the overlaid tube plto.  DEFAULTS to [.5 7]
    
% Check number of inputs.
    if nargin < 3 || nargin > 8
        error('MIND_renderF: Wrong number of Inputs. 3 are required(subject, tract_number, vetor) with 4 other optionals (numNodes, color, cmap, radius');
    end

    % Fill in unset optional values.
    switch nargin
        case 4
            numNodes = length(vector);
            color = [.3 .2 .4];
            cmap = 'hot';
            radius = [.5 7];
        case 5
            color = [.3 .2 .4];
            cmap = 'hot';
            radius = [.5 7];
        case 6
            cmap = 'hot';
            radius = [.5 7];
        case 7
            radius = [.5 7];
    end

    %Load the correct directories
    sub_dirs = '/Users/Ryan/Documents/MATLAB/AFQ/APPdata';

    %load the subject's dt6 and cleaned fiber groups
    dt = dtiLoadDt6(fullfile(sub_dirs, subject,'dti30', 'dt6.mat'));
    fg = dtiReadFibers(fullfile(sub_dirs, subject,'dti30','fibers','MoriGroups_clean_D5_L4.mat'));

    %calculate diffusion parameters at each node
    [fa md rd ad cl TractProfile] = AFQ_ComputeTractProperties(fg,dt,numNodes);

    %assign the statistics to the tract.pvals subitem
    TractProfile(tract_number).vals.pvals = vector;
    
    %fill in the specified parameters
  
    
    %render the tract
    AFQ_RenderFibers(fg(tract_number),'color',color,'tractprofile',TractProfile(tract_number),...
    'val','pvals','cmap',cmap,'crange',crange,'radius',radius);
    
    %make the graph look pretty
    
    axis off;
    xlim('auto');
    ylim('auto');
    zlim('auto');
    set(gca, 'box', 'off');
    
    filename = (inputname(3));
    saveas(gcf, filename);
    filename = [filename '.tiff'];
    saveas(gcf, filename, 'tiffn');
    
    
    
   
    
    
    
    









