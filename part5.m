function [ sequence_out ] = part5( sequence )

%sequence_out = sequence;

[sizeX, sizeY] = size(sequence(:,:,1));

length = size(sequence,3);

%init
previousFrame = sequence(:,:,1);
difference = 0;
onFrame = 0;
ratio = 1/4;
newTrack = 0;

%Initial tracking area
trackPoints = sequence(1:ceil(sizeX * ratio),:,1);


for frame = 1:length
    
    thisFrame = sequence(:,:,frame);
    
    %Absoulte pixel difference
    difference = sum(sum(abs(thisFrame - previousFrame)));
    
    if(newTrack==1)
        trackPoints = thisFrame(1:ceil(sizeX * ratio),:);
        newTrack = 0;
    else
        newTrack = newTrack - 1;
    end
    
    %If new scene
    if(difference>3000000)
        newTrack = 5;
    end
    
    currentPoints = thisFrame(1:ceil(sizeX * ratio),:);
    
    translation = comparePatch(trackPoints, currentPoints);
    outImg = circshift(thisFrame, -translation(1), 1);
    outImg = circshift(outImg, -translation(2), 2);

    %outImg = imtranslate(thisFrame,-translation);
    
    sequence_out(:,:,frame) = outImg;
    
    previousFrame = thisFrame;
    
end

end

