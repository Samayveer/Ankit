% Proposed predictor for classification
% clc;
% clear all;
% close all;
gray_image=double(imread('D:\Test_Images\Lena.bmp'));   %Test image path
output_image=gray_image;
 Thr=10;   %New predeictor threshold for rhombus
 Thr1= 10;   % New preeictor threshold for applying D&C and our valriation
 LC_Thr=25;     % Local complexity threshold
 LC_Thr1=40; 
 LC_Thr2=50; 
E_start=1;
block_size=13;
Capacity=0;
limit=50000;
%%%preprocessing the imge to avoid overflow/underflow
for i=2:1:511
    for j=2:1:511
        if (output_image(i,j)==0)
            output_image(i,j)=output_image(i,j)+1;
        elseif (output_image(i,j)==255)
            output_image(i,j)=output_image(i,j)-1;
        end
    end
end

%x-set pixel's embedding
k=0;
for i=2:1:511
    if (mod(i,2)==0)
        j=2;
    else
        j=3;
    end
    while j<512
     k=k+1;
    [output_image1(k), Pmean(k), Rhombus_Avg(k), L_mean(k), H_mean(k), L_complexity(k)]=C_predictor(output_image(i,j),output_image(i,j-1),output_image(i-1,j),output_image(i,j+1),output_image(i+1,j), Thr, Thr1);   % computing mean using the proposed method, rhombus mean, local complexity etc

     j=j+2;   
    end
end

 [sorted_PMean index_value]=sort(Pmean);

 intensity_val=0;
 m=0;
 for i=1:1:k
   if Capacity < limit    
   if sorted_PMean(i)==intensity_val
   
       if L_complexity(index_value(i))<= LC_Thr      
            m=m+1;
           IPVO_block(m)=output_image1(index_value(i));
           IPVO_Location(m)=index_value(i);
       else
           [output_image1(index_value(i)), cap1]=Skewed_Sachnev(output_image1(index_value(i)), Pmean(index_value(i)), L_mean(index_value(i)), H_mean(index_value(i)), L_complexity(index_value(i)), LC_Thr1, LC_Thr2);  % Skewed_Sachnev function is applying both Kim etl and Sachne's method based on the complexity ..these are defined in one function only i.e.., Skewed_Sachnev
                 Capacity= Capacity+cap1;
       end 

   else

       if m>2
%          [IPVO_block, cap1]=IPVO_b_embed(IPVO_block, m);
%           Capacity= Capacity+cap1;
       if m>block_size
        m1=1;   
        while (m1+block_size-1)<=m
           

%            [IPVO_block(m1:m1+block_size-1), cap1, IPVO_error1]=IPVO_b_embed(IPVO_block(m1:m1+block_size-1), block_size);
%            IPVO_error(E_start:E_start+block_size-2)=IPVO_error1;
%            E_start=E_start+block_size;

           [IPVO_block(m1:m1+block_size-1), cap1, IPVO_error1, IPVO_error2]=MPass(IPVO_block(m1:m1+block_size-1), block_size);  %embedding using MPASS
           MPass_error1(E_start:E_start+block_size-2)=IPVO_error1;
           MPass_error2(E_start:E_start+block_size-2)=IPVO_error2;
           E_start=E_start+block_size;
           Capacity= Capacity+cap1;
           m1=m1+block_size;
           
        end
      end

   
       for j=1:1:m
       output_image1(IPVO_Location(j))=IPVO_block(j);
       end
       else
       for j=1:1:m
       [output_image1(IPVO_Location(j)), cap1]=Skewed_Sachnev(output_image1(IPVO_Location(j)), Pmean(IPVO_Location(j)), L_mean(IPVO_Location(j)), H_mean(IPVO_Location(j)), L_complexity(j), LC_Thr1, LC_Thr2);
       Capacity= Capacity+cap1;
       end
       end
       
       m=0;
       IPVO_block=[];
       IPVO_Location=[];
       intensity_val=intensity_val+1;
 
       
   end 
   
   end   
 end
output_image12=output_image1;
 k=1;
for i=2:1:511
    if (mod(i,2)==0)
        j=2;
    else
        j=3;
    end
    while j<512
   output_image(i,j)=output_image1(k);
   k=k+1;
     j=j+2;   
    end
end

% %Y-set pixel embedding
k=0;
for i=2:1:511
    if (mod(i,2)==0)
        j=3;
    else
        j=2;
    end
    while j<512
     k=k+1;
    [output_image1(k), Pmean(k), Rhombus_Avg(k), L_mean(k), H_mean(k), L_complexity(k)]=C_predictor(output_image(i,j),output_image(i,j-1),output_image(i-1,j),output_image(i,j+1),output_image(i+1,j), Thr, Thr1);   %i,j

     j=j+2;   
    end
end



 [sorted_PMean index_value]=sort(Pmean);

 intensity_val=0;
 m=0;
 for i=1:1:k
   if Capacity < limit    
   if sorted_PMean(i)==intensity_val
   
       if L_complexity(index_value(i))<= LC_Thr
            m=m+1;
           IPVO_block(m)=output_image1(index_value(i));
           IPVO_Location(m)=index_value(i);
       else
           [output_image1(index_value(i)), cap1]=Skewed_Sachnev(output_image1(index_value(i)), Pmean(index_value(i)), L_mean(index_value(i)), H_mean(index_value(i)), L_complexity(index_value(i)), LC_Thr1, LC_Thr2);
                 Capacity= Capacity+cap1;
       end 

   else

       if m>2
%          [IPVO_block, cap1]=IPVO_b_embed(IPVO_block, m);
%           Capacity= Capacity+cap1;
       if m>block_size
        m1=1;   
        while (m1+block_size-1)<=m
           

%            [IPVO_block(m1:m1+block_size-1), cap1, IPVO_error1]=IPVO_b_embed(IPVO_block(m1:m1+block_size-1), block_size);
%            IPVO_error(E_start:E_start+block_size-2)=IPVO_error1;
%            E_start=E_start+block_size;
           [IPVO_block(m1:m1+block_size-1), cap1, IPVO_error1, IPVO_error2]=MPass(IPVO_block(m1:m1+block_size-1), block_size);
           Capacity= Capacity+cap1;
           MPass_error1(E_start:E_start+block_size-2)=IPVO_error1;
           MPass_error2(E_start:E_start+block_size-2)=IPVO_error2;
           E_start=E_start+block_size;
           
           
           m1=m1+block_size;
           
        end
      end

   
       for j=1:1:m
       output_image1(IPVO_Location(j))=IPVO_block(j);
       end
       else
       for j=1:1:m
       [output_image1(IPVO_Location(j)), cap1]=Skewed_Sachnev(output_image1(IPVO_Location(j)), Pmean(IPVO_Location(j)), L_mean(IPVO_Location(j)), H_mean(IPVO_Location(j)), L_complexity(j), LC_Thr1, LC_Thr2);
       Capacity= Capacity+cap1;
       end
       end
       
       m=0;
       IPVO_block=[];
       IPVO_Location=[];
       intensity_val=intensity_val+1;
 
       
   end 
   
   end   
 end
 k=1;
for i=2:1:511
    if (mod(i,2)==0)
        j=3;
    else
        j=2;
    end
    while j<512
   output_image(i,j)=output_image1(k);
   k=k+1;
     j=j+2;   
    end
end


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
            
            Capacity   
            
%             
% [hh,tt]=hist(MPass_error1,[-15:1:15]);
% figure;
% M=bar(tt,hh);
% 
% [hh,tt]=hist(MPass_error2,[-15:1:15]);
% figure;
% M=bar(tt,hh);
