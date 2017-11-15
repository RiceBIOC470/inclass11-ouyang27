% Inclass11
%GB comments
1) 100
2) 100
3) 100
4) 100
overall: 100

% You can find a multilayered .tif file with some data on stem cells here:
% https://www.dropbox.com/s/83vjkkj3np4ehu3/011917-wntDose-esi017-RI_f0016.tif?dl=0

% 1. Find out (without reading  the entire file) -  (a) the size of the image in
% x and y, (b) the number of z-slices, (c) the number of time points, and (d) the number of
% channels.

file = '011917-wntDose-esi017-RI_f0016.tif';
reader = bfGetReader(file);
x = reader.getSizeX;
y = reader.getSizeY;
z = reader.getSizeZ;
time_points = reader.getSizeT;
channels = reader.getSizeC;

% Yu Ouyang's answer: x = y = 1024, z = 1, time_points = 68, channels = 2

% 2. Write code which reads in all the channels from the 30th time point
% and displays them as a multicolor image.

chan = 1;
time = 30;
zplane = 1;
iplane1 = reader.getIndex(zplane-1,chan-1,time-1)+1;
img1 = bfGetPlane(reader,iplane1);
imshow(img1, [500 2000]);

chan = 2;
iplane2 = reader.getIndex(zplane-1,chan-1,time-1)+1;
img2 = bfGetPlane(reader,iplane2);
imshow(img2, [500 2000]);

img2show = cat(3,imadjust(img1),imadjust(img2),zeros(size(img2)));
imshow(img2show);

% 3. Use the images from part (2). In one of the channels, the membrane is
% prominently marked. Determine the best threshold and make a binary
% mask which marks the membranes and displays this mask. 

img1_d = im2double(img1);
imgbright = uint16((2^16-1)*(img1_d/max(max(img1_d))));
imshow(imgbright);

% 4. Run and display both an erosion and a dilation on your mask from part
% (3) with a structuring element which is a disk of radius 3. Explain the
% results.

img_bw = img1>1000;
imshow(img_bw)
imshow(imerode(img_bw,strel('disk',1)));
imshow(imdilate(img_bw,strel('disk',1)));


% Yu Ouyang' answer: the erosion image gives a "shrinking"/"fading" image of
% membrane, while the dilation image shows a clear boundary for cells
% (membrane image). It is because the erosion "removes" signal, while the
% dilation "amplifies" signal
