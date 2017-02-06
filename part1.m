function [ sequence_out ] = part1( sequence )

sequence_out = sequence;
length = size(sequence,3);

%init
previousFrame = sequence(:,:,1);
difference = 0;
onFrame = 0;

for frame = 1:length
    thisFrame = sequence(:,:,frame);
    
    %Absoulte pixel difference
    difference = sum(sum(abs(thisFrame - previousFrame)));
    
    %If difference above threshold
    if(difference>3000000)
        %Text is written on the image for 10 frames
        onFrame = 10;
    end
    
    if(onFrame > 0)
         sequence_out(:,:,frame) = rgb2gray(insertText(thisFrame,[0 0],['Scene Change']));
    else
         sequence_out(:,:,frame) = thisFrame;     
    end
        
    previousFrame = thisFrame;
    
    %Text is written on the image for 10 frames only
    if (onFrame > 0)
        onFrame = onFrame - 1;
    end
    
end

end