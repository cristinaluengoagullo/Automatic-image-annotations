function rgb_vector = RGB_gradient(e, f, im_rgb, map_rgb)

rgb_vector = map_rgb(im_rgb(e, f), :);
% rgb_g = 0.3*rgb_vector(1) + 0.59*rgb_vector(2) + 0.11*rgb_vector(3);
% rgb_g = rgb_vector(1) + rgb_vector(2) + rgb_vector(3);
