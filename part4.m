function [ sequence_out ] = part4( sequence )

length = size(sequence,3);

sequence_out = sequence;

[sizeX, sizeY] = size(sequence(:,:,1));

for frame = 600:length
    thisFrame = im2double(sequence(:,:,frame));
    
    for x = 1:sizeX
        
       sequence_out(x,:,frame) = im2uint8(medfilt1(thisFrame(x,:),6));
        
    end
       
end

end
