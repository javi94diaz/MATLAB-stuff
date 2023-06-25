% siendo frame2 la imagen original

figure(1)
I=rgb2lab(frame2);
imshow(I)

figure(2)
I=rgb2xyz(frame2);
imshow(I)

figure(3)
I=rgb2ycbcr(frame2);
imshow(I)

figure(4)
I=rgb2ntsc(frame2);
imshow(I)