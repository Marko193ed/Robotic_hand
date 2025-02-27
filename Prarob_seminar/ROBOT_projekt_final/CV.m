function CV(img,cameraParams);
img = undistortImage(img, cameraParams);
%this function takes an image and executes detection algorithm using YOLO
%model, results are stored in data.mat

%step used in fitting bounding box
step = 2;

%img = imread("vehicles2.png");
%img = repmat(img, [1 1 3]);
%load the model
load("dark_yolo.mat");

sz = size(img);
width = sz(2);
height = sz(1);

hsvImg = rgb2hsv(img);

% Extract the white(paper)
saturationChannel = hsvImg(:, :, 2);
valueChannel = hsvImg(:, :, 3);
saturationThreshold = 0.1; % Adjust as needed
valueThreshold = 0.9; % Adjust as needed

mask = (saturationChannel > saturationThreshold) | (valueChannel < valueThreshold);
mask = uint8(mask)*255;

[bboxes, scores, labels] = detect(dark_yolo, img);
%detectedImg = insertObjectAnnotation(img, "Rectangle", bboxes, labels);figure;imshow(detectedImg)

N = length(labels);

s = struct("Label", "object", "Mask", mask);
masks = repmat(s, N, 1);

for i = 1:N
    x = floor(bboxes(i, 1));
    y = floor(bboxes(i, 2));
    d= ceil(bboxes(i, 3));
    h = ceil(bboxes(i, 4));
    segMask = zeros(height, width);
    segMask(y:y+h, x:x+d) = mask(y:y+h, x:x+d);
    s1 = struct("Label", string(labels(i)), "Mask", segMask);
    masks(i) = s1;
end 
    %if you want to check masks uncomment
    %figure()
    %imshow(segMask)

%{
for i=1:N
    x0 = floor(bboxes(i, 1));
    y0 = floor(bboxes(i, 2));
    d0 = ceil(bboxes(i, 3));
    h0 = ceil(bboxes(i, 4));
    x = x0;
    y = y0;
    d = d0;
    h = h0;
    while true
        if (x < 1 || ((x + d) > width) || y < 1 || ((y + h) > height))
            error(msg);
        elseif sum(mask(y-step:y+h+2*step, x-step:x+d+2*step), "all") - sum(mask(y:y+h, x:x+d), "all") == 0
            bboxes(i, :) = [x, y, d, h];
            break;
        else 
            x = x - step;
            y = y - step;
            d = d + 2*step;
            h = h + 2*step;
        end
    end
    segMask = zeros(height, width);
    segMask(y:y+h, x:x+d) = mask(y:y+h, x:x+d);
    s1 = struct("Label", string(labels(i)), "Mask", segMask);
    masks(i) = s1;
    
    %if you want to check masks uncomment
    %figure()
    %imshow(segMask)
end
%}
save("data.mat", "img", "masks", "labels")
evalin('base', 'load(''data.mat'')');   