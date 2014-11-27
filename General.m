% Top-Level Hierarquy of the project
%
% Matrix of the caracteristics has the folowing definitions:
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
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%% PROJECT BY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%  Cristina  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%    Javi    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%    João    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%

clear all

%% 1
% Section 1 - Image reading and Image Map indices
Question = 'What if the file extension?\n';
strg_ext = input(Question);

if strg_ext(1) ~= '.'
    error('The file extension does not beggin with " . " ')
end

Question = 'What is the FileName of the picture? - Please use '' and DONT put file extension\n';
FileName = input(Question);

load(FileName);

FileName = strcat(FileName, strg_ext);

clear Question;
clear strg_ext;

he = imread(FileName);
figure
imshow(he);
[im_index, map_index] = rgb2ind(he, 10000);
colormap(map_index);
close figure 1

l_w = size(im_index);
lenght = l_w(1);
wide = l_w(2);

for i=1:lenght
    for j=1:wide
        if (im_index(i,j) == 0)
            im_index(i,j) =1;
        end
    end
end



%% 2
% Section 2 - Color Characteristics
% This section will atribute the RGB section to the 1, 2 and 3 indices of
% the 3rd dimension of the Matrix
% This is a provisory step. After this, the colors of each pixel will be
% replaced by the average color of the pixel's region

   he = double(he);
   MAT_CARACT = he;
   
   % Filtering the image for less cluster numbers
   he_filt(:, :, 1) = medfilt2(he(:, :, 1));
   he_filt(:, :, 2) = medfilt2(he(:, :, 2));
   he_filt(:, :, 3) = medfilt2(he(:, :, 3));

    % he_filt(:, :, 1) = medfilt2(he_filt(:, :, 1));
    % he_filt(:, :, 2) = medfilt2(he_filt(:, :, 2));
    % he_filt(:, :, 3) = medfilt2(he_filt(:, :, 3));
    % 
    % he_filt(:, :, 1) = medfilt2(he_filt(:, :, 1));
    % he_filt(:, :, 2) = medfilt2(he_filt(:, :, 2));
    % he_filt(:, :, 3) = medfilt2(he_filt(:, :, 3));
    % 
    % he_filt(:, :, 1) = medfilt2(he_filt(:, :, 1));
    % he_filt(:, :, 2) = medfilt2(he_filt(:, :, 2));
    % he_filt(:, :, 3) = medfilt2(he_filt(:, :, 3));
    % 

   % WATERSHED - Sgmentation of the picture
   MAT_CLUSTER_COLOR = watershed_old(he_filt, 26);

   % It's called clustering color but it actually does everything
   MAT_CARACT_CLUSTER = clustering_color(MAT_CLUSTER_COLOR, lenght, wide);

%% 3
% Section 3 - Texture Characteristics
% This section will atribute the Texture section to the 4

%MAT_CARACT = find_texture(im_index,map_index, MAT_CARACT);

%% 4
% Section 4 - Gradient Characteristic
%  This section finds the diferent characteristics of the gradient
%               4th position - Magnitude of the Color gradient
%               5th position - Orientation of the Color Gradient
%               4th position - Magnitude of the Luminosity gradient
%               5th position - Orientation of the Luminosity Gradient

MAT_CARACT = find_gradient(im_index,map_index, MAT_CARACT);

%% 5
% Section 5 - Clustering of the pixels
% This section will associate the pixels in diferent clusters



%%
% %% 6
% % Section 6 - Comparison with the manually annotated images
% % We start by collecting the characteristics of the points
% % 
% % IDCard  .skys              .pointsCoordinates
% % IDCard  .vegetations       .pointsCoordinates
% % IDCard  .bricksOrConcretes .pointsCoordinates
% % IDCard  .roofs             .pointsCoordinates
% % IDCard  .windowpanes       .pointsCoordinates
% % IDCard  .doors             .pointsCoordinates
% % IDCard  .pedestrians       .pointsCoordinates
% 
% % Read the manully anotaded image
% test = imread(FileName);
% [im_ind_test, map_test] = rgb2ind(test, 10000);
% 
% 
% for i=1:lenght
%     for j=1:wide
%         if (im_ind_test(i,j) == 0)
%             im_ind_test(i,j) =1;
%         end
%     end
% end
% 
% %% 6.1
% % Classification of the classes
% % The function auto_class is going to give as an output the average
% % of each parameter of all the known points of a certain group
% % Let's see the sky first
% 
% %SKY
% string_sky = IDCard.skys.pointsCoordinates;
%     if sum(string_sky) == 0;
%         clear string_sky;
%     else
%     vector_sky = auto_class(im_ind_test, map_test, string_sky);
%     end
%     
% %VEGETATIONS
% string_veg = IDCard.vegetations.pointsCoordinates;
%     if sum(string_veg) == 0;
%         clear string_veg;
%     else
%     vector_veg = auto_class(im_ind_test, map_test, string_veg);
%     end
% 
% %BRINCKS OR CONCRETES
% string_boc = IDCard.bricksOrConcretes.pointsCoordinates;
%     if sum(string_boc) == 0;
%         clear string_boc;
%     else
%         vector_boc = auto_class(im_ind_test, map_test, string_boc);
%     end
%     
% %ROOFS
% string_roof = IDCard.roofs.pointsCoordinates;
%     if sum(string_boc) == 0;
%         clear string_boc;
%     else
%         vector_roof = auto_class(im_ind_test, map_test, string_boc);
%     end
%     
% %WINDOWS
% string_windws = IDCard.windowpanes.pointsCoordinates;
%     if sum(string_windws) == 0;
%         clear string_windws;
%     else
%         vector_windws = auto_class(im_ind_test, map_test, string_windws);
%     end
%     
% %DOORS
% string_doors = IDCard.doors.pointsCoordinates;
%     if sum(string_doors) == 0;
%         clear string_doors;
%     else
%         vector_doors = auto_class(im_ind_test, map_test, string_doors);
%     end
%     
% %PEDESTRIANS
% string_ped = IDCard.pedestrians.pointsCoordinates;
%     if sum(string_ped) == 0;
%         clear string_ped;
%     else
%         vector_ped = auto_class(im_ind_test, map_test, string_ped);
%     end
% 
