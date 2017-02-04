function [ imgOut ] = padImg( imgIn )
    imgIn = padarray(imgIn,1,'symmetric','both');
    imgIn = padarray(imgIn',1,'symmetric','both');
    imgOut = imgIn';
end

