%% INDEXES
% 1 Time (s)
% 2 ESC signal (µs)
% 3 AccX (g)
% 4 AccY (g)
% 5 AccZ (g)	
% 6 Torque (N·m)
% 7 Thrust (N)
% 8 Voltage (V)
% 9 Current (A)	
% 10 Motor Electrical Speed (RPM)
% 11 Electrical Power (W)
% 12 Mechanical Power (W)
% 13 Motor Efficiency (%)
% 14 Propeller Mech. Efficiency (N/W)	
% 15 OverallEfficiency (N/W)
% 16 Left Load Cell (mV)
% 17 Right Load Cell (mV)	
% 18 Thrust Load Cell (mV)
% 19 Vibration (g)
% 20 Burst Current Cutoff (A)	
% 21 Pin State 1
% 22 Pin State 2
% 23 Pin State 3
% 24 Pin State 4

clc, close all

if exist('first_time_ran','var') == 1
else
    first_time_ran = 1;
end

clearvars -except first_time_ran cf_12_38 cf_12_38_table pl_12_38 pl_12_38_table cf_15_5 cf_15_5_table pl_10_6 pl_10_6_table pl_10_5 pl_10_5_table plot_12_38_cf plot_12_38_pl plot_15_5_cf plot_10_6_pl plot_10_5_pl blue orange yellow purple green turquoise red y n x y

%% MAIN
if first_time_ran == 1
    cf_12_38_table = readtable("RampTest_2022-02-11_140453_12x3.8.csv");
    cf_12_38 = xlsread("RampTest_2022-02-11_140453_12x3.8.csv");

    pl_12_38 = xlsread("RampTest_2022-02-11_143406_12x3.8_plastic.csv");
    pl_12_38_table = readtable("RampTest_2022-02-11_143406_12x3.8_plastic.csv");

    cf_15_5 = xlsread("RampTest_2022-02-11_141816_15x5.csv");
    cf_15_5_table = readtable("RampTest_2022-02-11_141816_15x5.csv");

    pl_10_6 = xlsread("RampTest_2022-02-11_151547_10x6_plastic.csv");
    pl_10_6_table = readtable("RampTest_2022-02-11_151547_10x6_plastic.csv");

    pl_10_5 = xlsread("RampTest_2022-02-11_152214_10x5.csv");
    pl_10_5_table = readtable("RampTest_2022-02-11_152214_10x5.csv");

    %% Remove dud columns
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

    for i = 1:4
        cf_12_38(:,25) = [];
        cf_12_38_table(:,25) = [];

        pl_12_38(:,25) = [];
        pl_12_38_table(:,25) = [];

        cf_15_5(:,25) = [];
        cf_15_5_table(:,25) = [];

        pl_10_6(:,25) = [];
        pl_10_6_table(:,25) = [];

        pl_10_5(:,3) = [];
        pl_10_5_table(:,25) = [];
    end
    
    %% COLOURS
    blue = [0 0.4470 0.7410];
    orange = [0.8500 0.3250 0.0980];
    yellow = [0.9290 0.6940 0.1250];
    purple = [0.4940 0.1840 0.5560];
    green = [0.4660 0.6740 0.1880];
    turquoise = [0.3010 0.7450 0.9330];
    red = [0.6350 0.0780 0.1840];
    
    y = 'ye'; n = 'no';
end

%% Plot graphs
if first_time_ran == 0
    saved_state = input('Same inputs as last time? y/n ');
else
    saved_state = 'no';
end
if saved_state == 'no' %#ok<*BDSCA>
    if input('Same props as last time? y/n ') == 'no'
        plot_12_38_cf = input('Plot 12x3.8 CF? y/n ');
        plot_12_38_pl = input('Plot 12x3.8 PL? ');
        plot_15_5_cf  = input('Plot 15x5? ');
        plot_10_6_pl = input('Plot 10x6? ');
        plot_10_5_pl = input('Plot 10x5? ');
    end
    if input('Same indexes as last time? y/n ') == 'no'
        x = input('x index '); % 11
        y = input('y index '); % 7
    end
end

