function dist = get_radar_safe(tag)
    dist = 0; % Zwróci 0, jeśli droga jest czysta
    
    try
        % Sprawdzamy ile celów widzi radar
        num_targets = wb_radar_get_number_of_targets(tag);
        
        if num_targets > 0
            % Pobieramy listę wszystkich celów
            targets = wb_radar_get_targets(tag);
            
            % Szukamy najbliższego celu
            min_d = 999;
            for i = 1:num_targets
                if targets(i).distance < min_d
                    min_d = targets(i).distance;
                end
            end
            dist = min_d; % Zwracamy dystans w metrach
        end
    catch
        % Ignorujemy błędy w czasie t=0
    end
end