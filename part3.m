function [ sequence_out ] = part3( sequence )

sequence_out = sequence;

length = size(sequence,3);

[sizeX, sizeY] = size(sequence(:,:,1));

p = zeros(1,6);
dFrame = zeros(sizeX,sizeY);
modFrame = zeros(sizeX,sizeY);

for frame = 1+1:length-1
    %Get frames and average them over previous and next frame
    thisFrame = im2double(sequence(:,:,frame));
    prevFrame = im2double(sequence(:,:,frame-1));
    nextFrame = im2double(sequence(:,:,frame+1));
        
    %calculate average of 6 neighbor frames
    avgFrame = imgaussfilt((sum(im2double(sequence(:,:,frame-1:frame+1)),3)-thisFrame)/2);
    
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
            if(d>0.05)
            d = 1;
            end
            dFrame(x-1,y-1) = d;
        end
    end
    
    
    %If blotch, fill in with average of 3 previous and next frame after
    %gaussian blur
    for x = 1+1:sizeX
        for y= 1+1:sizeY
            if(dFrame(x,y))
                modFrame(x,y) = avgFrame(x,y);
            else
                modFrame(x,y) =  thisFrame(x,y); 
            end            
        end
    end
        
    sequence_out(:,:,frame) = im2uint8(imgaussfilt(modFrame));     
    
    previousFrame = thisFrame;

end

end
