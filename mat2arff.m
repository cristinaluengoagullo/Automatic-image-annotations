% Function to transform a file to arff format 
function mat2arff(directory,newFile,set_type)
    write_header(newFile,set_type);
    [dataset] = feature_extraction(directory);
    dlmwrite(newFile,dataset,'delimiter',',','-append');
end

function write_header(newFile,set_type)
    dlmwrite(newFile,strcat({'@relation '},set_type),'delimiter','');
    % Features columns
    % 1:3) RCG components
    % 4) Texture component
    % 5) Region of the size each pixel from the dataset belongs to
    % 6:7) Reative position of the region each pixel belongs to 
    dlmwrite(newFile,'@attribute R REAL','delimiter','','-append');
    dlmwrite(newFile,'@attribute G REAL','delimiter','','-append');
    dlmwrite(newFile,'@attribute B REAL','delimiter','','-append');
%     dlmwrite(newFile,'@attribute text REAL','delimiter','','-append');
%     dlmwrite(newFile,'@attribute region_size REAL','delimiter','','-append');
%     dlmwrite(newFile,'@attribute x REAL','delimiter','','-append');
%     dlmwrite(newFile,'@attribute y REAL','delimiter','','-append');
    dlmwrite(newFile,'@attribute type {1,2,3,4,5,6,7}','delimiter','','-append');
    dlmwrite(newFile,'@data','delimiter','','-append');
end

