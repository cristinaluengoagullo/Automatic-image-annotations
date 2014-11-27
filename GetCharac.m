function MAT_T = GetCharac(image_unit, IDCard)

% IDCard  .skys              .pointsCoordinates
% IDCard  .vegetations       .pointsCoordinates
% IDCard  .bricksOrConcretes .pointsCoordinates
% IDCard  .roofs             .pointsCoordinates
% IDCard  .windowpanes       .pointsCoordinates
% IDCard  .doors             .pointsCoordinates
% IDCard  .pedestrians       .pointsCoordinates

% i dimensions: Y coordenate of the pixel (lines)
% j dimensions: X coordenate of the pixel (lines)
% z dimensions: 1st - R characteristic (from RGB)
%               2nd - G characteristic
%               3rd - B characteristc
%               4th - Texture  
%               5th - Size of the Region
%               6th - Position (how high it is) 
%               7th - Gradient Magnitude
%               8th - Gradient Orientation
%               9th - Cluster Category

%% Read the image
% 
image = double(image_unit);
Mat_prov_size = 1;

he_filt(:, :, 1) = medfilt2(image(:, :, 1));
he_filt(:, :, 2) = medfilt2(image(:, :, 2));
he_filt(:, :, 3) = medfilt2(image(:, :, 3));

im_seg = watershed_old(he_filt, 26);

l_w = size(image);
lenght = l_w(1);
wide = l_w(2);

clear l_w;
%% Fix if 0
% Sometimes, the water shed funtion retrives a pixel and doesnt atribute
% any cluster to it. This is a down side of the Watershed
% The way to solve this problem was to atribute the same cluster as one of
% its surrondings
%
% In the first row, the pixel receives the value from it's left. 
% In the other from the one above

for e=1:3

    for j=1:wide
        if (im_seg(1, j, e) == 0)
            im_seg(1, j, e) = im_seg(1, j-1, e);
        end
    end
    
  for i=2:lenght
    for j=1:wide
        
        if(im_seg(i, j, e) == 0)
           im_seg(i, j, e) = im_seg(i-1, j, e);
        end
    end
  end
end


%% SKY
% The algorith for the fecthing of the information is equal to all the
% categories. Due to this, only the SKY algorithm will be explained in the
% comments

