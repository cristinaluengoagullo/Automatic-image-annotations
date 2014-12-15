function pixels = get_pixels_features(regions_features, area_points, img_gray, img_seg)
    %% Matrix: row = num_regions; col: 9 
    pixels = zeros(size(area_points,1),9);
 
    R = 1;          % pixels(p,R):       R component average of the region where pixel 'p' belongs
    G = 2;          % pixels(p,G):       G component average of the region where pixel 'p' belongs
    B = 3;          % pixels(p,B):       B component average of the region where pixel 'p' belongs  
    G1 = 4;         % pixels(p,G1):      Gradient property 1 average of the region where pixel 'p' belongs
    G2 = 5;         % pixels(p,G2):      Gradient property 2 average of the region where pixel 'p' belongs
    Cx = 6;         % pixels(p,Cx):      X position of the center of the region where pixel 'p' belongs
    Cy = 7;         % pixels(p,Cy):      Y position of the center of the region where pixel 'p' belongs
    N = 8;          % pixels(p,N):       Number of points in the region where pixel 'p' belongs
    T = 9;          % pixels(p,T):       Texture component of pixel 'p'
    
    % Range filter to extract the texture feature
    img_range = rangefilt(img_gray);
    
    for p = 1:size(area_points,1)
        % Region where the pixel 'p' belongs
        regP = get_region_number(img_seg,floor(area_points(p,2)),floor(area_points(p,1)));
        % R G B components average of the region where pixel 'p' belongs 
        pixels(p,R) = regions_features(regP,R);
        pixels(p,G) = regions_features(regP,G);
        pixels(p,B) = regions_features(regP,B);
        % G1 and G2 components (Ori,Mag) average of the region where pixel 'p' belongs
        pixels(p,G1) = regions_features(regP,G1);
        pixels(p,G2) = regions_features(regP,G2);
        % Coordenates x y of the center of the region where pixel 'p' belongs
        pixels(p,Cx) = regions_features(regP,Cx);
        pixels(p,Cy) = regions_features(regP,Cy);
        % Number of pixels of the region where pixel 'p' belongs
        pixels(p,N) = regions_features(regP,N);
        % Texture component of the pixel 'p'
        pixels(p,T) = img_range(floor(area_points(p,2)),floor(area_points(p,1)));
    end