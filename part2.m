function [ sequence_out ] = part2( sequence )

length = size(sequence,3);

sequence_out = sequence;

averageNum = 10;

averageFrame = (sum(sequence(:,:,1:averageNum),3)/averageNum)/255;
previousFrame = sequence(:,:,1);

for frame = 1:length
    thisFrame = sequence(:,:,frame);
    
    difference = sum(sum(abs(thisFrame - previousFrame)));
    
    if(difference>3000000)
        %Scene change
        averageFrame = (sum(sequence(:,:,frame:frame+averageNum),3)/averageNum)/255;
        
    end
    
    sequence_out(:,:,frame) = imhistmatch(thisFrame,averageFrame);

    previousFrame = thisFrame;

end

end
