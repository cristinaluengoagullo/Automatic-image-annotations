% GRADIENT Test
function MAT_CARACT = find_gradient(im_ind, map, MAT_CARACT)

l_w = size(im_ind);
lenght = l_w(1);
wide = l_w(2);

clear l_w;
change = 0.5;

for i=1:lenght
   for j=2:wide
       
       if im_ind(i,j) == 0
       im_ind(i,j) = 1;
       end
       
   end
end

%Cycle for all the pixels
for i=1:lenght
   for j=1:wide
       
       % Computation and finding of the magnitude of the gradiente
       % Computation and findinf of the orientation of the gradiente
       %
       %     PIXELS:
       %             _______________________
       %             |      | north |      |
       %             |  west| PIXEL |east  |
       %             |      | south |      |
       %
       %
       %
       %
       
       % RGB
      
       
       if i==1 | j==1 | i==lenght | j==wide
           GRAD_MAG_RGB(i, j)    = 1;
           GRAD_ORIEN_RGB(i, j)  = 1;
           GRAD_MAG_LUMI(i, j)   = 1;
           GRAD_ORIEN_LUMI(i, j) = 1;
       else
% %        rgb_north = rgb_coord(i, j-1, im_ind, map);
% %        rgb_south = rgb_coord(i, j+1, im_ind, map);
% %        
% %        rgb_west = rgb_coord(i-1, j, im_ind, map);
% %        rgb_east = rgb_coord(i+1, j, im_ind, map);
% %        
% %        % Computing the Gradient Magnitude
% %        rgb_dy_vec = rgb_north - rgb_south;
% %        rgb_dy = sqrt(rgb_dy_vec(1)^2  +  rgb_dy_vec(2)^2  + rgb_dy_vec(3)^2);
% %        
% %        rgb_dx_vec = rgb_west - rgb_east;
% %        rgb_dx = sqrt(rgb_dx_vec(1)^2  +  rgb_dx_vec(2)^2  + rgb_dx_vec(3)^2);
% %        
       
       rgb_north = RGB_gradient(i, j-1, im_ind, map);
       rgb_south = RGB_gradient(i, j+1, im_ind, map);
       
       rgb_west = RGB_gradient(i-1, j, im_ind, map);
       rgb_east = RGB_gradient(i+1, j, im_ind, map);
     

       rgb_dy_vect = rgb_north - rgb_south;
       rgb_dx_vect = rgb_west - rgb_east;
       
       rgb_dy = norm(rgb_dy_vect);
       rgb_dx = norm(rgb_dx_vect);
       
       
       GRAD_MAG_RGB(i, j) = sqrt(rgb_dy^2 + rgb_dx^2);

       if rgb_dx == 0
           teta = 90;
       else
           teta = atand(rgb_dy/rgb_dx);
       end
       GRAD_ORIEN_RGB(i, j) = teta;
       
       
       
       %LUMINOSITY
       lumi_north = luminosidade(i, j-1, im_ind, map);
       lumi_south = luminosidade(i, j+1, im_ind, map);
       
       lumi_west = luminosidade(i-1, j,im_ind, map);
       lumi_east = luminosidade(i+1, j,im_ind, map);
       
       % Computing the gradiente
       
       lumi_dy = lumi_north - lumi_south;
       lumi_dx = lumi_west - lumi_east;
       
       GRAD_MAG_LUMI(i, j) = sqrt(lumi_dy^2 + lumi_dx^2);

       if lumi_dx == 0
           teta = 90;
       else
           teta = atand(lumi_dy/lumi_dx);
       end
       GRAD_ORIEN_LUMI(i, j) = teta;
       
       
       end
   end
end



MAT_CARACT(:, :, 5) = GRAD_MAG_RGB;
MAT_CARACT(:, :, 6) = GRAD_ORIEN_RGB;
MAT_CARACT(:, :, 7) = GRAD_MAG_LUMI;
MAT_CARACT(:, :, 8) = GRAD_ORIEN_RGB;




