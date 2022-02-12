%% DATA INDEXES
%{
1 Time (s)
2 ESC signal (µs)
3 AccX (g)
4 AccY (g)
5 AccZ (g)	
6 Torque (N·m)
7 Thrust (N)
8 Voltage (V)
9 Current (A)	
10 Motor Electrical Speed (RPM)
11 Electrical Power (W)
12 Mechanical Power (W)
13 Motor Efficiency (%)
14 Propeller Mech. Efficiency (N/W)	
15 OverallEfficiency (N/W)
16 Left Load Cell (mV)
17 Right Load Cell (mV)	
18 Thrust Load Cell (mV)
19 Vibration (g)
20 Burst Current Cutoff (A)	
21 Pin State 1
22 Pin State 2
23 Pin State 3
24 Pin State 4
%}

%% INIT - DO NOT MODIFY
clc, close all

% Silence annoying warnings
warning('off','MATLAB:handle_graphics:exceptions:SceneNode')
warning('off','MATLAB:table:ModifiedAndSavedVarnames')

% Check for first time (clean) running
if exist('first_time_ran','var') == 1
else
    first_time_ran = 1;
end

% Keep certain variables between runs
clearvars -except first_time_ran cf_12_38 cf_12_38_table pl_12_38 pl_12_38_table cf_15_5 cf_15_5_table pl_10_6 pl_10_6_table pl_10_5 pl_10_5_table plot_12_38_cf plot_12_38_pl plot_15_5_cf plot_10_6_pl plot_10_5_pl blue orange yellow purple green turquoise red y n x y1

%% LOADING
if first_time_ran == 1 % Checking if csv loading needed
    % Load 12x3.8 CF
    cf_12_38_table = readtable("RampTest_2022-02-11_140453_12x3.8.csv");
    cf_12_38 = xlsread("RampTest_2022-02-11_140453_12x3.8.csv");

    % Load 12x3.8 Plastic
    pl_12_38 = xlsread("RampTest_2022-02-11_143406_12x3.8_plastic.csv");
    pl_12_38_table = readtable("RampTest_2022-02-11_143406_12x3.8_plastic.csv");

    % Load 15x5
    cf_15_5 = xlsread("RampTest_2022-02-11_141816_15x5.csv");
    cf_15_5_table = readtable("RampTest_2022-02-11_141816_15x5.csv");

    % Load 10x6
    pl_10_6 = xlsread("RampTest_2022-02-11_151547_10x6_plastic.csv");
    pl_10_6_table = readtable("RampTest_2022-02-11_151547_10x6_plastic.csv");

    % Load 10x5
    pl_10_5 = xlsread("RampTest_2022-02-11_152214_10x5.csv");
    pl_10_5_table = readtable("RampTest_2022-02-11_152214_10x5.csv");

    %% Remove dud columns
    % Removing Servo columns from all csvs with no data
    for i = 1:3
        cf_12_38(:,3) = [];
        cf_12_38_table(:,3) = [];

        pl_12_38(:,3) = [];
        pl_12_38_table(:,3) = [];

        cf_15_5(:,3) = [];
        cf_15_5_table(:,3) = [];

        pl_10_6(:,3) = [];
        pl_10_6_table(:,3) = [];

        pl_10_5(:,3) = [];
        pl_10_5_table(:,3) = [];
    end

    % Removing Motor Optical Speed (RPM) from all csvs with no data
    cf_12_38(:,11) = [];
    cf_12_38_table(:,11) = [];
    pl_12_38(:,11) = [];
    pl_12_38_table(:,11) = [];
    cf_15_5(:,11) = [];
    cf_15_5_table(:,11) = [];
    pl_10_6(:,11) = [];
    pl_10_6_table(:,11) = [];
    pl_10_5(:,11) = [];
    pl_10_5_table(:,11) = [];

    % Removing Debug columns from all csvs with no data
    for i = 1:4
        cf_12_38(:,25) = [];
        cf_12_38_table(:,25) = [];

        pl_12_38(:,25) = [];
        pl_12_38_table(:,25) = [];

        cf_15_5(:,25) = [];
        cf_15_5_table(:,25) = [];

        pl_10_6(:,25) = [];
        pl_10_6_table(:,25) = [];

        pl_10_5(:,25) = [];
        pl_10_5_table(:,25) = [];
    end
    
    %% COLOURS
    blue = [0 0.4470 0.7410];           % Used for 12x3.8 CF
    orange = [0.8500 0.3250 0.0980];    % Used for 12x3.8 PL
    yellow = [0.9290 0.6940 0.1250];    % Used for 15x5
    purple = [0.4940 0.1840 0.5560];    % Used for 10x6
    green = [0.4660 0.6740 0.1880];     % Used for 10x5
    turquoise = [0.3010 0.7450 0.9330]; % Unused
    red = [0.6350 0.0780 0.1840];       % Unused
    
    y = 'ye'; n = 'no'; % yes and no :^)
