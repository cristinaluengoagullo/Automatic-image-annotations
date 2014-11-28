function [text_vals] = get_textures(area_points,img)
    %cform = makecform('srgb2lab');
    %lab_img = applycform(img, cform);
    
    size_t = size(area_points);
    text_ranges = stdfilt(img);
    text_vals = zeros(length(area_points),3);
    for i = 1:size_t(1)
        text = text_ranges(floor(area_points(i,2)),floor(area_points(i,1)),1:3);
        text_vals(i,1:3) = text;
    end
end