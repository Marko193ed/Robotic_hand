% Get hardware information
info = imaqhwinfo;

% Display installed adaptors
disp('Installed Adaptors:');
disp(info.InstalledAdaptors);

% Get information on a specific adaptor
cameraInfo = imaqhwinfo('winvideo'); % Replace 'winvideo' with your camera adaptor if different
disp('Camera Info:');
disp(cameraInfo);

% Create a video input object
vid = videoinput('winvideo', 1); % Adjust 'winvideo' and 1 based on your setup

% Get the selected source object
src = getselectedsource(vid);

% Display all properties of the source object
disp('Camera Properties:');
disp(get(src));

% Display specific properties
disp('Brightness:');
disp(src.Brightness);
disp('Contrast:');
disp(src.Contrast);
disp('Exposure:');
disp(src.Exposure);
