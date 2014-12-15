===== Contents =====
- Arff files necessary to run the classifier on the dataset using the weka tool. 
  Train and test datasets with all the features and without some features can be found in the Arff/ folder

- Output images from the Weka tool when testing without some features.
  Performance results are shown along with the confussion matrix for each test.
	* Files:
		all -> Performance results after carrying out the test phase on the dataset with all the features.
		no_colour -> Performance results after carrying out the test phase on the dataset without the colour.
		no_num_pixels_regions -> Performance results after carrying out the test phase on the dataset without the number of pixels of the
			segmented regions.
		no_positions_regions -> Performance results after carrying out the test phase on the dataset without the positions of the segmented 
			regions.