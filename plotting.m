function plotting(last_number, matrix_name, title_name, t)
    colorNames = {'blue', 'green', 'red', 'cyan', 'magenta', 'yellow', 'black'};
    
    figure()
    c = 1;

    for i = 1:last_number
        subplot(last_number, 1, i);

        % Plot the waveform
        plot(t, matrix_name(i,:),  sprintf('%s - %s', title_name, num2str(i)), 'color', colorNames{c});
        c = c + 1;
        if c > 7
                c = 1;
        end

        % Add labels, title, and grid
        xlabel('time');
        ylabel('volt');
        xlim([-1 1])*0.8
        ylim([-1 1])*0.8
        title([title_name, num2str(i)]);
        grid on;
    end
    hold off;
end