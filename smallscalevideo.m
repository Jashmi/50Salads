clear
clc

InputDire = '/home/jashmi/50salad-training-data/add_dressing_core/';
VideoName = 's262_52';
InputVideo = strcat(InputDire,VideoName,'.avi');
DireName = strcat('/home/jashmi/Documents/Fall2015/CSE509/Project/TestData/Add_dressing_core/smallscale',VideoName,'/');

video = VideoReader(InputVideo);
count = 1;
mkdir(DireName);
while hasFrame(video)
    frame = readFrame(video);
    frame = imresize(frame,0.1);
    filename = sprintf('frame%d.jpg', count);
    OutputName = strcat(DireName,filename);
    imwrite(frame,OutputName);
    count = count + 1;
end
