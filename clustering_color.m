% 5
% Section 5 - Clustering of the pixels
% This section will associate the pixels in diferent clusters
function MAT_CARACT_CLUSTER = clustering_color(he, lenght, wide);
he_filt(:, :, 1) = medfilt2(he(:, :, 1));
he_filt(:, :, 2) = medfilt2(he(:, :, 2));
he_filt(:, :, 3) = medfilt2(he(:, :, 3));
% 
% figure
% imshow(he_filt);
% 
% he_filt(:, :, 1) = medfilt2(he_filt(:, :, 1));
% he_filt(:, :, 2) = medfilt2(he_filt(:, :, 2));
% he_filt(:, :, 3) = medfilt2(he_filt(:, :, 3));
% 
% figure
% imshow(he_filt);
% 
% he_filt(:, :, 1) = medfilt2(he_filt(:, :, 1));
% he_filt(:, :, 2) = medfilt2(he_filt(:, :, 2));
% he_filt(:, :, 3) = medfilt2(he_filt(:, :, 3));
% 
% figure
% imshow(he_filt);
% 
% he_filt(:, :, 1) = medfilt2(he_filt(:, :, 1));
% he_filt(:, :, 2) = medfilt2(he_filt(:, :, 2));
% he_filt(:, :, 3) = medfilt2(he_filt(:, :, 3));
% 
% figure
% imshow(he_filt);

MAT_CLUSTER_COLOR = watershed_old(he_filt, 26);

% figure;
% imshow(MAT_CLUSTER_COLOR);
% title('Watershed of the image');
% 
% figure
% imshow(he_filt);

for e=1:3

    for j=1:wide
        if (MAT_CLUSTER_COLOR(1, j, e) == 0)
            MAT_CLUSTER_COLOR(1, j, e) = MAT_CLUSTER_COLOR(1, j-1, e);
        end
    end
    
  for i=2:lenght
    for j=1:wide
        
        if(MAT_CLUSTER_COLOR(i, j, e) == 0)
           MAT_CLUSTER_COLOR(i, j, e) = MAT_CLUSTER_COLOR(i-1, j, e);
        end
    end
  end
end

counter_R = 0;
counter_G = 0;
counter_B = 0;
counter_size = 0;

sum_R = 0;
sum_G = 0;
sum_B = 0;

a = max(max(MAT_CLUSTER_COLOR(:, :, 1)));
b=1;
i=1;
j=1;

for b=1:a
          sum_R(b) = 0;
          sum_G(b) = 0;
          sum_B(b) = 0;     
    
          counter_R = 0;
          counter_G = 0;
          counter_B = 0;
          
  for i=1:lenght
    for j=1:wide
        
        %%%%%%%%%%%%%% COLOR %%%%%%%%%%%%%%%%%
        if( MAT_CLUSTER_COLOR(i, j, 1) == b)
          counter_R = counter_R +1;          
          sum_R(b) = double(he_filt(i, j, 1)) + sum_R(b); 
        end
        
        if (MAT_CLUSTER_COLOR(i, j, 2) == b)
               counter_G = counter_G +1;   
               sum_G(b) = double(he_filt(i, j, 2)) + sum_G(b);
        end
        
        if( MAT_CLUSTER_COLOR(i, j, 3) == b)
          counter_B = counter_B +1;  
          sum_B(b) = double(he_filt(i, j, 3)) + sum_B(b);
        end  
        %%%%%%%%%%%%%% COLOR %%%%%%%%%%%%%%%%%   
        
    end
  end
   
   if(counter_R ~= 0)
   sum_R(b) = sum_R(b)/(counter_R-1);
   end
   
   if(counter_G ~= 0)
   sum_G(b) = sum_G(b)/(counter_G-1);
   end
   
   if(counter_B ~= 0)
   sum_B(b) = sum_B(b)/(counter_B-1);
   end
   
  for i=1:lenght
    for j=1:wide
        
       if(MAT_CLUSTER_COLOR(i, j) == b)
          MAT_CARACT_CLUSTER(i, j, 1) = round(sum_R(b)); 
          MAT_CARACT_CLUSTER(i, j, 2) = round(sum_G(b)); 
          MAT_CARACT_CLUSTER(i, j, 3) = round(sum_B(b)); 
       end  
       
       %%%%%%%%%%%%%% SIZE %%%%%%%%%%%%%%%%%
       MAT_CARACT_CLUSTER(i, j, 4) = find_size(MAT_CLUSTER_COLOR, i, j, lenght, wide);     
       %%%%%%%%%%%%%% SIZE %%%%%%%%%%%%%%%%%       
       
    end
  end
    
  
  waitbar(b/a);
end

% MAT_CARACT_CLUSTER = uint8(MAT_CARACT_CLUSTER);
% figure
% imshow(MAT_CARACT_CLUSTER);
% title('Cluster');
% 
% figure
% imshow(he);