%Load sequence of images
sequence = load_sequence('footage', 'footage_', 1, 657, 3, 'png');

vidFrames = final(sequence);

%Create and open output video
video = VideoWriter('output.avi');
open(video);

for frame = 1 : 657

    writeVideo(video,[sequence(:,:,frame),vidFrames(:,:,frame)]);
    
end

close(video)