% string_sky - Matrix of the coordinates of all the points that belong to
% the sky
string_sky = IDCard.skys.pointsCoordinates;
    if sum(string_sky) == 0;
        clear string_sky;
   
    else
    size_string = size(string_sky);
    
        for i=Mat_prov_size:(Mat_prov_size(1)+size_string(1)-1)
            class(i, 1) = floor(string_sky(i-(Mat_prov_size-1), 2)); % ROW
            class(i, 2) = floor(string_sky(i-(Mat_prov_size-1), 1)); %COLUM

            vect_RGB   = clustering_color(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                MAT_T(i,1) = vect_RGB(1, 1); % R Parameter   
                MAT_T(i,2) = vect_RGB(2, 1); % G Parameter
                MAT_T(i,3) = vect_RGB(3, 1); % B Parameter    
                
          % MAT_T(i,4) = find_texture();
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), lenght, wide); %Size of the segmentation
          % MAT_T(i,6) = find_position();
          
           vect_gradient = find_gradient(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                 MAT_T(i,7) = vect_gradient(1, 1);
                 MAT_T(i,8) = vect_gradient(2, 1);
                 
            MAT_T(i,9) = 1; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
    clear vect_RGB;
    clear vec_gradient;
    end

%% VEGETATIONS
string_veg = IDCard.vegetations.pointsCoordinates;
    if sum(string_veg) == 0;
        clear string_veg;
   
    else
    size_string = size(string_veg);
    
        for i=Mat_prov_size:(Mat_prov_size+size_string(1)-1)
            class(i, 1) = floor(string_veg(i-(Mat_prov_size-1), 2));
            class(i, 2) = floor(string_veg(i-(Mat_prov_size-1), 1));

            vect_RGB   = clustering_color(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                MAT_T(i,1) = vect_RGB(1, 1); % R Parameter   
                MAT_T(i,2) = vect_RGB(2, 1); % G Parameter
                MAT_T(i,3) = vect_RGB(3, 1); % B Parameter    
                
          % MAT_T(i,4) = find_texture();
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), lenght, wide); %Size of the segmentation
          % MAT_T(i,6) = find_position();
          
           vect_gradient = find_gradient(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                 MAT_T(i,7) = vect_gradient(1, 1);
                 MAT_T(i,8) = vect_gradient(2, 1);
                 
            MAT_T(i,9) = 2; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
    clear vect_RGB;
    clear vec_gradient;
    end
    
    
%Brincks or concretes
string_boc = IDCard.bricksOrConcretes.pointsCoordinates;
    if sum(string_boc) == 0;
        clear string_boc;
   
    else
    size_string = size(string_boc);
    
        for i=Mat_prov_size:(Mat_prov_size+size_string(1)-1)
            class(i, 1) = floor(string_boc(i-(Mat_prov_size-1), 2));
            class(i, 2) = floor(string_boc(i-(Mat_prov_size-1), 1));

            vect_RGB   = clustering_color(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                MAT_T(i,1) = vect_RGB(1, 1); % R Parameter   
                MAT_T(i,2) = vect_RGB(2, 1); % G Parameter
                MAT_T(i,3) = vect_RGB(3, 1); % B Parameter    
                
          % MAT_T(i,4) = find_texture();
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), lenght, wide); %Size of the segmentation
          % MAT_T(i,6) = find_position();
          
           vect_gradient = find_gradient(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                 MAT_T(i,7) = vect_gradient(1, 1);
                 MAT_T(i,8) = vect_gradient(2, 1);
                 
            MAT_T(i,9) = 3; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
    clear vect_RGB;
    clear vec_gradient;
    end
    
    
%ROOFS
string_roof = IDCard.roofs.pointsCoordinates;
    if sum(string_roof) == 0;
        clear string_roof;
   
    else
    size_string = size(string_roof);
    
        for i=Mat_prov_size:(Mat_prov_size+size_string(1)-1)
            class(i, 1) = floor(string_roof(i-(Mat_prov_size-1), 2));
            class(i, 2) = floor(string_roof(i-(Mat_prov_size-1), 1));

            vect_RGB   = clustering_color(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                MAT_T(i,1) = vect_RGB(1, 1); % R Parameter   
                MAT_T(i,2) = vect_RGB(2, 1); % G Parameter
                MAT_T(i,3) = vect_RGB(3, 1); % B Parameter    
                
          % MAT_T(i,4) = find_texture();
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), lenght, wide); %Size of the segmentation
          % MAT_T(i,6) = find_position();
          
           vect_gradient = find_gradient(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                 MAT_T(i,7) = vect_gradient(1, 1);
                 MAT_T(i,8) = vect_gradient(2, 1);
                 
            MAT_T(i,9) = 4; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
    clear vect_RGB;
    clear vec_gradient;
    end
    
%WINDOWS
string_windws = IDCard.windowpanes.pointsCoordinates;
    if sum(string_windws) == 0;
        clear string_windws;
   
    else
    size_string = size(string_windws);
    
        for i=Mat_prov_size:(Mat_prov_size+size_string(1)-1)
            class(i, 1) = floor(string_windws(i-(Mat_prov_size-1), 2));
            class(i, 2) = floor(string_windws(i-(Mat_prov_size-1), 1));

            vect_RGB   = clustering_color(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                MAT_T(i,1) = vect_RGB(1, 1); % R Parameter   
                MAT_T(i,2) = vect_RGB(2, 1); % G Parameter
                MAT_T(i,3) = vect_RGB(3, 1); % B Parameter    
                
          % MAT_T(i,4) = find_texture();
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), lenght, wide); %Size of the segmentation
          % MAT_T(i,6) = find_position();
          
           vect_gradient = find_gradient(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                 MAT_T(i,7) = vect_gradient(1, 1);
                 MAT_T(i,8) = vect_gradient(2, 1);
                 
            MAT_T(i,9) = 5; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
    clear vect_RGB;
    clear vec_gradient;
    end
    
%DOORS
string_doors = IDCard.doors.pointsCoordinates;
    if sum(string_doors) == 0;
        clear string_doors;
   
    else
    size_string = size(string_doors);
    
        for i=Mat_prov_size:(Mat_prov_size+size_string(1)-1)
            class(i, 1) = floor(string_doors(i-(Mat_prov_size-1), 2));
            class(i, 2) = floor(string_doors(i-(Mat_prov_size-1), 1));
            vect_RGB   = clustering_color(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                MAT_T(i,1) = vect_RGB(1, 1); % R Parameter   
                MAT_T(i,2) = vect_RGB(2, 1); % G Parameter
                MAT_T(i,3) = vect_RGB(3, 1); % B Parameter    
                
          % MAT_T(i,4) = find_texture();
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), lenght, wide); %Size of the segmentation
          % MAT_T(i,6) = find_position();
          
           vect_gradient = find_gradient(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                 MAT_T(i,7) = vect_gradient(1, 1);
                 MAT_T(i,8) = vect_gradient(2, 1);
                 
            MAT_T(i,9) = 6; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
    clear vect_RGB;
    clear vec_gradient;
    end
    
%PEDESTRIANS
string_ped = IDCard.pedestrians.pointsCoordinates;
    if sum(string_ped) == 0;
        clear string_ped;
   
    else
    size_string = size(string_ped);
    
        for i=Mat_prov_size:(Mat_prov_size+size_string(1)-1)
            class(i, 1) = floor(string_ped(i-(Mat_prov_size-1), 2));
            class(i, 2) = floor(string_ped(i-(Mat_prov_size-1), 1));

            vect_RGB   = clustering_color(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                MAT_T(i,1) = vect_RGB(1, 1); % R Parameter   
                MAT_T(i,2) = vect_RGB(2, 1); % G Parameter
                MAT_T(i,3) = vect_RGB(3, 1); % B Parameter    
                
          % MAT_T(i,4) = find_texture();
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), lenght, wide); %Size of the segmentation
          % MAT_T(i,6) = find_position();
          
           vect_gradient = find_gradient(he_filt, im_seg, lenght, wide, class(i, 1), class(i, 2));
                 MAT_T(i,7) = vect_gradient(1, 1);
                 MAT_T(i,8) = vect_gradient(2, 1);
                 
            MAT_T(i,9) = 7; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
    clear vect_RGB;
    clear vec_gradient;
    end