
Project in Image Processing and Computer Vision
Anotaded Image Segmentation
CRISTINA LUENGO - JAVIER NAVARRO - JOAO ROCHA 




The Top-Hierarchy file is the file named mat2arff.m


%%%%% RUN THE PROJECT %%%%%%

To run this project, simply create a folder in the directory where the images and .mat files are. For example, a folder named "images" and run the following comand:

mat2arff('images/', 'train.arff', 'train');

This will create a .arff file to use in the Weka tool (for the train phase if 'train' is specified and for the test phase if 'test' is specified). The weka folder contains information
for the classification task.
It will also create a Nx11 Matrix (N being the amount of annotaded pixels) in Matlab's Workspace with 10 feactures and a class by pixel 


%%%%% Files & Functions %%%%%%

Filename: mat2arff.m
	Functions: mat2arff - Tihs function, receives the inputs 				indicated above and creates an arff file with 				the dataset. This function also calls the 					feature extraction function where all the 					features will be extracted  
			
			write_header - writes the initial part of the 				arff file

Filename: feature_extraction.m
	Functions: feature_extraction - This functions has the 					directory as an input and its going to go 					trough all the files, calling other 						functions to retreive the features

Filename: get_pixels_features.m
	Functions: get_pixels_features - This functions uses the 				pixel coordenates and the greyscale image to 				retreive the texture

Filename: get_region_features.m
	Functions: get_region_features - This function is where 				the RGB components, the Gradients, the 					position and the size of a region are 					going to be collected

Filename: find_gradient.m
	Functions: find_gradient - This function is where the 					computation of the gradient is going to 					take place. The inputs are the grayscale 					image (see	Report), the dimensions of the 					image and the position of the anotaded 					pixel

Filename: get_region_number.m
	Functions: get_region_number - This function simply counts how 				many pixels belong to the same region

Filename: regions_points.m
	Functions: regions_points - This function extracts the 					coordinates of each region point from the IDCard 
			













			


