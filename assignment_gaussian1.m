clear all;
clc;
%Brihi Joshi
%Roll number- 2016142

%General program for Mean Filtering

%Reading and adding gaussian noise to the image. square root(0.05) is the
% sigma. We only need to change these values and/or the image
%we use!
im=im2double(imread('lena256.tif'));
j=imnoise(im,'gaussian',0,0.05);

%Defining the kernel dimension. It holds values 3,5,7
mask=3;

%Creating a new padded 2D matrix with .
paddedi=zeros(size(im)+2*fix(mask/2));

%Adding the values of the noisy image into the padded array
for a=1:size(im,1)
    for b=1:size(im,2)
        paddedi(a+fix(mask/2),b+fix(mask/2))=j(a,b);
    end
end

%The kernel which will be used for calculating the weighted mean. It needs
%to be redefined for each case.
kernel=[0.000161 0.012353 0.000161 0.012353 0.949948 0.012353 0.000161 0.012353 0.000161];
total=sum(kernel);

%Creating the 2D Array which will be the final denoised image
finali=im2double(zeros(size(im)));

%Applying mean filtering
for a=1:size(im,1)
    for b=1:size(im,1)
        
        %Creating the window array
        win=zeros(1,mask*mask);
        i=1;
        
        %Adding elements to the window
        for c=1:mask
            for d=1:mask
                win(i)=paddedi(a+c-1,b+d-1);
                i=i+1;
            end
        end
        
        %Calculating the weighted mean of the window
        temp=win.*kernel;
        s=sum(temp);
        finali(a,b)=s/total;
    end
end

%Displaying the Original,noised and denoised images and corresponding 
%psnr values.
figure, imshow(im);
figure, imshow(j);
figure, imshow(finali);
PSNR(im,finali)