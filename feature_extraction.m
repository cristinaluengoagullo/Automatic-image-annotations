% Functin to extract the features of the manually annotated pixels of each
% area of interest.
%   directory: Directory where the .jpg and .mat files are stored
%   dataset: Resulting dataset with features as columns and pixels as rows

function [dataset] = feature_extraction(directory)
tic
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
        img = imread(fileName);
        img = double(img);
        % Image in gray scale
        img_gray = rgb2gray(img);
        % Filtered image
        he_filt(:,:) = medfilt2(img_gray(:,:));
        % Label matrix of the segmentation
        img_seg = watershed(he_filt,26);
        % Number of regions
        num_regions = max(img_seg(:));
        % Features of each region (colour average, gradients average,
        % center of the region and number of pixels in the region)
        regions_features = get_regions_features(img,img_gray,img_seg,num_regions);
        
        if (sum(pskys) == 0)
            fskys = [];
        else
            fskys = get_pixels_features(regions_features,pskys,img_gray,img_seg);
        end

        if (sum(pvegs) == 0)
            fvegs = [];
        else
            fvegs = get_pixels_features(regions_features,pvegs,img_gray,img_seg);
        end        
        
        if (sum(pbricks) == 0)
            fbricks = [];
        else
            fbricks = get_pixels_features(regions_features,pbricks,img_gray,img_seg);
        end          
        
        if (sum(proofs) == 0)
            froofs = [];
        else
            froofs = get_pixels_features(regions_features,proofs,img_gray,img_seg);
        end   
        
        if (sum(pwindows) == 0)
            fwindows = [];
        else
            fwindows = get_pixels_features(regions_features,pwindows,img_gray,img_seg);
        end   
        
        if (sum(pdoors) == 0)
            fdoors = [];
        else
            fdoors = get_pixels_features(regions_features,pdoors,img_gray,img_seg);
        end 
        
        if (sum(ppeds) == 0)
            fpeds = [];
        else
            fpeds = get_pixels_features(regions_features,ppeds,img_gray,img_seg);
        end 
        
        skys = [fskys ones(size(fskys,1),1)];
        vegs = [fvegs repmat(2,size(fvegs,1),1)];
        bricks = [fbricks repmat(3,size(fbricks,1),1)];
        roofs = [froofs repmat(4,size(froofs,1),1)];
        windows = [fwindows repmat(5,size(fwindows,1),1)];
        doors = [fdoors repmat(6,size(fdoors,1),1)];
        peds = [fpeds repmat(7,size(fpeds,1),1)];
        % The final dataset is the composition of the values in all the
        % points present in the manual annotation of the current image
        dataset = [dataset;skys;vegs;bricks;roofs;windows;doors;peds];
    end
    toc
end
