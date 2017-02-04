%Load sequence of images
sequence = load_sequence('footage', 'footage_', 1, 657, 3, 'png');

%Create and open output video
video = VideoWriter('output1.avi');
open(video);

%init
previousFrame = sequence(:,:,1);
difference = 0;
onFrame = 0;

for frame = 1:657
    thisFrame = sequence(:,:,frame);
    
    difference = sum(sum(abs(thisFrame - previousFrame)));
    
    if(difference>3000000)
        %Text is written on the image
        onFrame = 10;
    end
    if(onFrame > 0)
        imWrite = insertText(thisFrame,[0 0],['Scene Change ']);
    else
        imWrite = thisFrame;     
    end
    
    writeVideo(video,imWrite);
    
    previousFrame = thisFrame;
    
    if (onFrame > 0)
        onFrame = onFrame - 1;
    end
end

%Save video
close(video);