%% script descriptions found in Documentation/Pilot Simulator/
% List of scripts:
% straight_and_level
% straight_and_level_accelerate
% straight_and_climb
% straight_and_descend
% level_turns
% climb_and_turn
% descend_and_turn
% turn_then_descend
% holding_pattern
% takeoff
% takeoff_stall
% landing

%% RUN SIMULATIONS

initialize_sim_config;

for mcas = ["mcas_new"]

    pilot_stall_vary_recovery(version, mcas);

end

function pilot_stall_vary_recovery(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;
    store_anomaly_params('anomalies/EmptyInjection.json');

    safestate = load("safestate_NEW_RTAS_24.mat");
    safestate = safestate.safestate;

    [m, n] = size(safestate);

%     for i=1:101
%         for j=1:41
    for i=1:70
        for j=1:41
%             continue;
            if (safestate(i,j) ~= -1)
                continue;
            end

            clc; clearvars('-except', "mcas", "safestate", "i", "j", "m", "n");
            initialize_sim_config;
            
%             set_script_parameters([zeros(1, 21), 50, 250, 100, ((i-1)/10+52)/10]);
            set_script_parameters([zeros(1, 21), 50, 250, 100, (i-1)/10]);
            set_mcas_parameters([11, 2.5, 0.27, 18, (j-1)/10, 0, 0.1, 0.105, 0.1]);
            safestate(i,j) = do_sim_success_check("takeoff_stall_pilot_reaction_delay", mcas, 300, 0);
            
            save("safestate_NEW_RTAS_24.mat", "safestate");
        end
    end

    figure
    for i=2:70
        for j=2:41
            if safestate(i,j)
                hold on;
                p_ok = plot((i-1)/10,(j-1)/10,'bo');
            else
                hold on;
                p_bad = plot((i-1)/10,(j-1)/10,'rx');
            end
        end
    end

%     set(gca, 'FontSize', 8);
%     title('Safe-Set Analysis');
    xlabel('Pilot Reaction Time (s)');
    ylabel('Pilot HS Rotations (RPS)');
    ylim([0 4]);
    xlim([0 7]);
    legend([p_ok p_bad], {'Recoverable','Unrecoverable'}, 'FontSize', 8, 'Location', 'northwest');

end % function