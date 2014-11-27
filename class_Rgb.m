function class_Rgb
% IDCard."sky".pointsCoordinates
size_string = size(string);

% Let's find the charateristics of the class

% Find out the RGB of the class
% R - 1st position
% G - 2nd postion
% B - 3rd postion

for i=1:size_string
    
    class(i, 1) = floor(string(i, 2));
    class(i, 2) = floor(string(i, 1));
    
    MAT_CLASS(i,1) = map(im_ind(class(i, 1), class(i, 2)), 1)*255; % R Parameter   
    MAT_CLASS(i,2) = map(im_ind(class(i, 1), class(i, 2)), 2)*255; % G Parameter
    MAT_CLASS(i,3) = map(im_ind(class(i, 1), class(i, 2)), 3)*255; % B Parameter

end  