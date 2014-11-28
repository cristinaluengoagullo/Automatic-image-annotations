% Function to extract the colours of the manually annotated pixels in an
% area of interest.
%   area_points: list of pixel coordinates from an area
%   img: Image of study
%   area_type: Area of interest 
%       1: sky
%       2: vegetation
%       3: bricks or concrete
%       4: roofs
%       5: windows
%       6: doors
%       7: pedestrians
%   newList: list of colours of the pixels belonging to the area
function [colours] = get_colours(area_points,img, img_seg)
    l_w = size(img_seg);
    len = l_w(1);
    wid = l_w(2);   
    size_t = size(area_points);    
    colours = zeros(length(area_points),3);
    for i = 1:size_t(1)
        colour = clustering_color(img, img_seg, len, wid, floor(area_points(i,2)), floor(area_points(i,1)));
        colours(i,1:3) = colour;
    end
end