
% This script is to colect the data from the training sequence

% Each letter represents a number of the name of the image
% 'g8-00p0-00p0-0'
% 'g8-gfpe-dcpb-a'

a = 0;     % 14 Element
b = 0;     % 12 Element
c = 0;     % 10 Element
d = 0;     % 9 Element
e = 0;     % 7 Element
f = 0;     % 5 Element
g = 0;     % 4 Element
size_mat = 1;

name = 'g8-00p0-00p0-0';
wait = 0;

for g =3:4;
 for f = 6:7;
  for e = 2:9;
   for d = 1:1;
    for c = 1:8;
     for b = 2:9;
      for a = 1:2;
      
    a_c = num2str(a);
    name(14) = a_c;
    
    name_m = strcat(name, '.mat');
    name_jpg = strcat(name, '.jpg');

    ex = exist(name_m, 'file');

    if ex == 0;
    % If the file doest exist, nothing happens
    
    else
    load(name_m); 
    he = imread(name_jpg);
    
    
    MAT_PRV = GetCharac(he, IDCard);
    
    s = size(MAT_PRV);     
    MAT_F(size_mat:(size_mat+s(1)-1), 1:5) = MAT_PRV;
    size_mat = s(1) + size_mat;
        
    end
    
    wait = wait+1;
    waitbar(wait/2744);

      end
     b_c = num2str(b);
     name(12) = b_c;
     end
    c_c = num2str(c);
    name(10) = c_c;     
    end
   d_c = num2str(d);
   name(9) = d_c; 
   end
  e_c = num2str(e);
  name(7) = e_c;   
  end
 f_c = num2str(f);
 name(5) = f_c;  
 end
g_c = num2str(g);
name(4) = g_c;   
end