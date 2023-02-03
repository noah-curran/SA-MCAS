clear; clear all;
version = 0;

%% Plots
% plot_sudden_val(version);
% plot_sudden_duration(version);
% plot_sudden_recovery(version);
% plot_delta_val(version);
% plot_delta_duration(version);
% plot_delta_recovery(version);
% plot_gradual_lin_coef(version);
% plot_gradual_log_coef(version);
% plot_gradual_quad_coef(version);
% plot_stall_none();
% plot_stall_mcas_new();
plot_stall_sa_mcas();

%% Plotting Functions
function plot_sudden_val(version)
    plot_file('sa_mcas_sudden_injection_val_', 0, 30, 10, version, true);
end

function plot_sudden_duration(version)
    plot_file('sa_mcas_sudden_injection_duration_', 10, 80, 10, version, true);
end

function plot_sudden_recovery(version)
    [X, Y] = plot_file('sa_mcas_sudden_injection_delayed_recovery_', 3, 30, -1, version, true);
    hold on;
    plot(X, Y, '.', 'MarkerSize', 15, 'Color', [0, 0, 0], ...
        'DisplayName', 'Pilot reaction time');
end

function plot_delta_val(version)
    plot_file('sa_mcas_delta_injection_val_', 0, 30, 10, version, true);
end

function plot_delta_duration(version)
    plot_file('sa_mcas_delta_injection_duration_', 10, 80, 10, version, true);
end

function plot_delta_recovery(version)
    [X, Y] = plot_file('sa_mcas_delta_injection_delayed_recovery_', 3, 30, -1, version, true);
    hold on;
    plot(X, Y, '.', 'MarkerSize', 15, 'Color', [0, 0, 0], ...
        'DisplayName', 'Pilot reaction time');
end

function plot_gradual_lin_coef(version)
    plot_file('sa_mcas_gradual_injection_lin_coef_', 0, 30, 10, version, false);
end

function plot_gradual_log_coef(version)
    plot_file('sa_mcas_gradual_injection_log_coef_', 150, 200, 10, version, false);
end

function plot_gradual_quad_coef(version)
    for i=0:10
        a = i/10;
        plot_file(append('sa_mcas_gradual_injection_quad_coef_', num2str(a, '%.1f'), '_'), 0, 30, 10, version, false);
    end
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
            
            
                if size(find(h_asl < 0, 1, 'first')) > 0
                    count = count + 1;
                    do_graph = false;
                end

                for h=find(h_asl < 0, 1, 'first'):size(h_asl)
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
    
    for i=i_start:i_end
        if use_whole
            simfile = append(file_name, int2str(i), '_recovery_enabled_grad_', int2str(version), '.csv');
        else
            a = i/10;
            simfile = append(file_name, num2str(a, '%.1f'), '_recovery_enabled_grad_', int2str(version), '.csv');
        end

        clean_simfile = 'clean_mcas_old_takeoff.csv';
        
        data = readtable(append('../data-collection/simulation-export/', simfile));
        clean_data = readtable(append('../data-collection/simulation-export/', clean_simfile));
        
        %% Data from Import
        time = data.time(:);
        h_asl = data.h_asl(:);
        pitch = data.pitch(:);
        roll = data.roll(:);
        vc = data.vc(:);
    
    
        for j=find(h_asl < 0, 1, 'first'):size(h_asl)
            h_asl(j) = -10;
        end
    
        n_time = clean_data.time(:);
        n_h_asl = clean_data.h_asl(:);
        n_pitch = clean_data.pitch(:);
        n_roll = clean_data.roll(:);
        n_vc = clean_data.vc(:);
        
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
    ylim([0 9000]);
    xlim([40 250]);
    legend(...'Flight w/o erroneous AoA sensor', ...
            'Flight before erroneous AoA sensor', ...
            'Flight during erroneous AoA sensor', ...
            'Flight after erroneous AoA sensor', ...
    ...%         'Pilot reaction point', ...
            'FontSize', 8, 'Location', 'northwest');
end
