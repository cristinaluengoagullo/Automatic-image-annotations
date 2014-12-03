function [xsum, ysum, size] = get_region_centers_and_sizes(num_regions, img_seg)
    xsum = zeros(length(num_regions),1);    
    ysum = zeros(length(num_regions),1);    
    size = zeros(length(num_regions),1);   

    l_w = size(img_seg);
    
    for i=1:l_w(1)
        for j=1:l_w(2)
            for e=1:3
                % Region
                r = img_seg(i,j,e);
                % Summatory of x's
                xsum(r) = xsum(r) + i;
                % Summatory of y's
                ysum(r) = ysum(r) + j;
                % Size of the region
                size(r) = size(r) + 1;           %CHECK!     
            end
        end
    end

    for k=1:num_regions
        % Mean of x in region r 
        xsum(k) = xsum(k)/size(k);
        % Mean of y in region r
        ysum(k) = ysum(k)/size(k);
    end
end
