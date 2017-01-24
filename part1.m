%Load sequence of images
sequence = load_sequence('footage', 'footage_', 1, 657, 3, 'png');

%Create and open output video
video = VideoWriter('outputFile.avi');
open(video);

%init
previousFrame = sequence(:,:,1);
difference = 0;

for frame = 1:657
    thisFrame = sequence(:,:,frame);
    
    difference = sum(sum(abs(thisFrame - previousFrame)));
    
    if(difference>3000000)
        %Text is written on the image
        imWrite = insertText(thisFrame,[0 0],['Scene Change ' num2str(difference)]); 
    else
        imWrite = thisFrame;     
    end
    
    writeVideo(video,imWrite);
    
    previousFrame = thisFrame;
    
    difference = 0;
end

%Save video
close(video);