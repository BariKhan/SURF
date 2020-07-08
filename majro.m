addpath('F:\ACADEMICS\Projects\TESTING');

% addpath is used to select the directory of the files



a = imread('8.jpg');
figure;
imshow(a);
title('Clock');
a = rgb2gray(a);

%rgb2gray(a) converts to grayscale

b = imread('9.jpg');
figure;
imshow(b);
title('Image of a Cluttered Scene');
b = rgb2gray(b);

clockPoints = detectSURFFeatures(a);
scenePoints = detectSURFFeatures(b);


figure;
imshow(a);
title('100 Strongest Feature Points from Clock Image');
hold on;
plot(selectStrongest(clockPoints, 100));


figure;
imshow(b);
title('300 Strongest Feature Points from Scene Image');
hold on;
plot(selectStrongest(scenePoints, 300));


[boxFeatures, clockPoints] = extractFeatures(a, clockPoints);
[sceneFeatures, scenePoints] = extractFeatures(b, scenePoints);


boxPairs = matchFeatures(boxFeatures, sceneFeatures);


matchedBoxPoints = clockPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
figure;
showMatchedFeatures(a, b, matchedBoxPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');



[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');



figure;
showMatchedFeatures(a, b, inlierBoxPoints, ...
    inlierScenePoints, 'montage');
title('Matched Points (Inliers Only)');



boxPolygon = [1, 1;...                           % top-left
        size(a, 2), 1;...                 % top-right
        size(a, 2), size(a, 1);... % bottom-right
        1, size(a, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon
    
    
    
    
    
    
    newBoxPolygon = transformPointsForward(tform, boxPolygon);
    
    
   
figure;
imshow(b);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
title('Detected Box');











