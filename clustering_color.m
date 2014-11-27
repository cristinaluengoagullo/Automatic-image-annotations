% Color mean Algorithm
%
% Description - The function will change the value of the RGB of each pixel
% for the value of the mean RGB of it's region. This way, when analysing a
% certain category (sky, doors, etc), it doesnt assume the color only of
% the pixel but the averege color of it's surrondings
%
% INPUTS - he_filt(x, y, 3)            - 3D matrix with the filtered image
%        - MAT_CLUSTER_COLOR(x, y, 3)  - 3D matrix with the number of the
%                                        cluster associated with each pixel 
%                                        Note: Each pixel belongs to 3 Clusters
%        - lenght and wide             - Size of the matrix to save
%                                        computacional time
%        - x and y                     - Coordenates of the pixel in
%                                        analyses
%
% OUTPUT - vect_P_RGB()                - vector with 3 components(RGB)
%                                      - This components are the average
%                                        color of the Pixel's region


function vect_P_RGB = clustering_color(he_filt, MAT_CLUSTER_COLOR, lenght, wide, x, y)

for e=1:3
    
b=MAT_CLUSTER_COLOR(x, y, e); % Current cluster being analysed    
% Counters to count how many times it acessed a pixel of a certain cluster
counter_R = 0;
counter_G = 0;
counter_B = 0;

% Vector where the average color of each cluster will be associated to
sum_R = 0;
sum_G = 0;
sum_B = 0;

%% CALCULATE THE AVERAGE
% Step 1 - For each cluster, we have to go trought the intire matrix 2 times
% The first time we have to collect all the RGB values of the pixels in 
% a certain cluster
%
% Step 2 - Then, we have to divide the these values for the amount of 
%          Pixels that exist in each cluster (thus the counters)
%
% Step 3 - Substitute the RGB value of each pixel for the RGB value of its
%          region(cluster)


%% Step 1
  for i=1:lenght
    for j=1:wide
      
        if(MAT_CLUSTER_COLOR(i, j, 1) == b)
          counter_R = counter_R +1;          
          sum_R = he_filt(i, j, 1) + sum_R; 
          %sum_R = double(he_filt(i, j, 1)) + sum_R;
        end
        
        if (MAT_CLUSTER_COLOR(i, j, 2) == b)
           counter_G = counter_G +1;   
           sum_G = he_filt(i, j, 2) + sum_G;
           %sum_G = double(he_filt(i, j, 2)) + sum_G;
        end
        
        if( MAT_CLUSTER_COLOR(i, j, 3) == b)
          counter_B = counter_B +1;  
          sum_B = he_filt(i, j, 3) + sum_B;
          %sum_G = double(he_filt(i, j, 2)) + sum_G;
        end  
        
    end
  end
  
%% STEP 2  
   if(counter_R ~= 0)
   sum_R = sum_R/(counter_R);
   end
   
   if(counter_G ~= 0)
   sum_G = sum_G/(counter_G);
   end
   
   if(counter_B ~= 0)
   sum_B = sum_B/(counter_B);
   end
   
%% Step 3 -

vect_pixel(1, e) = sum_R;
vect_pixel(2, e) = sum_G;
vect_pixel(3, e) = sum_B;
end

vect_P_RGB(1, 1) = mean(vect_pixel(1, :));
vect_P_RGB(2, 1) = mean(vect_pixel(2, :));
vect_P_RGB(3, 1) = mean(vect_pixel(3, :));