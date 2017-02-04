%Load sequence of images
sequence = load_sequence('footage', 'footage_', 1, 657, 3, 'png');

[sizeX, sizeY] = size(sequence(:,:,1));

%Create and open output video
video = VideoWriter('output3.avi');
open(video);

p = zeros(1,6);
dFrame = zeros(sizeX,sizeY);
modFrame = zeros(sizeX,sizeY);

for frame = 1+1:50-1
    %Get frames
    thisFrame = im2double(sequence(:,:,frame));
    prevFrame = im2double(sequence(:,:,frame-1));
    nextFrame = im2double(sequence(:,:,frame+1));
    
    %Pad frames
    thisFramePad = padImg(thisFrame);
    prevFramePad = padImg(prevFrame);
    nextFramePad = padImg(nextFrame);
    
    for x = 1+1:sizeX
        for y= 1+1:sizeY

            p = [prevFramePad(x+1,y), prevFramePad(x,y), prevFramePad(x-1,y),...
                 nextFramePad(x+1,y), nextFramePad(x,y), nextFramePad(x-1,y)];  
               
            if(min(p) - thisFramePad(x,y)>0)
            d = min(p) - thisFramePad(x,y); 
            elseif(thisFramePad(x,y) - max(p)>0)
            d = thisFramePad(x,y) - max(p);
            else
            d = 0;
            end
            if(d>0.10)
            d = 1;
            end
            dFrame(x-1,y-1) = d;
        end
    end
    
    for x = 1+1:sizeX
        for y= 1+1:sizeY
            if(dFrame(x,y))
                ��
            else
                modFrame(x,y) = thisFrame(x,y);
            end
       end
    end
    imWrite = [thisFrame, dFrame,modFrame ];     

    writeVideo(video,imWrite);
    
    previousFrame = thisFrame;

end

%Save video
close(video);