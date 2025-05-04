% Proposed predictor for classification
clc;
clear all;
close all;
gray_image=double(imread('D:\Test_Images\Lena.bmp'));
output_image=gray_image;
for i=1:1:512
    for j=1:1:128
        
        a1=0; x1=1;
          b=round(a1+(x1-a1)*rand(1));
        output_image(i,j)= output_image(i,j)+b;
            
end
end

%  Thr=10;   %New predeictor threshold for rhombus
%  Thr1= 10;   % New preeictor threshold for applying D&C and our valriation
%  LC_Thr=20;     % Local complexity threshold
%  LC_Thr1=40; 
%  LC_Thr2=50; 
% 
% Capacity=0;
% limit=40000;
%  pv1=0;
% for i=2:1:511
%     for j=2:1:511
%         if (output_image(i,j)==0)
%             output_image(i,j)=output_image(i,j)+1;
%         elseif (output_image(i,j)==255)
%             output_image(i,j)=output_image(i,j)-1;
%         end
%     end
% end
% % for i=1:1:1
%     for j=1:5:4
%         
%         IPVO_block = [output_image(i,j), output_image(i,j+1) output_image(i,j+2) output_image(i,j+3) output_image(i,j+4)]
%         [IPVO_block, cap1]=IPVO_b_embed(IPVO_block, 5);
%         output_image(i,j)=IPVO_block(1);
%         output_image(i,j+1)=IPVO_block(2);
%         output_image(i,j+2)=IPVO_block(3);
%         output_image(i,j+3)=IPVO_block(4);
%         output_image(i,j+4)=IPVO_block(5);
%          Capacity= Capacity+cap1;
%         IPVO_block
% 
%     end
% end
% 
origImg = double(gray_image);
            stegoImg = double(output_image);

            [M N] = size(origImg);
            error = origImg - stegoImg;
            MSE = sum(sum(error .* error)) / (M * N);

            if(MSE > 0)
            LM_Comp_skew_Predictor3_PSNR = 10*log(255*255/MSE) / log(10)
            else
            PSNR = 99
            end 
            
%             Capacity   
