function features = get_regions_features(img, img_gray, img_seg, num_regions)
    %% Matrix: row = num_regions; col: 8 
    features = zeros(num_regions,8); 
    
    R = 1;          % features(reg,R):       R component average of region 'reg'
    G = 2;          % features(reg,G):       G component average of region 'reg'
    B = 3;          % features(reg,B):       B component average of region 'reg'  
    G1 = 4;         % features(reg,G1):      Gradient property 1 average of region 'reg'
    G2 = 5;         % features(reg,G2):      Gradient property 2 average of region 'reg'
    Cx = 6;         % features(reg,Cx):      X position of the center of region 'reg'
    Cy = 7;         % features(reg,Cy):      Y position of the center of region 'reg'
    N = 8;          % features(reg,N):       Number of points in region 'reg'
    
    lw = size(img_seg);
    len = lw(1);
    wid = lw(2);   
    
    for i=1:len
        for j=1:wid
            % Region of i,j
            reg = get_region_number(img_seg,i,j);
            % Components of colour of region reg
            features(reg,R) = features(reg,R) + img(i,j,R);
            features(reg,G) = features(reg,G) + img(i,j,G);
            features(reg,B) = features(reg,B) + img(i,j,B);
            % Components of gradient of region reg
            grad = find_gradient_new(img_gray,len,wid,i,j);          
            features(reg,G1) = features(reg,G1) + grad(1);
            features(reg,G2) = features(reg,G2) + grad(2);
            % Sum of x's and y's of the region reg
            features(reg,Cx) = features(reg,Cx) + i;
            features(reg,Cy) = features(reg,Cy) + j;
            % Sum of points of the region reg 
            features(reg,N) = features(reg,N) + 1;
        end
    end
    
    for k=1:num_regions
        if (features(k,N) ~= 0)
            % R G B components average in region k
            features(k,R) = features(k,R)/features(k,N);
            features(k,G) = features(k,G)/features(k,N);
            features(k,B) = features(k,B)/features(k,N);
            % G1 and G2 components (Ori,Mag) in region k
            features(k,G1) = features(k,G1)/features(k,N);
            features(k,G2) = features(k,G2)/features(k,N);    
            % Coordenates x y of the center of region k
            features(k,Cx) = features(k,Cx)/features(k,N);
            features(k,Cy) = features(k,Cy)/features(k,N);
        end
    end
end