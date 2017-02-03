clear all;
clc;
%Brihi Joshi
%Roll number- 2016142

%General program for Median Filtering 

%Reading and adding impulse noise to the image. '0.05' is the proportion
%of affected pixels. We only need to change these values and/or the image
%we use!
I=im2double(imread('baboon256.tif'));
J=imnoise(I,'salt & pepper',0.05);

%Defining the kernel dimension. It holds values 3,5,7
mask=3;

%Creating a new padded 2D matrix with . 
paddedi2=zeros(size(I)+2*fix(mask/2));

%Adding the values of the noisy image into the padded array
for a=1:size(I,1)
    for b=1:size(I,2)
        paddedi2(a+fix(mask/2),b+fix(mask/2))=J(a,b);
    end
end
%Creating the 2D Array which will be the final denoised image
fili=im2double(zeros(size(I)));

%Applying median filtering
for a=1:size(I,1)
    for b=1:size(I,2)
        
        %Creating the window array
        win=zeros(mask*mask,1);
        i=1;
        
        %Adding elements to the window
        for c=1:mask
            for d=1:mask
                win(i)=paddedi2(a+c-1,b+d-1);
                i=i+1;
            end
        end
        
        %Finding the median of the window by sorting the 1D array
        med=sort(win);
        fili(a,b)=med(fix((mask*mask)/2)+1);
    end
end

%Displaying the Original,noised and denoised images and corresponding 
%psnr values.
figure, imshow(I);
figure, imshow(J);
figure, imshow(fili);
PSNR(I,fili)