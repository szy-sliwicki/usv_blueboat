function img = get_camera_safe(tag)
    % Domyślnie tworzymy czarny kwadrat 64x64
    img = zeros(240, 320, 3, 'uint8');
    
    try
        % Próbujemy pobrać obraz z Webotsa
        tmp = wb_camera_get_image(tag);
        if ~isempty(tmp)
            img = tmp;
        end
    catch
        % Jeśli Webots wyrzuci błąd (np. pusty bufor w t=0), 
        % ignorujemy to i oddajemy czarny obraz
    end
end