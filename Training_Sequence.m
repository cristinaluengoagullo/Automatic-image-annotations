% Top-Level Hierarquy of the project
%
% Matrix of the caracteristics has the folowing definitions:
% i dimensions: Y coordenate of the pixel (lines)
% j dimensions: X coordenate of the pixel (lines)
% z dimensions: 1st - R characteristic (from RGB)
%               2nd - G characteristic
%               3rd - B characteristc
%               4th - Texture  
%               5th - Size of the Region
%               6th - Position (how high it is) 
%               7th - Gradient Magnitude
%               8th - Gradient Orientation
%               9th - Cluster Category
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%% PROJECT BY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%  Cristina  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%    Javi    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%    Jo�o    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
% This script is to colect the data from the sequence
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
    % If the file doesnt exist, nothing happens    
    else
        
    load(name_m); 
    he = imread(name_jpg);
    
    
    MAT_PRV = GetCharac(he, IDCard);
    
    s = size(MAT_PRV);     
    MAT_F(size_mat:(size_mat+s(1)-1), 1:9) = MAT_PRV;
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

clear a;
clear b;
clear c;
clear d;
clear e;
clear f;
clear g;

clear a_c;
clear b_c;
clear c_c;
clear d_c;
clear e_c;
clear f_c;
clear g_c;