function [ offset ] = comparePatch( patchA, patchB )

    [sizeX, sizeY] = size(patchA);
    
    centerRegion = patchA(5+1:sizeX-5,5+1:sizeY-5);
    
    SSD = zeros(10*10,1);
    
    transform = zeros(10*10,2);
    
    counter = 1;
    
    for x = -5:5
        for y = -5:5
            
            currentRegion = patchB(5+1+x:sizeX-5+x,5+1+y:sizeY-5+y);
            
            SSD(counter) = sum(sum((currentRegion - centerRegion).^2));
            
            transform(counter,:) = [x , y];
            
            counter = counter +1;
            
        end
    end
    
    [A location] = min(SSD);
    
    offset = transform(location,:);
    
end

