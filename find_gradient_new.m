% Find the Gradient Algorithm
% Description - This function will search how much the surrodings of a
% pixel change, according to its neighbour pixels
%
%     PIXELS:
%             _______________________
%             |      | north |      |
%             | west | PIXEL | east |
%             |______|_south_|______|
%
% This happens by subtracting the colors of the upper, downer, left and
% right pixel and computing all these values together
%
% INPUTS 
%        - he_filt(x, y, 3)   - 3D matrix with the filtered image
%        - lenght and wide    - Size of the matrix to save
%                               computacional time
%        - x and y            - Coordenates of the pixel in
%                               analyses
%
% OUTPUT - gradients          - Vector with 2 components:
%                                + The average gradient magnitude of the
%                                  region
%                                + The average gradient orientation of the
%                                  region
function gradients = find_gradient_new(img_gray, lenght, wide, x, y)
    %% Edge of the picture
    % Condition if the pixel is in the extremes of the picture.
    % This is importante because there if the pixel belong to the
    % last line of pixel of the image, it doenst have all the 4
    % necessary neighboors for the Gradiente computation
    % If this happens, in this case, we just assume 0 so it
    % doenst influence the computation
    if (x == 1 || y == 1 || x == lenght || y == wide)
        sum_Ori = 0;          
        sum_Mag = 0;
    else
        %% Analyses of the surroding pixels
        % Retreive the RGB information of the 4 pixels surronding the
        % pixel in study        
        rgb_north = img_gray(x,y-1);
        rgb_south = img_gray(x,y+1);
        rgb_west = img_gray(x-1,y);
        rgb_east = img_gray(x+1,y);
        rgb_dx_vect = rgb_west - rgb_east;
        rgb_dy_vect = rgb_north - rgb_south;
        % Computation of the gradient by subtraction of the surroding
        % values
        rgb_dx = rgb_dx_vect;
        rgb_dy = rgb_dy_vect;
        % Condition in case tan^-1 is zero. Just means the angle is 0  
        if rgb_dx == 0
            teta = 90;
        else
            teta = atand(rgb_dy/rgb_dx);
        end
        %% Computation of the gradient   
        sum_Ori = teta;        
        sum_Mag = sqrt(rgb_dy^2 + rgb_dx^2); 
    end
    gradients(1) = sum_Ori;
    gradients(2) = sum_Mag;
end