min_x = []; max_x = []; min_y = []; max_y = []; legendTitle = cell(1,1);
if plot_12_38_cf == 'ye'
    min_x(end+1,1) = min(cf_12_38(23:end,x));
    max_x(end+1,1) = max(cf_12_38(23:end,x));
    min_y(end+1,1) = min(cf_12_38(23:end,y));
    max_y(end+1,1) = max(cf_12_38(23:end,y));
    legendTitle{end+1} = '12x3.8 CF';
end
if plot_12_38_pl == 'ye'
    min_x(end+1,1) = min(pl_12_38(23:end,x));
    max_x(end+1,1) = max(pl_12_38(23:end,x));
    min_y(end+1,1) = min(pl_12_38(23:end,y));
    max_y(end+1,1) = max(pl_12_38(23:end,y));
    legendTitle{end+1} = '12x3.8 PL';
end
if plot_15_5_cf  == 'ye'
    min_x(end+1,1) = min(cf_15_5(23:end,x));
    max_x(end+1,1) = max(cf_15_5(23:end,x));
    min_y(end+1,1) = min(cf_15_5(23:end,y));
    max_y(end+1,1) = max(cf_15_5(23:end,y));
    legendTitle{end+1} = '15x5    CF';
end
if plot_10_6_pl  == 'ye'
    min_x(end+1,1) = min(pl_10_6(23:end,x));
    max_x(end+1,1) = max(pl_10_6(23:end,x));
    min_y(end+1,1) = min(pl_10_6(23:end,y));
    max_y(end+1,1) = max(pl_10_6(23:end,y));
    legendTitle{end+1} = '10x6    PL';
end
if plot_10_5_pl  == 'ye'
    min_x(end+1,1) = min(pl_10_5(23:end,x));
    max_x(end+1,1) = max(pl_10_5(23:end,x));
    min_y(end+1,1) = min(pl_10_5(23:end,y));
    max_y(end+1,1) = max(pl_10_5(23:end,y));
    legendTitle{end+1} = '10x5    PL';
end
min_x = min(min_x); max_x = max(max_x); min_y = min(min_y); max_y = max(max_y);
legendTitle(1) = [];

figure(1)
hold on
if plot_12_38_cf == 'ye'
    plot(cf_12_38(23:end,x), cf_12_38(23:end,y), 'color', blue)
end
if plot_12_38_pl == 'ye'
    plot(pl_12_38(23:end,x), pl_12_38(23:end,y), 'color', orange)
end
if plot_15_5_cf  == 'ye'
    plot(cf_15_5(23:end,x), cf_15_5(23:end,y), 'color', yellow)
end
if plot_10_6_pl  == 'ye'
    plot(pl_10_6(23:end,x), pl_10_6(23:end,y), 'color', purple)
end
if plot_10_5_pl  == 'ye'
    plot(pl_10_5(23:end,x), pl_10_5(23:end,y), 'color', green)
end
xlabel(cf_12_38_table.Properties.VariableNames{x})
ylabel(cf_12_38_table.Properties.VariableNames{y})

legend(legendTitle, 'location', 'best');

set(gca,'FontSize',18)
x0=100;y0=250;
width=1280;height=1000;
set(gcf,'position',[x0,y0,width,height], 'color', 'w')
grid on
hold off

if input('Animated plot? This might take a long time to complete! y/n ') == 'ye' %#ok<*BDSCA>
% %         scatter(cf_12_38(:,x), cf_12_38(:,y), 1, 'filled')
% %         xlabel(cf_12_38_table.Properties.VariableNames{x})
% %         ylabel(cf_12_38_table.Properties.VariableNames{y})
% %         axis([min_x, max_x, min_y, max_y])
% 
%         figure(2)
%         h = animatedline;%('Color', blue);
%         xlabel(cf_12_38_table.Properties.VariableNames{x})
%         ylabel(cf_12_38_table.Properties.VariableNames{y})
%         axis([min(cf_12_38(:,x)), max(cf_12_38(23:end,x)), min(cf_12_38(:,y)), max(cf_12_38(23:end,y))])
%         for i = 1:length(cf_12_38(:,1))
%             addpoints(h,cf_12_38(i,x), cf_12_38(i,y), 'color', blue)
%             drawnow
%         end
%         hold on

end

first_time_ran = 0;

% pl_12_table(any(isnan(table2array(pl_12_table)), 2), :) = [];
% cf_12_table(any(isnan(table2array(cf_12_table)), 2), :) = [];