function MAT_T = GetCharac(image_unit, IDCard)

% IDCard  .skys              .pointsCoordinates
% IDCard  .vegetations       .pointsCoordinates
% IDCard  .bricksOrConcretes .pointsCoordinates
% IDCard  .roofs             .pointsCoordinates
% IDCard  .windowpanes       .pointsCoordinates
% IDCard  .doors             .pointsCoordinates
% IDCard  .pedestrians       .pointsCoordinates

image = double(image_unit);
Mat_prov_size = 1;

he_filt(:, :, 1) = medfilt2(image(:, :, 1));
he_filt(:, :, 2) = medfilt2(image(:, :, 2));
he_filt(:, :, 3) = medfilt2(image(:, :, 3));

im_seg = watershed_old(he_filt, 26);


l_w = size(image);
length = l_w(1);
wide = l_w(2);

%SKY
string_sky = IDCard.skys.pointsCoordinates;
    if sum(string_sky) == 0;
        clear string_sky;
   
    else
    size_string = size(string_sky);
    
        for i=Mat_prov_size:(Mat_prov_size(1)+size_string(1)-1)
            class(i, 1) = floor(string_sky(i-(Mat_prov_size-1), 2)); % ROW
            class(i, 2) = floor(string_sky(i-(Mat_prov_size-1), 1)); %COLUM

            MAT_T(i,2) = image(class(i, 1), class(i, 2), 1); % R Parameter   
            MAT_T(i,3) = image(class(i, 1), class(i, 2), 2); % G Parameter
            MAT_T(i,4) = image(class(i, 1), class(i, 2), 3); % B Parameter
            MAT_T(i,5) = double(find_size(im_seg, class(i, 1), class(i, 2), length, wide)); %Size of the segmentation
            MAT_T(i,1) = 1; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
    end

%VEGETATIONS
string_veg = IDCard.vegetations.pointsCoordinates;
    if sum(string_veg) == 0;
        clear string_veg;
   
    else
    size_string = size(string_veg);
    
        for i=Mat_prov_size:(Mat_prov_size+size_string(1)-1)
            class(i, 1) = floor(string_veg(i-(Mat_prov_size-1), 2));
            class(i, 2) = floor(string_veg(i-(Mat_prov_size-1), 1));

            MAT_T(i,2) = image(class(i, 1), class(i, 2), 1); % R Parameter   
            MAT_T(i,3) = image(class(i, 1), class(i, 2), 2); % G Parameter
            MAT_T(i,4) = image(class(i, 1), class(i, 2), 3); % B Parameter
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), length, wide); %Size of the segmentation
            MAT_T(i,1) = 2; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
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

            MAT_T(i,2) = image(class(i, 1), class(i, 2), 1); % R Parameter   
            MAT_T(i,3) = image(class(i, 1), class(i, 2), 2); % G Parameter
            MAT_T(i,4) = image(class(i, 1), class(i, 2), 3); % B Parameter
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), length, wide); %Size of the segmentation
            MAT_T(i,1) = 3; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
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

            MAT_T(i,2) = image(class(i, 1), class(i, 2), 1); % R Parameter   
            MAT_T(i,3) = image(class(i, 1), class(i, 2), 2); % G Parameter
            MAT_T(i,4) = image(class(i, 1), class(i, 2), 3); % B Parameter
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), length, wide); %Size of the segmentation
            MAT_T(i,1) = 4; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
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

            MAT_T(i,2) = image(class(i, 1), class(i, 2), 1); % R Parameter   
            MAT_T(i,3) = image(class(i, 1), class(i, 2), 2); % G Parameter
            MAT_T(i,4) = image(class(i, 1), class(i, 2), 3); % B Parameter
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), length, wide); %Size of the segmentation
            MAT_T(i,1) = 5; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
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

            MAT_T(i,2) = image(class(i, 1), class(i, 2), 1); % R Parameter   
            MAT_T(i,3) = image(class(i, 1), class(i, 2), 2); % G Parameter
            MAT_T(i,4) = image(class(i, 1), class(i, 2), 3); % B Parameter
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), length, wide); %Size of the segmentation
            MAT_T(i,1) = 6; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
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

            MAT_T(i,2) = image(class(i, 1), class(i, 2), 1); % R Parameter   
            MAT_T(i,3) = image(class(i, 1), class(i, 2), 2); % G Parameter
            MAT_T(i,4) = image(class(i, 1), class(i, 2), 3); % B Parameter
            MAT_T(i,5) = find_size(im_seg, class(i, 1), class(i, 2), length, wide); %Size of the segmentation
            MAT_T(i,1) = 7; % Cluster atribuited to sky
        end             
    Mat_prov_size = Mat_prov_size+size_string(1);
    clear class;
    end