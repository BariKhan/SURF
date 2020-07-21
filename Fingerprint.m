addpath('D:\Presentation\Image and video');
x=imread('cross.jpg');

a = imread('6.jpg');
figure;
imshow(a);
title('Finger Print 1');
a = rgb2gray(a);

b = imread('7.jpg');
figure;
imshow(b);
title('Finger Print 2');
b = rgb2gray(b);

FP1Points = detectSURFFeatures(a);
FP2Points = detectSURFFeatures(b);

figure;
imshow(a);
title('100 Strongest Feature Points from Finger Print 1');
hold on;
plot(selectStrongest(FP1Points, 100));

figure;
imshow(b);
title('300 Strongest Feature Points from Finger Print 2');
hold on;
plot(selectStrongest(FP2Points, 300));

[FP1Features, FP1Points] = extractFeatures(a, FP1Points);
[FP2Features, FP2Points] = extractFeatures(b, FP2Points);

FPPairs = matchFeatures(FP1Features, FP2Features);

matchedFP1Points = FP1Points(FPPairs(:, 1), :);
matchedFP2Points = FP2Points(FPPairs(:, 2), :);
figure;
showMatchedFeatures(a, b, matchedFP1Points, ...
    matchedFP2Points, 'montage');
title('Putatively Matched Points (Including Outliers)');

[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedFP1Points, matchedFP2Points, 'affine');

figure;
showMatchedFeatures(a, b, inlierBoxPoints, ...
    inlierScenePoints, 'montage');
title('Matched Points (Inliers Only)');

 % IS there any metric can used to make accurate decision if there is a match or not instead of percentage because its not accurate as required 
  numPairs = length(FPPairs); %the number of pairs
  percentage  = numPairs/100;

     if percentage >= 0.80
        disp('MATCHED');
        figure;
        imshow(b);
        hold on;
        title('Matched');
       

     else
        disp('NO MATCH');
        figure;
        imshow(x);
        hold on;
        title('NO MATCH');
        
        disp(percentage);
       
     end






