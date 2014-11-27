function MAT_CLASS = GetRGB(string,image)

% IDCard."class".pointsCoordinates
size_string = size(string);

% Let's find the charateristics of the class

% Find out the RGB of the class
% R - 1st position
% G - 2nd postion
% B - 3rd postion

for i=1:size_string
    class(i, 1) = floor(string(i, 2));
    class(i, 2) = floor(string(i, 1));
    
    MAT_CLASS(i,1) = image(class(i, 1), class(i, 2), 1); % R Parameter   
    MAT_CLASS(i,2) = image(class(i, 1), class(i, 2), 2); % G Parameter
    MAT_CLASS(i,3) = image(class(i, 1), class(i, 2), 3); % B Parameter
           
%Find out the texture of the sky

% MAT_SKY(i, 4)


% Find out the gradient of the class
% Color Gradient Magnitude
% Color Gradiente Orientação

%     rgb_north = RGB_gradient(class(i, 1), class(i, 2)-1, im_ind, map);
%     rgb_south = RGB_gradient(class(i, 1), class(i, 2)+1, im_ind, map);
%       
%     rgb_west = RGB_gradient(class(i, 1)-1, class(i, 2), im_ind, map);
%     rgb_east = RGB_gradient(class(i, 1)+1, class(i, 2), im_ind, map);
%      
% 
%     rgb_dy_vect = rgb_north - rgb_south;
%     rgb_dx_vect = rgb_west - rgb_east;
%        
%     rgb_dy = norm(rgb_dy_vect);
%     rgb_dx = norm(rgb_dx_vect);
% 
% % Gradiente Magnitude
%     MAT_CLASS(i,5) = sqrt(rgb_dy^2 + rgb_dx^2);
%     
%         if rgb_dx == 0
%            teta = 90;
%         else
%            teta = atand(rgb_dy/rgb_dx);
%         end
%     
% % Gradiente Orientation
%     MAT_CLASS(i, 6) = teta;
% 
% %LUMINOSITY
% % Luminosity Gradient Magnitude
% % Luminosity Gradiente Orientação   
%     
% 
%        lumi_north = luminosidade(class(i, 1), class(i, 2)-1, im_ind, map);
%        lumi_south = luminosidade(class(i, 1), class(i, 2)+1, im_ind, map);
%        
%        lumi_west = luminosidade(class(i, 1)-1, class(i, 2), im_ind, map);
%        lumi_east = luminosidade(class(i, 1)+1, class(i, 2), im_ind, map);
%        
%        
%        lumi_dy = lumi_north - lumi_south;
%        lumi_dx = lumi_west - lumi_east;
%        
%        MAT_CLASS(i, 7) = sqrt(lumi_dy^2 + lumi_dx^2);
% 
%            if lumi_dx == 0
%                teta = 90;
%            else
%                teta = atand(lumi_dy/lumi_dx);
%            end
%        MAT_CLASS(i, 8) = teta;
end

% Average of all the elements

clear size_string;
clear class;
clear string;
% clear im_ind;
% clear map;
% 
% clear teta;
% 
% clear dy;
% clear dx;
% 
% clear rgb_north;
% clear rgb_south;
% clear rgb_east;
% clear rgb_west;
% 
% clear lumi_north;
% clear lumi_south;
% clear lumi_east;
% clear lumi_west;
