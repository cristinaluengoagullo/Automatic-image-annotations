% Find the Gradient Algorithm
% Description - This function will search how much the surrodings of a
% pixel change, according to its neighbour pixels
%
%     PIXELS:
%             _______________________
%             |      | north |      |
%             |  west| PIXEL |east  |
%             |______|_south_|______|
%
% This happens by subtracting the colors of the upper, downer, left and
% right pixel and computing all these values together
%
% INPUTS - he_filt(x, y, 3)   - 3D matrix with the filtered image
%        - im_seg(x, y, 3)    - 3D matrix with the number of the
%                               cluster associated with each pixel 
%                               Note: Each pixel belongs to 3 Clusters
%        - lenght and wide    - Size of the matrix to save
%                               computacional time
%        - x and y            - Coordenates of the pixel in
%                               analyses
%
% OUTPUT - vect_grad          - Vector with 2 components:
%                                -The average gradient magnitude of the
%                                 region
%                                -The average gradient orientation of the
%                                 region

function vect_grad = find_gradient(he_filt, im_seg, lenght, wide, x, y)
    % Cycle for the 3 dimensions (possible clusters)
    for e=1:3 
        % Number of the cluster of the pixel in analysis
        seg_num = im_seg(x, y, e);     
        % Vector where the average color of each cluster will be associated to
        sum_Mag = 0;
        sum_Ori = 0;
        counter = 0;
        %Cycle for all the pixels
        for i=1:lenght
            for j=1:wide
                if (im_seg(i,j, e) == seg_num)
                    counter = 1+ counter;
                    %% Edge of the picture
                    % Condition if the pixel is in the extremes of the picture.
                    % This is importante because there if the pixel belong to the
                    % last line of pixel of the image, it doenst have all the 4
                    % necessary neighboors for the Gradiente computation
                    % If this happens, in this case, we just assume 0 so it
                    % doenst influence the computation
                    if (i==1 || j==1 || i==lenght || j==wide)
                        sum_Ori = 0;          
                        sum_Mag = 0;
                    else
                        %% Analyses of the surroding pixels
                        % Retreive the RGB information of the 4 pixels surronding the
                        % pixel in study
                        rgb_north = he_filt(i, j-1, e);
                        rgb_south = he_filt(i, j+1, e);
                        rgb_west = he_filt(i-1, j, e);
                        rgb_east = he_filt(i+1, j, e);
                        rgb_dy_vect = rgb_north - rgb_south;
                        rgb_dx_vect = rgb_west - rgb_east;
                        % Computation of the gradient by subtraction of the surroding
                        % values
                        rgb_dy = rgb_dy_vect;
                        rgb_dx = rgb_dx_vect;
                        % Condition in case tan^-1 is zero. Just means the angle is 0  
                        if rgb_dx == 0
                            teta = 90;
                        else
                            teta = atand(rgb_dy/rgb_dx);
                        end
                        %% Computation of the gradient
                        sum_Mag = sqrt(rgb_dy^2 + rgb_dx^2) + sum_Mag;    
                        sum_Ori = teta + sum_Ori;  
                    end
                end
            end
        end
        sum_Mag_vect(e) = sum_Mag/counter;
        sum_Ori_vect(e) = sum_Ori/counter;   
    end
    vect_grad(1, 1) = mean(sum_Mag_vect);
    vect_grad(2, 1) = mean(sum_Ori_vect);
end