function num_reg = get_region_number(img_seg, x, y)
    if (img_seg(x,y) ~= 0)
        num_reg = img_seg(x,y);
    else
        %   _____________
        %   |   |   |   |   1: Position (x-1,y-1) from the pixel
        %   | 1 | 2 | 3 |   2: Position (x-1,y) from the pixel
        %   |___|___|___|   3: Position (x-1,y+1) from the pixel
        %   |   |   |   |   4: Position (x,y-1) from the pixel
        %   | 4 | P | 5 |   5: Position (x,y+1) from the pixel
        %   |___|___|___|   6: Position (x+1,y-1) from the pixel
        %   |   |   |   |   7: Position (x+1,y) from the pixel
        %   | 6 | 7 | 8 |   8: Position (x+1,y+1) from the pixel
        %   |___|___|___|   P: Position of the pixel (x,y)
        %
        window = [ [-1 -1]; [-1 0]; [-1 1]; [0 -1]; [0 1]; [+1 -1]; [1 0]; [1 1] ];
        
        % Matrix limits
        l_w = size(img_seg);
        len = l_w(1);
        wid = l_w(2);
        
        % Vector that holds the numbers of the regions in neighbor pixels from 1 to 8
        regions = [];
        
        % Loop through the neighbors
        for k = 1:size(window,1)
           i = window(k,1);
           j = window(k,2);
           
           % Actual point from neighborhood
           i = x + i;
           j = y + j;
           
           % Check if point is within the limits of the matrix and doesn't have 0 its region number 
           if (i >= 1 && i <= len && j >= 1 && j <= wid && img_seg(i,j) ~= 0)
               regions = [regions img_seg(i,j)];
           end
        end
        % If a valid region number isn't found, a random region number is assigned
        if(isempty(regions))
            num_reg = randi(max(img_seg(:)));
        else
            % The final region number is the most frequent among the neighborhood
            num_reg = mode(regions);
        end
    end
end 