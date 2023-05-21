fig = figure;
fig.Position = [1 100 900 500];
fig.Name = "Histogram Equalization";

F=imread('kedy.jpg');
F=rgb2gray(F);

subplot(2,3,1)
imshow(F);
title('Original Image');

subplot(2,3,2)
A = histogramequalization(F);
imshow(A);
title('Manually Equalized');

subplot(2,3,3)
B = histeq(F);
imshow(B);
title('Equalized with histeq method');

subplot(2,3,4)
imhist(F,64)
title('Original Image Histogram');

subplot(2,3,5)
imhist(A,64)
title('Manually Equalized Histogram');

subplot(2,3,6)
imhist(B,64)
title('Equalized with histeq method Histogram');



fig2 = figure;
fig2.Position = [1001 100 900 500];
fig2.Name = "Averaging Filter";


I = imread("kedy.jpg");
I=rgb2gray(I);


subplot(1,3,1)
imshow(I);
title('Original Image');

subplot(1,3,2)
C = avgFilter(I);
imshow(C);
title('Manually 9x9 Averaging Filter');

subplot(1,3,3)
D = conv2(single(I), ones(9)/81, 'same');
imshow(D, []);
title('Blurred with built-in function');




function A = histogramequalization(F)

cnt=zeros(256,1);
pr=zeros(256,1);
[r,c]=size(F);

for ii=1:r
    for jj=1:c
         pos=F(ii,jj);
         cnt(pos+1,1)=cnt(pos+1)+1; %for histogram
         pr(pos+1,1)=cnt(pos+1,1)/(r*c); %for probability
    end
end

cnts=zeros(256,1);
sk=zeros(256,1);
sum=0;
for i=1:size(pr)
    sum=sum+cnt(i);
        s=sum/(r*c);
        sk(i,1)=round(s*255);
    
end

for k=1:256
    m=sk(k,1);
   cnts(m+1,1)=cnts(m+1,1)+cnt(k,1);
end
hnew=uint8(zeros(r,c));
for i=1:r
    for j=1:c
        hnew(i,j)=sk(F(i,j)+1,1);
    end
end
A = hnew;
end


function C = avgFilter(I)
%Define average filter size with n
n = 9; 
h = ones(n) / (n^2); 


p = floor(n/2);
img_padded = padarray(I, [p p], 0);
img_filtered = zeros(size(I));

for i = 1:size(I, 1)
    for j = 1:size(I, 2)
        neighborhood = img_padded(i:i+n-1, j:j+n-1);
        neighborhood = double(neighborhood);
        filtered_pixel = sum(sum(h .* neighborhood));
        img_filtered(i, j, :) = filtered_pixel;
    end
end

C = uint8(img_filtered);
end


