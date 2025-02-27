
%img = repmat(img, [1 1 3]);

CV(img,cameraParams);

%check data for results
load("data.mat", "masks");

for i=1:length(masks)
    figure();
    imshow(masks(i).Mask);
    title(masks(i).Label);
end