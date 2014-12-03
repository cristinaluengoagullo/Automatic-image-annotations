function [region_sizes] = get_region_sizes(area_points,img_seg)
    region_sizes = zeros(length(area_points),1);
    
    size_t = size(area_points);
    for i = 1:size_t(1)
        x = floor(area_points(i,2));
        y = floor(area_points(i,1));
        l_w = size(img_seg);
        len = l_w(1);
        wid = l_w(2);
        region_sizes(i) = get_region_size(img_seg,x,y,len,wid);
    end
end

function region_size = get_region_size(im_seg, x, y, length, width)
    region_numb(1) = im_seg(x, y, 1);
    region_numb(2) = im_seg(x, y, 2);
    region_numb(3) = im_seg(x, y, 3);
    counter(1) = 0.0;
    counter(2) = 0.0;
    counter(3) = 0.0;
    counter = double(counter);
    
    for e=1:3
        for i=1:length
            for j=1:width
               
                if region_numb(e)==im_seg(i, j, e)
                    counter(e) = counter(e)+1;
                end
                
            end
        end
    end 
    region_size = floor(mean(counter));
end
