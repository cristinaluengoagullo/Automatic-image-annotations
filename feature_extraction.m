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
        I = imread(fileName);
        I = double(I);
        he_filt(:, :, 1) = medfilt2(I(:, :, 1));
        he_filt(:, :, 2) = medfilt2(I(:, :, 2));
        he_filt(:, :, 3) = medfilt2(I(:, :, 3));
        img_seg = watershed_old(he_filt, 26);
        if (sum(pskys) == 0)
            cskys = [];
            tskys = [];
            sskys = [];
        else
            cskys = get_colours(pskys,he_filt, img_seg);
            tskys = get_textures(pskys,I);
            sskys = get_region_sizes(pskys,img_seg);
        end
        if(sum(pvegs) == 0)
            cvegs = [];
            tvegs = [];
            svegs = [];           
        else
            cvegs = get_colours(pvegs,he_filt, img_seg);
            tvegs = get_textures(pvegs,I);
            svegs = get_region_sizes(pvegs,img_seg);
        end
        if(sum(pbricks) == 0)
            cbricks = [];
            tbricks = [];
            sbricks = [];
        else
            cbricks = get_colours(pbricks,he_filt, img_seg);
            tbricks = get_textures(pbricks,I);
            sbricks = get_region_sizes(pbricks,img_seg);
        end
        if(sum(proofs) == 0)
            croofs = [];
            troofs = [];
            sroofs = [];          
        else
            croofs = get_colours(proofs,he_filt, img_seg);
            troofs = get_textures(proofs,I);
            sroofs = get_region_sizes(proofs,img_seg);
        end
        if(sum(pwindows) == 0)
            cwindows = [];
            twindows = [];
            swindows = [];           
        else
            cwindows = get_colours(pwindows,he_filt, img_seg);
            twindows = get_textures(pwindows,I);
            swindows = get_region_sizes(pwindows,img_seg);
        end
        if(sum(pdoors) == 0)
            cdoors = [];
            tdoors = [];
            sdoors = [];          
        else
            cdoors = get_colours(pdoors,he_filt, img_seg);
            tdoors = get_textures(pdoors,I);
            sdoors = get_region_sizes(pdoors,img_seg);
        end
        if(sum(ppeds) == 0)
            cpeds = [];
            tpeds = [];
            speds = [];          
        else
            cpeds = get_colours(ppeds,he_filt, img_seg);
            tpeds = get_textures(ppeds,I);
            speds = get_region_sizes(ppeds,img_seg);
        end
        skys = [cskys tskys sskys ones(length(pskys),1)];
        vegs = [cvegs tvegs svegs repmat(2,length(pvegs),1)];
        bricks = [cbricks tbricks sbricks repmat(3,length(pbricks),1)];
        roofs = [croofs troofs sroofs repmat(4,length(proofs),1)];
        windows = [cwindows twindows swindows repmat(5,length(pwindows),1)];
        doors = [cdoors tdoors sdoors repmat(6,length(pdoors),1)];
        peds = [cpeds tpeds speds repmat(7,length(ppeds),1)];
        % The final dataset is the composition of the values in all the
        % points present in the manual annotation of the current image
        dataset = [dataset;skys;vegs;bricks;roofs;windows;doors;peds];
    end
    toc
end
