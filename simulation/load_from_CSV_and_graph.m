clear; clear all;
version = 0;
mcas = "mcas_old";
% mcas = "mcas_old_adaptive";
% mcas = "mcas_new";
% mcas = "sa_mcas";
% mcas = "sa_mcas_adaptive";

global count;
count = 0;
global total; 
total = 0;

%% Plots
% plot_all(version, "mcas_old");
% plot_all(version, "mcas_new");
% plot_all(version, "sa_mcas");
% plot_stall_recovery(version, mcas);
% plot_stall_pitch(version, mcas);
% plot_sudden_val(version, mcas);
% plot_sudden_duration(version, mcas);
% plot_sudden_recovery(version, mcas);
% plot_delta_val(version, mcas);
% plot_delta_duration(version, mcas);
% plot_delta_recovery(version, mcas);
% plot_gradual_lin_coef(version, mcas);
% plot_gradual_log_coef(version, mcas);
% plot_gradual_quad_coef(version, mcas);
% plot_stall_none();
% plot_stall_mcas_new();
% plot_stall_sa_mcas();

fprintf('%i/%i = %12.4f\n', (total - count), total, (total - count)/total);

%% Plotting Functions

% Function to save figure as a cropped PDF
function saveCroppedPDF(filename, width, height)
    % Get the current figure handle
    fig = gcf;

    % Set the PaperUnits to points and get the figure's size
    set(fig, 'PaperUnits', 'inches');

    % Adjust the PaperPosition to fill the entire page with the figure
    set(fig, 'PaperSize', [width, height]);

    % Adjust the PaperPosition to fill the entire page
    set(fig, 'PaperPosition', [0, 0, width, height]);

    % Print the figure to a PDF file with cropped size
    print(fig, filename, '-dpdf', '-painters');
end

% Function to save figure as a cropped EPS
function saveCroppedEPS(filename)
    % Get the current figure handle
    fig = gcf;

    % Set the PaperPositionMode to 'auto' to ensure tight cropping
    set(fig, 'PaperPositionMode', 'auto');

    % Set the PaperUnits to points and get the figure's size
    set(fig, 'PaperUnits', 'points');
    position = get(fig, 'Position');

    % Adjust the PaperSize to match the figure size
    width = position(3);
    height = position(4);
    set(fig, 'PaperSize', [width, height]);

    % Adjust the PaperPosition to fill the entire page
    set(fig, 'PaperPosition', [0, 0, width, height]);

    % Print the figure to an EPS file with cropped size
    print(fig, filename, '-depsc', '-painters');
end

% Function to save figure as a cropped PNG
function saveCroppedPNG(filename, width, height)
    % Get the current figure handle
    fig = gcf;

    % Set the PaperUnits to points and get the figure's size
    set(fig, 'PaperUnits', 'inches');

    % Adjust the PaperPosition to fill the entire page with the figure
    set(fig, 'PaperSize', [width, height]);

    % Adjust the PaperPosition to fill the entire page
    set(fig, 'PaperPosition', [0, 0, width, height]);

    % Print the figure to a PNG file with cropped size
    print(fig, filename, '-dpng', '-r300'); % '-r300' specifies the resolution in DPI
end


function plot_all(version, mcas)

    
    
    % Colors:
    % https://projects.susielu.com/viz-palette?colors=[%22#ffd700%22,%22#2f4b7c%22,%22#665191%22,%22#603359%22,%22#a05195%22,%22#9d02d7%22,%22#d45087%22,%22#df75c4%22,%22#f95d6a%22,%22#ff7c43%22,%22#ffa600%22]&backgroundColor=%22white%22&fontColor=%22black%22&mode=%22normal%22
