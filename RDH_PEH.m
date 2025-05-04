% clc;
clear all;
close all;
gray_image=double(rgb2gray(imread('E:\D Drive\Test_Images\Color\bush.png')));
%gray_image=double(rgb2gray(input_image));
output_image=gray_image;
stego_image=gray_image;
k=1;
cap1=0;
T1=0;
T2=-1;

% D&C
% Thr=10;
% Thr=30;
%  Thr=12;
%  Thr=5; %Boat
Thr=10;  %Bush

% CRP
% Lena
% Thr=10;    
%  Thr1=10;
 
 % Baboon
%  Thr=23;
%  Thr1=0;
 
 % Airplane
%  Thr=18;
%  Thr1=50; 

 % Boat
%  Thr=6;
%  Thr1=21;

% Bush
% Thr=9;  
% Thr1=11; 
for i=2:1:511
    if (mod(i,2)==0)
        j=2;
    else
        j=3;
    end
    while j<512
       
      P_value=Rhombus_predict(stego_image(i,j-1),stego_image(i-1,j),stego_image(i,j+1),stego_image(i+1,j));   %rhombus predictor 
%       P_value=DC_predict(stego_image(i,j-1),stego_image(i-1,j),stego_image(i,j+1),stego_image(i+1,j), Thr);   %D&C predictor 
%       P_value=CRP(stego_image(i,j-1),stego_image(i-1,j),stego_image(i,j+1),stego_image(i+1,j), Thr, Thr1);   %CRP predictor 

         P_error=gray_image(i,j)-P_value; 
          if P_error==T1
            a1=0; x1=1;
              b=round(a1+(x1-a1)*rand(1));
             stego_image(i,j)=stego_image(i,j)+b;
             cap1=cap1+1;
             
      elseif P_error==T2
            a1=0; x1=1;
              b=round(a1+(x1-a1)*rand(1));
             stego_image(i,j)=stego_image(i,j)-b;
             cap1=cap1+1;
             
         elseif P_error<T2
           stego_image(i,j)=stego_image(i,j)-1;
             
      else
           stego_image(i,j)=stego_image(i,j)+1;  
           
          end
          output_image(i,j)=P_value;
        
        Error(k)=gray_image(i,j)-P_value;
        k=k+1;
      
      j=j+2;   
    end
end


for i=2:1:511
    if (mod(i,2)==0)
        j=3;
    else
        j=2;
    end
    while j<512
       
      P_value=Rhombus_predict(stego_image(i,j-1),stego_image(i-1,j),stego_image(i,j+1),stego_image(i+1,j));   %rhombus predictor 
%       P_value=DC_predict(stego_image(i,j-1),stego_image(i-1,j),stego_image(i,j+1),stego_image(i+1,j), Thr);   %D&C predictor 
%       P_value=CRP(stego_image(i,j-1),stego_image(i-1,j),stego_image(i,j+1),stego_image(i+1,j), Thr, Thr1);   %CRP predictor 

          P_error=gray_image(i,j)-P_value; 
          if P_error==T1
            a1=0; x1=1;
              b=round(a1+(x1-a1)*rand(1));
             stego_image(i,j)=stego_image(i,j)+b;
             cap1=cap1+1;
             
      elseif P_error==T2
            a1=0; x1=1;
              b=round(a1+(x1-a1)*rand(1));
             stego_image(i,j)=stego_image(i,j)-b;
             cap1=cap1+1;
             
         elseif P_error<T2
           stego_image(i,j)=stego_image(i,j)-1;
             
      else
           stego_image(i,j)=stego_image(i,j)+1;  
           
          end
    output_image(i,j)=P_value;
    Error(k)=gray_image(i,j)-P_value;
        k=k+1;
      j=j+2;   
    end
end


          origImg = double(gray_image);
            stegoImg = double(stego_image);

            [M N] = size(origImg);
            error = origImg - stegoImg;
            MSE = sum(sum(error .* error)) / (M * N);

            if(MSE > 0)
            Rhombus_PSNR = 10*log(255*255/MSE) / log(10)
            else
            Rhombus_PSNR = 99
            end 
            
%             Capacity=cap1+cap2
%entropy(stegoImg/255)

[hh,tt]=hist(Error,[-6:1:6]);
figure;
M=bar(tt,hh); 

hh
        