end

%% PLOT MAIN GRAPH
if first_time_ran == 0
    saved_state = input('Same inputs as last time? y/n '); % If yes, keep values for ease of use
else
    saved_state = 'no';
end
if saved_state == 'no' %#ok<*BDSCA> % Occurs on first time use or user change
    if first_time_ran == 1
        % Query all prop plots - first time ran
        plot_12_38_cf = input('Plot 12x3.8 CF? y/n ');
        plot_12_38_pl = input('Plot 12x3.8 PL? ');
        plot_15_5_cf  = input('Plot 15x5? ');
        plot_10_6_pl = input('Plot 10x6? ');
        plot_10_5_pl = input('Plot 10x5? ');
    else
        % Query if user wants to keep the same props - if yes, skip
        if input('Same props as last time? y/n ') == 'no'
            plot_12_38_cf = input('Plot 12x3.8 CF? y/n ');
            plot_12_38_pl = input('Plot 12x3.8 PL? ');
            plot_15_5_cf  = input('Plot 15x5? ');
            plot_10_6_pl = input('Plot 10x6? ');
            plot_10_5_pl = input('Plot 10x5? ');
        end
    end
    if first_time_ran == 1
        % Query all indexes - first time ran
        x = input('x index ');
        y1 = input('y index ');
    else
        % Query if user wants to keep the same indexes - if yes, skip
        if input('Same indexes as last time? y/n ') == 'no'
            x = input('x index ');
            y1 = input('y index ');
        end
    end
end

% Does user want animated plot? Yes(1) No(2) - This is placed here to prevent needless alt-tabbing
if input('Animated plot? This might take a long time to complete! DO NOT take screenshots of this, use the proper graph (left) instead y/n ') == y
    anim_plot = 'ye';
else
    anim_plot = 'no';
end

% Initialise axes ranges and legend array
min_x = []; max_x = []; min_y = []; max_y = []; legendTitle = cell(1,1);

if plot_12_38_cf == 'ye' % Passes if user selected to plot 12x3.8 CF
    % Adds local x/y min/max to the global axes ranges
    min_x(end+1,1) = min(cf_12_38(23:end,x));
    max_x(end+1,1) = max(cf_12_38(23:end,x));
    min_y(end+1,1) = min(cf_12_38(23:end,y1));
    max_y(end+1,1) = max(cf_12_38(23:end,y1));
    legendTitle{end+1} = '12x3.8 CF';
end
if plot_12_38_pl == 'ye' % Passes if user selected to plot 12x3.8 PL
    min_x(end+1,1) = min(pl_12_38(23:end,x));
    max_x(end+1,1) = max(pl_12_38(23:end,x));
    min_y(end+1,1) = min(pl_12_38(23:end,y1));
    max_y(end+1,1) = max(pl_12_38(23:end,y1));
    legendTitle{end+1} = '12x3.8 PL';
end
if plot_15_5_cf  == 'ye' % Passes if user selected to plot 15x5
    min_x(end+1,1) = min(cf_15_5(23:end,x));
    max_x(end+1,1) = max(cf_15_5(23:end,x));
    min_y(end+1,1) = min(cf_15_5(23:end,y1));
    max_y(end+1,1) = max(cf_15_5(23:end,y1));
    legendTitle{end+1} = '15x5    CF';
end
if plot_10_6_pl  == 'ye' % Passes if user selected to plot 10x6
    min_x(end+1,1) = min(pl_10_6(23:end,x));
    max_x(end+1,1) = max(pl_10_6(23:end,x));
    min_y(end+1,1) = min(pl_10_6(23:end,y1));
    max_y(end+1,1) = max(pl_10_6(23:end,y1));
    legendTitle{end+1} = '10x6    PL';
end
if plot_10_5_pl  == 'ye' % Passes if user selected to plot 10x5
    min_x(end+1,1) = min(pl_10_5(23:end,x));
    max_x(end+1,1) = max(pl_10_5(23:end,x));
    min_y(end+1,1) = min(pl_10_5(23:end,y1));
    max_y(end+1,1) = max(pl_10_5(23:end,y1));
    legendTitle{end+1} = '10x5    PL';
