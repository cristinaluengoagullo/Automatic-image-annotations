% im_seg as an input. Going to check the size of the segmentation

function s = find_size(im_seg, x, y, length, wide)
%he = imread('teste_5.jpg');

% he_filt(:, :, 1) = medfilt2(he(:, :, 1));
% he_filt(:, :, 2) = medfilt2(he(:, :, 2));
% he_filt(:, :, 3) = medfilt2(he(:, :, 3));
% im_seg = watershed_old(he_filt);

region_numb(1) = im_seg(x, y, 1);
region_numb(2) = im_seg(x, y, 2);
region_numb(3) = im_seg(x, y, 3);

counter = 0;
counter=double(counter);

for e=1:3
    for i=1:length
        for j=1:wide               
             if region_numb(e)==im_seg(i, j, e)
                counter = counter+1;
             end        
        end
    end
    counter_vect(e) = counter;
    counter = 0;
end

s = mean(counter_vect);

    
