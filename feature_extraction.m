% Functin to extract the features of the manually annotated pixels of each
% area of interest.
%   directory: Directory where the .jpg and .mat files are stored
%   dataset: Resulting dataset with features as columns and pixels as rows
function [dataset] = feature_extraction(directory)
    files = dir(strcat(directory,'*.jpg'));
    dataset = [];
    % Loop through all the images and .mat files of the directory
    for k = 1:length(files)
        % fileName.jpg
        fileName = strcat(strcat(directory,files(k).name));
        lNames = strsplit(files(k).name,'.');
        % fileName.mat
        matFileName = strcat(strcat(directory,strcat(lNames{1},'.mat')));
        % IDCard variable from .mat files
        idCard = load(matFileName,'IDCard');
        % We extract the coordinates of the points belonging to each area
        % of interest
        [pskys,pvegs,pbricks,proofs,pwindows,pdoors,ppeds] = regions_points(idCard);
        % We read the image to be able to extract pixel colours
        I = imread(fileName);
        % Each matrix holds the colours of the pixels in the area they
        % represent
        cskys = get_colours(pskys,I,1);
        cvegs = get_colours(pvegs,I,2);
        cbricks = get_colours(pbricks,I,3);
        croofs = get_colours(proofs,I,4);
        cwindows = get_colours(pwindows,I,5);
        cdoors = get_colours(pdoors,I,6);
        cpeds = get_colours(ppeds,I,7);
        % The final dataset is the composition of the values in all the
        % points present in the manual annotation of the current image
        dataset = [dataset;cskys;cvegs;cbricks;croofs;cwindows;cdoors;cpeds];
    end
end

% Function to extract the colours of the manually annotated pixels in an
% area of interest.
%   list: list of pixel coordinates from an area
%   I: Image of study
%   area: Area of interest 
%       1: sky
%       2: vegetation
%       3: bricks or concrete
%       4: roofs
%       5: windows
%       6: doors
%       7: pedestrians
%   newList: list of colours of the pixels belonging to the area
function [newList] = get_colours(list,I,area)
    newList = zeros(length(list),4);
    for i = 1:length(list)
        colour = impixel(I,list(i,1),list(i,2));
        % [Provisional]: We add the num of the area to the row
        newList(i,1:4) = [colour area];
    end
end