end

% Find global x/y min/max for figure axes
min_x = min(min_x); max_x = max(max_x); min_y = min(min_y); max_y = max(max_y);
legendTitle(1) = []; % Delete blank first cell when initialised

% Initialises figure and scales to computer resolution, x=50 y=100 w=1200 h=1000
figure('Units','pixels','Position',[50 100 1200 1000])
hold on

if plot_12_38_cf == 'ye' % Passes if user selected to plot 12x3.8 CF
    % Plots starting from idx 23 to account for erroneous data
    plot(cf_12_38(23:end,x), cf_12_38(23:end,y1), 'color', blue)
end
if plot_12_38_pl == 'ye' % Passes if user selected to plot 12x3.8 PL
    plot(pl_12_38(23:end,x), pl_12_38(23:end,y1), 'color', orange)
end
if plot_15_5_cf  == 'ye' % Passes if user selected to plot 15x5
    plot(cf_15_5(23:end,x), cf_15_5(23:end,y1), 'color', yellow)
end
if plot_10_6_pl  == 'ye' % Passes if user selected to plot 10x6
    plot(pl_10_6(23:end,x), pl_10_6(23:end,y1), 'color', purple)
end
if plot_10_5_pl  == 'ye' % Passes if user selected to plot 10x5
    plot(pl_10_5(23:end,x), pl_10_5(23:end,y1), 'color', green)
end

% Labels the axes with current selection from the csv table
xlabel(cf_12_38_table.Properties.VariableNames{x})
ylabel(cf_12_38_table.Properties.VariableNames{y1})

% Creates a legend at a location without data
legend(legendTitle, 'location', 'best');

set(gcf,'color','w') % Sets the background white
set(gca,'FontSize',18) % Increases font size for readability
grid on % Turns on grid for visibility
hold off


%% ANIMATED PLOT
if anim_plot == 'ye' % Passes if user selected to plot the animated figure
%         scatter(cf_12_38(:,x), cf_12_38(:,y), 1, 'filled') % SCATTER PLOT
%         xlabel(cf_12_38_table.Properties.VariableNames{x})
%         ylabel(cf_12_38_table.Properties.VariableNames{y})
%         axis([min_x, max_x, min_y, max_y])

        % Initialises figure and scales to computer resolution, x=50 y=100 w=1200 h=1000
        figure('Units','pixels','Position',[1280 100 1200 1000])
        set(gcf,'color','w') % Sets the background white
        set(gca,'FontSize',18) % Increases font size for readability
        grid on % Turns on grid for visibility
        
        h  = animatedline('color', blue);   % Used for 12x3.8 CF
        h2 = animatedline('color', orange); % Used for 12x3.8 PL
        h3 = animatedline('color', yellow); % Used for 15x5
        h4 = animatedline('color', purple); % Used for 10x6
        h5 = animatedline('color', green);  % Used for 10x5
        
        % Labels the axes with current selection from the csv table
        xlabel(cf_12_38_table.Properties.VariableNames{x})
        ylabel(cf_12_38_table.Properties.VariableNames{y1})
        
        % Constrains the axes to visible data
        axis([min_x, max_x, min_y, max_y])
        
        % Start looping for each datapoint
        % Starting from idx 23 to account for erroneous data
        for i = 23:length(cf_15_5(23:end,1))
            if plot_12_38_cf == 'ye' % Passes if user selected to plot 12x3.8 CF
                addpoints(h, cf_12_38(i,x), cf_12_38(i,y1)) % Adds the datapoint to the animatedline array
            end
            if plot_12_38_pl == 'ye' % Passes if user selected to plot 12x3.8 PL
                addpoints(h2, pl_12_38(i,x), pl_12_38(i,y1))
            end
            if plot_15_5_cf  == 'ye' % Passes if user selected to plot 15x5
                addpoints(h3, cf_15_5(i,x), cf_15_5(i,y1))
            end
            if plot_10_6_pl  == 'ye' % Passes if user selected to plot 10x6
                addpoints(h4, pl_10_6(i,x), pl_10_6(i,y1))
            end
            if plot_10_5_pl  == 'ye' % Passes if user selected to plot 10x5
                addpoints(h5, pl_10_5(i,x), pl_10_5(i,y1))
            end
            drawnow update % Draws the current datapoint on the figure
            pause(0.003) % Adjust for faster or slower drawing speed
        end
end

%%END
first_time_ran = 0; % Unsets first runtime flag
