%Load sequence of images
sequence = load_sequence('footage', 'footage_', 1, 657, 3, 'png');

%Create and open output video
video = VideoWriter('output2.avi');
open(video);


averageNum = 10;

averageFrame = (sum(sequence(:,:,1:averageNum),3)/averageNum)/255;


for frame = 1:657
    
    if(frame>averageNum)
        averageFrame = (sum(sequence(:,:,frame-averageNum:frame),3)/averageNum)/255;
    end
    
    thisFrame = im2double(sequence(:,:,frame));
    
    imWrite = imhistmatch(thisFrame,averageFrame);
    
    writeVideo(video,imWrite);
        
end

%Save video
close(video);
