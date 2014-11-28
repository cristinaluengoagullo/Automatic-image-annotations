function [gradients] = get_gradients(area_points,img, img_seg)
    l_w = size(img_seg);
    len = l_w(1);
    wid = l_w(2);   
    size_t = size(area_points);    
    gradients = zeros(length(area_points),2);
    for i = 1:size_t(1)
        gradient = find_gradient(img, img_seg, len, wid, floor(area_points(i,2)), floor(area_points(i,1)));
        gradients(i,1:2) = gradient;
    end
end