%     h(1) = plot_file_with_color(append(mcas, "_sudden_injection_val_"), 0, 30, 10, version, true, "#ebac23", "Sudden Injection Val");
%     h(2) = plot_file_with_color(append(mcas, "_sudden_injection_duration_"), 10, 80, 10, version, true, "#b80058", "Sudden Injection Duration");
%     h(3) = plot_file_with_color(append(mcas, "_sudden_injection_delayed_recovery_"), 3, 30, 10, version, true, "#008cf9", "Sudden Injection Recovery");
%     h(4) = plot_file_with_color(append(mcas, "_delta_injection_val_"), 0, 30, 10, version, true, "#006e00", "Delta Injection Val");
%     h(5) = plot_file_with_color(append(mcas, "_delta_injection_duration_"), 10, 80, 10, version, true, "#00bbad", "Delta Injection Duration");
%     h(6) = plot_file_with_color(append(mcas, "_delta_injection_delayed_recovery_"), 3, 30, 10, version, true, "#d163e6", "Delta Injection Recovery");
%     h(7) = plot_file_with_color(append(mcas, "_gradual_injection_lin_coef_"), 0, 30, 10, version, true, "#5954d6", "Sudden Injection Val");
% %     plot_file_with_color(append(mcas, "_gradual_injection_log_coef_"), 0, 30, 10, version, true, "#00c6f8", "Sudden Injection Val");
% %     plot_file_with_color(append(mcas, "_gradual_injection_quad_coef_"), 0, 30, 10, version, true, "#878500", "Sudden Injection Val");
%     h(8) = plot_file_stall_2_with_color(append(mcas, "_pilot_stall_vary_recovery_val_"), 0, 30, 10, version, true, "#b24502", "Stall Recovery");
%     h(9) = plot_file_stall_2_with_color(append(mcas, "_pilot_stall_vary_pitch_val_"), 20, 50, 10, version, true, "#ff9287", "Stall Pitch");
    
    figure;
    ax = axes();
    h(1) = plot_file_with_color(append(mcas, "_sudden_injection_val_"), 0, 30, 10, version, true, "#0173b2", "Sudden Error Val"); % #0066f2
    h(2) = plot_file_with_color(append(mcas, "_sudden_injection_duration_"), 10, 80, 10, version, true, "#de8f05", "Sudden Error Duration"); % #0eb8ea
    h(3) = plot_file_with_color(append(mcas, "_sudden_injection_delayed_recovery_"), 3, 30, 10, version, true, "#ECE133", "Sudden Error Recovery"); % #00ffec
    hCopy = copyobj(h, ax);
    for i=1:3
        set(hCopy(i),'XData', NaN', 'YData', NaN)
        hCopy(i).LineStyle = '-';
        hCopy(i).LineWidth = 2;
        hCopy(i).Marker = 'none';
    end
    legend(hCopy, 'FontSize', 8, 'Location', 'northwest');
%     title('Sudden Error');
    saveCroppedPDF(append("EMSOFT-24-", mcas, "-ALL-COLOR-BIG-FINAL-SUDDEN.pdf"), 4, 3);
    saveCroppedPNG(append("EMSOFT-24-", mcas, "-ALL-COLOR-BIG-FINAL-SUDDEN.png"), 4, 3);
    

    figure;
    ax = axes();
    h(1) = plot_file_with_color(append(mcas, "_delta_injection_val_"), 0, 30, 10, version, true, "#0173b2", "Delta Error Val"); % #ff7b7b
    h(2) = plot_file_with_color(append(mcas, "_delta_injection_duration_"), 10, 80, 10, version, true, "#de8f05", "Delta Error Duration"); % #ebac23
    h(3) = plot_file_with_color(append(mcas, "_delta_injection_delayed_recovery_"), 3, 30, 10, version, true, "#ECE133", "Delta Error Recovery"); % #a54600
    hCopy = copyobj(h, ax);
    for i=1:3
        set(hCopy(i),'XData', NaN', 'YData', NaN)
        hCopy(i).LineStyle = '-';
        hCopy(i).LineWidth = 2;
        hCopy(i).Marker = 'none';
    end
    legend(hCopy, 'FontSize', 8, 'Location', 'northwest');
%     title('Delta Error');
    saveCroppedPDF(append("EMSOFT-24-", mcas, "-ALL-COLOR-BIG-FINAL-DELTA.pdf"), 4, 3);
    saveCroppedPNG(append("EMSOFT-24-", mcas, "-ALL-COLOR-BIG-FINAL-DELTA.png"), 4, 3);

    figure;
    ax = axes();
    h(1) = plot_file_with_color(append(mcas, "_gradual_injection_lin_coef_"), 0, 30, 10, version, false, "#0173b2", "Gradual Error Linear"); % #00a76c
    h(2) = plot_file_with_color(append(mcas, "_gradual_injection_log_coef_"), 100, 200, 10, version, true, "#de8f05", "Gradual Error Log"); % #5d9837
    h(3) = plot_file_with_color_quad(append(mcas, "_gradual_injection_quad_coef_"), 0, 10, 0, 30, 10, version, false, "#ECE133", "Gradual Error Quadratic"); % #878500
%     h(1) = plot_file_with_color(append(mcas, "_delta_injection_val_"), 0, 30, 10, version, true, "#0173b2", "Gradual Error Linear"); % #ff7b7b
%     h(2) = plot_file_with_color(append(mcas, "_delta_injection_duration_"), 10, 80, 10, version, true, "#de8f05", "Gradual Error Log"); % #ebac23
%     h(3) = plot_file_with_color(append(mcas, "_delta_injection_delayed_recovery_"), 3, 30, 10, version, true, "#ECE133", "Gradual Error Quadratic"); % #a54600
    hCopy = copyobj(h, ax);
    for i=1:3
        set(hCopy(i),'XData', NaN', 'YData', NaN)
        hCopy(i).LineStyle = '-';
        hCopy(i).LineWidth = 2;
        hCopy(i).Marker = 'none';
    end
    legend(hCopy, 'FontSize', 8, 'Location', 'northwest');
%     title('Gradual Error');
    saveCroppedPDF(append("EMSOFT-24-", mcas, "-ALL-COLOR-BIG-FINAL-GRADUAL.pdf"), 4, 3);
    saveCroppedPNG(append("EMSOFT-24-", mcas, "-ALL-COLOR-BIG-FINAL-GRADUAL.png"), 4, 3);

    figure;
    ax = axes();
    h(1) = plot_file_stall_2_with_color(append(mcas, "_pilot_stall_vary_recovery_val_"), 0, 30, 10, version, true, "#0173b2", "Stall Recovery"); % #bdbdbd
    h(2) = plot_file_stall_2_with_color(append(mcas, "_pilot_stall_vary_pitch_val_"), 20, 50, 10, version, true, "#de8f05", "Stall Pitch"); % #6f6f6f
    h(3) = [];

    hCopy = copyobj(h, ax);
    for i=1:2
        set(hCopy(i),'XData', NaN', 'YData', NaN)
        hCopy(i).LineStyle = '-';
        hCopy(i).LineWidth = 2;
        hCopy(i).Marker = 'none';
    end
    legend(hCopy, 'FontSize', 8, 'Location', 'northwest');
%     title('Pilot Stall');
    saveCroppedPDF(append("EMSOFT-24-", mcas, "-ALL-COLOR-BIG-FINAL-STALL.pdf"), 4, 3);
    saveCroppedPNG(append("EMSOFT-24-", mcas, "-ALL-COLOR-BIG-FINAL-STALL.png"), 4, 3);

end

function plot_sudden_val(version, mcas)
    plot_file(append(mcas, "_sudden_injection_val_"), 0, 30, 10, version, true);
end

function plot_sudden_duration(version, mcas)
    plot_file(append(mcas, "_sudden_injection_duration_"), 10, 80, 10, version, true);
end

function plot_sudden_recovery(version, mcas)
    [X, Y] = plot_file(append(mcas, "_sudden_injection_delayed_recovery_"), 3, 30, -1, version, true);
%     hold on;
%     plot(X, Y, '.', 'MarkerSize', 15, 'Color', [0, 0, 0], ...
%         'DisplayName', 'Pilot reaction time');
end

function plot_delta_val(version, mcas)
    plot_file(append(mcas, "_delta_injection_val_"), 0, 30, 10, version, true);
end

function plot_delta_duration(version, mcas)
    plot_file(append(mcas, "_delta_injection_duration_"), 10, 80, 10, version, true);
end

function plot_delta_recovery(version, mcas)
    [X, Y] = plot_file(append(mcas, "_delta_injection_delayed_recovery_"), 3, 30, -1, version, true);
%     hold on;
%     plot(X, Y, '.', 'MarkerSize', 15, 'Color', [0, 0, 0], ...
%         'DisplayName', 'Pilot reaction time');
end

function plot_gradual_lin_coef(version, mcas)
    plot_file(append(mcas, '_gradual_injection_lin_coef_'), 0, 30, 10, version, false);
end

function plot_gradual_log_coef(version, mcas)
    plot_file(append(mcas, '_gradual_injection_log_coef_'), 100, 200, 10, version, true);
end

function plot_gradual_quad_coef(version, mcas)
    for i=0:10
        a = i/10;
        plot_file(append(mcas, '_gradual_injection_quad_coef_', num2str(a, '%.1f'), '_'), 0, 30, 10, version, false);
    end
end

function plot_stall_recovery(version, mcas)
    plot_file_stall_2(append(mcas, "_pilot_stall_vary_recovery_val_"), 0, 30, 10, version, true);
end

function plot_stall_pitch(version, mcas)
    plot_file_stall_2(append(mcas, "_pilot_stall_vary_pitch_val_"), 20, 50, 10, version, true);
end

function plot_stall_none()
    plot_file_stall('none')
end

function plot_stall_mcas_new()
    plot_file_stall('mcas-new')
end

function plot_stall_sa_mcas()
    plot_file_stall('sa-mcas')
end
    

function [X, Y] = plot_file_stall(mcas_type)
    count = 0;
    total = 0;

    for i=5:10
        for j=23:28
            for k=4:8
                total = total + 1;
                do_graph = true;

                simfile = append('takeoff-stall_target-pitch-', int2str(i*5), '_final-climb-airspeed-', int2str(j*10-5), '_pitch-up-time-', int2str(k*20), '.csv');

                clean_simfile = 'clean_mcas_old_takeoff.csv';
                
                data = readtable(append('../data-collection/simulation-export/', mcas_type, '-takeoff-stall/', simfile));
                clean_data = readtable(append('../data-collection/simulation-export/', clean_simfile));
                
                %% Data from Import
                time = data.time(:);
                h_asl = data.h_asl(:);
                pitch = data.pitch(:);
                roll = data.roll(:);
                vc = data.vc(:);
            
            
                if size(find(h_asl <= 50, 1, 'first')) > 0
                    count = count + 1;
                    do_graph = false;
                end

                for h=find(h_asl <= 50, 1, 'first'):size(h_asl)
                    h_asl(h) = -1000;
                end
            
                n_time = clean_data.time(:);
                n_h_asl = clean_data.h_asl(:);
                n_pitch = clean_data.pitch(:);
                n_roll = clean_data.roll(:);
                n_vc = clean_data.vc(:);
        
                %% Input Parameters for chart
                t_start = 1;
                t_end = size(time);
                
                i_start = find(time>=(k*20),1);
                
                %% Plotting
                if do_graph
                % figure;
                %plot(n_time, n_h_asl, 'LineWidth', 1, 'Color', 'g', 'LineStyle', '-');
                %hold on;
                    plot(time(t_start:i_start), h_asl(t_start:i_start), 'LineWidth', 0.5, 'Color', [0.00,0.45,0.74], 'LineStyle', '-');
                    hold on;
                    plot(time(i_start:t_end), h_asl(i_start:t_end), 'LineWidth', 0.5, 'Color', [1.00,0.00,0.00], 'LineStyle', '-');
%                 hold on;
%                 plot(time(i_end:t_end), h_asl(i_end:t_end), 'LineWidth', 2, 'Color', [0.30,0.75,0.93], 'LineStyle', '-.');
                end
            end
        end
    end
    
    

    set(gca, 'FontSize', 8);
    xlabel("Time (sec)", 'FontSize', 10);
    ylabel("Altitude (ft)", 'FontSize', 10);
    ylim([0 13000]);
    xlim([40 400]);
    legend(...'Flight w/o erroneous AoA sensor', ...
            'Flight before pilot pitch up', ...
            'Flight after pilot pitch up', ...
    ...%             'Flight after erroneous AoA sensor', ...
    ...%         'Pilot reaction point', ...
            'FontSize', 8, 'Location', 'northwest');

    fprintf('%i/%i = %12.4f\n', (total - count), total, (total - count)/total);

end

function [X, Y] = plot_file(file_name, i_start, i_end, offset, version, use_whole)

    X = [];
    Y = [];

    global count;
    global total;
    
    for i=i_start:i_end
        total = total + 1;
        if use_whole
            simfile = append(file_name, int2str(i), '_recovery_enabled_grad_', int2str(version), '.csv');
        else
            a = i/10;
            simfile = append(file_name, num2str(a, '%.1f'), '_recovery_enabled_grad_', int2str(version), '.csv');
        end

%         clean_simfile = 'clean_mcas_old_takeoff.csv';
        
        data = readtable(append('../data-collection/simulation-export/', simfile));
%         clean_data = readtable(append('../data-collection/simulation-export/', clean_simfile));
        
        %% Data from Import
        time = data.time(:);
        h_asl = data.h_asl(:);
        pitch = data.pitch(:);
        roll = data.roll(:);
        vc = data.vc(:);
    
        if size(find(h_asl < 0, 1, 'first')) > 0
            count = count + 1;
        end

        for j=find(h_asl < 0, 1, 'first'):size(h_asl)
            h_asl(j) = -10;
        end
    
%         n_time = clean_data.time(:);
%         n_h_asl = clean_data.h_asl(:);
%         n_pitch = clean_data.pitch(:);
%         n_roll = clean_data.roll(:);
%         n_vc = clean_data.vc(:);
        
        %% Input Parameters for chart
        t_start = 1;
        t_end = size(time);
        
        i_start = find(time>=100,1);
        if offset > 0
            i_end = find(time>=(100+offset),1);
        else
            i_end = find(time>=(100+i),1);
        end

        X = [X, 100 + i];
        i_reaction = find(time >= 100 + i, 1);
        Y = [Y, h_asl(i_reaction)];
        
        %% Plotting
        
        % figure;
        %plot(n_time, n_h_asl, 'LineWidth', 1, 'Color', 'g', 'LineStyle', '-');
        %hold on;
        plot(time(t_start:i_start), h_asl(t_start:i_start), 'LineWidth', 2, 'Color', [0.00,0.45,0.74], 'LineStyle', '-');
        hold on;
        plot(time(i_start:i_end), h_asl(i_start:i_end), 'LineWidth', 2, 'Color', [1.00,0.00,0.00], 'LineStyle', '-');
        hold on;
        plot(time(i_end:t_end), h_asl(i_end:t_end), 'LineWidth', 2, 'Color', [0.30,0.75,0.93], 'LineStyle', '-.');
    end
    
    set(gca, 'FontSize', 8);
    xlabel("Time (sec)", 'FontSize', 10);
    ylabel("Altitude (ft)", 'FontSize', 10);
    ylim([0 15000]);
    xlim([40 250]);
    legend(...'Flight w/o erroneous AoA sensor', ...
            'Flight before erroneous AoA sensor', ...
            'Flight during erroneous AoA sensor', ...
            'Flight after erroneous AoA sensor', ...
    ...%         'Pilot reaction point', ...
            'FontSize', 8, 'Location', 'northwest');
end

function [X, Y] = plot_file_stall_2(file_name, i_start, i_end, offset, version, use_whole)

    X = [];
    Y = [];

    global count;
    global total;
    
    for i=i_start:i_end
        if i == 19 || i == 24
%             continue;
        end
        total = total + 1;
        if use_whole
            simfile = append(file_name, int2str(i), '_', int2str(version), '.csv');
        else
            a = i/10;
            simfile = append(file_name, num2str(a, '%.1f'), '_', int2str(version), '.csv');
        end

%         clean_simfile = 'clean_mcas_old_takeoff.csv';
        
        data = readtable(append('../data-collection/simulation-export/', simfile));
%         clean_data = readtable(append('../data-collection/simulation-export/', clean_simfile));
        
        %% Data from Import
        time = data.time(:);
        h_asl = data.h_asl(:);
        pitch = data.pitch(:);
        roll = data.roll(:);
        vc = data.vc(:);
    
        if size(find(h_asl < 0, 1, 'first')) > 0
            count = count + 1;
        end
    
        for j=find(h_asl < 0, 1, 'first'):size(h_asl)
            h_asl(j) = -10;
        end
    
%         n_time = clean_data.time(:);
%         n_h_asl = clean_data.h_asl(:);
%         n_pitch = clean_data.pitch(:);
%         n_roll = clean_data.roll(:);
%         n_vc = clean_data.vc(:);
        
        %% Input Parameters for chart
        t_start = 1;
        t_end = size(time);
        
        i_start = find(time>=100,1);
        if offset > 0
            i_end = find(time>=(100+offset),1);
        else
            i_end = find(time>=(100+i),1);
        end

        X = [X, 100 + i];
        i_reaction = find(time >= 100 + i, 1);
        Y = [Y, h_asl(i_reaction)];
        
        %% Plotting
        
        % figure;
        %plot(n_time, n_h_asl, 'LineWidth', 1, 'Color', 'g', 'LineStyle', '-');
        %hold on;
        plot(time(t_start:i_start), h_asl(t_start:i_start), 'LineWidth', 2, 'Color', [0.00,0.45,0.74], 'LineStyle', '-');
        hold on;
        plot(time(i_start:i_end), h_asl(i_start:i_end), 'LineWidth', 2, 'Color', [1.00,0.00,0.00], 'LineStyle', '-');
        hold on;
        plot(time(i_end:t_end), h_asl(i_end:t_end), 'LineWidth', 2, 'Color', [0.30,0.75,0.93], 'LineStyle', '-.');
    end
    
    set(gca, 'FontSize', 8);
    xlabel("Time (sec)", 'FontSize', 10);
    ylabel("Altitude (ft)", 'FontSize', 10);
    ylim([0 20000]);
    xlim([40 250]);
    legend(...'Flight w/o erroneous AoA sensor', ...
            'Flight before erroneous AoA sensor', ...
            'Flight during erroneous AoA sensor', ...
            'Flight after erroneous AoA sensor', ...
    ...%         'Pilot reaction point', ...
            'FontSize', 8, 'Location', 'northwest');
end

function h = plot_file_with_color(file_name, i_start, i_end, offset, version, use_whole, color, title)

    X = [];
    Y = [];

    global count;
    global total;
    
    for i=i_start:i_end
        if i == 19 || i == 24 || i == 28 || i == 29
%             continue;
        end
        total = total + 1;
        if use_whole
            simfile = append(file_name, int2str(i), '_recovery_enabled_grad_', int2str(version), '.csv');
        else
            a = i/10;
            simfile = append(file_name, num2str(a, '%.1f'), '_recovery_enabled_grad_', int2str(version), '.csv');
        end

%         clean_simfile = 'clean_mcas_old_takeoff.csv';
        
        data = readtable(append('../data-collection/simulation-export/', simfile));
%         clean_data = readtable(append('../data-collection/simulation-export/', clean_simfile));
        
        %% Data from Import
        time = data.time(:);
        h_asl = data.h_asl(:);
        pitch = data.pitch(:);
        roll = data.roll(:);
        vc = data.vc(:);
    
        if size(find(h_asl < 0, 1, 'first')) > 0
            count = count + 1;
        end

        for j=find(h_asl < 0, 1, 'first'):size(h_asl)
            h_asl(j) = -10;
        end

        %% Input Parameters for chart
        t_start = 1;
        t_end = size(time);
%         
%         i_start = find(time>=100,1);
%         if offset > 0
%             i_end = find(time>=(100+offset),1);
%         else
%             i_end = find(time>=(100+i),1);
%         end
       
        for t = t_start:t_end
            X = [X time(t)];
        end
        for h = t_start:t_end
            Y = [Y h_asl(h)];
        end
        
    end
    
    %% Plotting
    hold on;
    % Downsample data to reduce points
    downsampleFactor = 10;
    xDownsampled = X(1:downsampleFactor:end);
    yDownsampled = Y(1:downsampleFactor:end);
    h = plot(xDownsampled, yDownsampled, 'MarkerSize', 2, 'Color', color, 'Marker', '.', 'LineStyle', 'none', 'DisplayName', title);

    set(gca, 'FontSize', 8);
    xlabel("Time (sec)", 'FontSize', 10);
    ylabel("Altitude (ft)", 'FontSize', 10);
    ylim([0 15000]);
    xlim([40 250]);
end

function h = plot_file_stall_2_with_color(file_name, i_start, i_end, offset, version, use_whole, color, title)

    X = [];
    Y = [];

    global count;
    global total;
    
    for i=i_start:i_end
        if i == 19 || i == 24
%             continue;
        end
        total = total + 1;
        if use_whole
            simfile = append(file_name, int2str(i), '_', int2str(version), '.csv');
        else
            a = i/10;
            simfile = append(file_name, num2str(a, '%.1f'), '_', int2str(version), '.csv');
        end

%         clean_simfile = 'clean_mcas_old_takeoff.csv';
        
        data = readtable(append('../data-collection/simulation-export/', simfile));
%         clean_data = readtable(append('../data-collection/simulation-export/', clean_simfile));
        
        %% Data from Import
        time = data.time(:);
        h_asl = data.h_asl(:);
        pitch = data.pitch(:);
        roll = data.roll(:);
        vc = data.vc(:);
    
        if size(find(h_asl < 0, 1, 'first')) > 0
            count = count + 1;
        end
    
        for j=find(h_asl < 0, 1, 'first'):size(h_asl)
            h_asl(j) = -10;
        end

        %% Input Parameters for chart
        t_start = 1;
        t_end = size(time);
%         
%         i_start = find(time>=100,1);
%         if offset > 0
%             i_end = find(time>=(100+offset),1);
%         else
%             i_end = find(time>=(100+i),1);
%         end

        
        for t = t_start:t_end
            X = [X time(t)];
        end
        for h = t_start:t_end
            Y = [Y h_asl(h)];
        end
    end
    
    hold on;
    % Downsample data to reduce points
    downsampleFactor = 10;
    xDownsampled = X(1:downsampleFactor:end);
    yDownsampled = Y(1:downsampleFactor:end);
    h = plot(xDownsampled, yDownsampled, 'MarkerSize', 2, 'Color', color, 'Marker', '.', 'LineStyle', 'none', 'DisplayName', title);

    set(gca, 'FontSize', 8);
    xlabel("Time (sec)", 'FontSize', 10);
    ylabel("Altitude (ft)", 'FontSize', 10);
    ylim([0 15000]);
    xlim([40 250]);
end

function h = plot_file_with_color_quad(file_name, i_start_a, i_end_a, i_start_b, i_end_b, offset, version, use_whole, color, title)

    X = [];
    Y = [];

    global count;
    global total;
    
    for i=i_start_a:i_end_a
        for j=i_start_b:i_end_b
            total = total + 1;
            if use_whole
                simfile = append(file_name, int2str(i), '_recovery_enabled_grad_', int2str(version), '.csv');
            else
                a = i/10;
                b = j/10;
                simfile = append(file_name, num2str(a, '%.1f'), '_', num2str(b, '%.1f'), '_recovery_enabled_grad_', int2str(version), '.csv');
            end
    
    %         clean_simfile = 'clean_mcas_old_takeoff.csv';
            
            data = readtable(append('../data-collection/simulation-export/', simfile));
    %         clean_data = readtable(append('../data-collection/simulation-export/', clean_simfile));
            
            %% Data from Import
            time = data.time(:);
            h_asl = data.h_asl(:);
            pitch = data.pitch(:);
            roll = data.roll(:);
            vc = data.vc(:);
        
            if size(find(h_asl < 0, 1, 'first')) > 0
                count = count + 1;
            end
    
            for j=find(h_asl < 0, 1, 'first'):size(h_asl)
                h_asl(j) = -10;
            end
    
            %% Input Parameters for chart
            t_start = 1;
            t_end = size(time);
    %         
    %         i_start = find(time>=100,1);
    %         if offset > 0
    %             i_end = find(time>=(100+offset),1);
    %         else
    %             i_end = find(time>=(100+i),1);
    %         end
           
            for t = t_start:t_end
                X = [X time(t)];
            end
            for h = t_start:t_end
                Y = [Y h_asl(h)];
            end
            
        end
    end
    
    %% Plotting
    hold on;
    % Downsample data to reduce points
    downsampleFactor = 10;
    xDownsampled = X(1:downsampleFactor:end);
    yDownsampled = Y(1:downsampleFactor:end);
    h = plot(xDownsampled, yDownsampled, 'MarkerSize', 2, 'Color', color, 'Marker', '.', 'LineStyle', 'none', 'DisplayName', title);

    set(gca, 'FontSize', 8);
    xlabel("Time (sec)", 'FontSize', 10);
    ylabel("Altitude (ft)", 'FontSize', 10);
    ylim([0 15000]);
    xlim([40 250]);
end
