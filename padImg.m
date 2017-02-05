function [ imgOut ] = padImg( imgIn )
    imgIn = padarray(imgIn,1,0,'both');
    imgIn = padarray(imgIn',1,0,'both');
    imgOut = imgIn';
end

