% Proposed predictor for classification
% clc;
% clear all;
% close all;
gray_image=double(imread('D:\Test_Images\Lena.bmp'));
output_image=gray_image;
 Capacity=0;
 C_thr1=50;
 C_thr2=150;  
 Thr=10; 
 Thr1= 10;
 p1=0;
 p2=1;
 limit=20000;
 pv1=0;
for i=3:1:510
    for j=3:1:510
        if (output_image(i,j)==0)
            output_image(i,j)=output_image(i,j)+1;
        elseif (output_image(i,j)==255)
            output_image(i,j)=output_image(i,j)-1;
        end
    end
end

for i=3:4:509
for j=3:4:509

if Capacity < limit    
    
  %X-set Embedding  
    
    %%Flushing the arrays
    G1=1;
    G2=1;
    F=[];
    S=[];
    F1=[];
    S1=[];
    
   pix=[output_image(i,j) output_image(i,j+2) output_image(i+1,j+1) output_image(i+1,j+3) output_image(i+2,j) output_image(i+2,j+2) output_image(i+3,j+1) output_image(i+3,j+3)];
    m(1)=(output_image(i,j-1)+output_image(i-1,j)+output_image(i,j+1)+output_image(i+1,j))/4;   %i,j
    m(1)=new_predictor(output_image(i,j-1), output_image(i-1,j), output_image(i,j+1), output_image(i+1,j), Thr, Thr1);
    m(2)=(output_image(i,j+1)+output_image(i-1,j+2)+output_image(i,j+3)+output_image(i+1,j+2))/4;   %i,j+2
    m(2)=new_predictor(output_image(i,j+1),output_image(i-1,j+2),output_image(i,j+3),output_image(i+1,j+2), Thr, Thr1);
    m(3)=(output_image(i+1,j)+output_image(i,j+1)+output_image(i+1,j+2)+output_image(i+2,j+1))/4 ;   %i+1,j+1
    m(3)=new_predictor(output_image(i+1,j),output_image(i,j+1),output_image(i+1,j+2),output_image(i+2,j+1), Thr, Thr1);
    m(4)=(output_image(i+1,j+2)+output_image(i,j+3)+output_image(i+1,j+4)+output_image(i+2,j+3))/4 ;   %i+1,j+3
    m(4)=new_predictor(output_image(i+1,j+2),output_image(i,j+3),output_image(i+1,j+4),output_image(i+2,j+3), Thr, Thr1);
    m(5)=(output_image(i+2,j-1)+output_image(i+1,j)+output_image(i+2,j+1)+output_image(i+3,j))/4 ; %i+2,j
    m(5)=new_predictor(output_image(i+2,j-1),output_image(i+1,j),output_image(i+2,j+1),output_image(i+3,j), Thr, Thr1);
    m(6)=(output_image(i+2,j+1)+output_image(i+1,j+2)+output_image(i+2,j+3)+output_image(i+3,j+2))/4;   %i+2,j+2
    m(6)=new_predictor(output_image(i+2,j+1),output_image(i+1,j+2),output_image(i+2,j+3),output_image(i+3,j+2), Thr, Thr1);
    m(7)=(output_image(i+3,j)+output_image(i+2,j+1)+output_image(i+3,j+2)+output_image(i+4,j+1))/4  ; %i+3,j+1
    m(7)=new_predictor(output_image(i+3,j),output_image(i+2,j+1),output_image(i+3,j+2),output_image(i+4,j+1), Thr, Thr1);
    m(8)=(output_image(i+3,j+2)+output_image(i+2,j+3)+output_image(i+3,j+4)+output_image(i+4,j+3))/4  ; %i+3,j+3
    m(8)=new_predictor(output_image(i+3,j+2),output_image(i+2,j+3),output_image(i+3,j+4),output_image(i+4,j+3), Thr, Thr1);
    M=(m(1)+m(2)+m(3)+m(4)+m(5)+m(6)+m(7)+m(8))/8;
    
    x_rev_pix=[i i i+1 i+1 i+2 i+2 i+3 i+3];
    y_rev_pix=[j j+2 j+1 j+3 j j+2 j+1 j+3];
    
    %Grouping of pxels
   for k=1:1:8
       if (m(k)<M)
           F(G1)=pix(k);
           F1(G1)=k;
           G1=G1+1;
       else
           S(G2)=pix(k);
           S1(G2)=k;
           G2=G2+1;
       end
   end
   
   % Embedding based on cardinality of each group
    [rowF cardF]=size(F);
    
    
    if cardF>2
       [F, cap1, e1, e2] = MPass(F, cardF); 
       Capacity= Capacity+cap1;
       for l=1:1:cardF
       output_image(x_rev_pix(F1(l)),y_rev_pix(F1(l)))=F(l);
       end
          [rsize, csize]=size(e1);
         for pv=1:1:csize
          pvo1(pv1+pv)=e1(pv); 
          pvo2(pv1+pv)=e2(pv); 
        end
        pv1=pv1+csize;
       
       
    else
        for l=1:1:cardF

      [output_image(x_rev_pix(F1(l)),y_rev_pix(F1(l))), cap1, d1, d2, P_error]=pixel_embed(output_image(x_rev_pix(F1(l)),y_rev_pix(F1(l))), output_image(x_rev_pix(F1(l)),y_rev_pix(F1(l))-1), output_image(x_rev_pix(F1(l))-1,y_rev_pix(F1(l))), output_image(x_rev_pix(F1(l)),y_rev_pix(F1(l))+1), output_image(x_rev_pix(F1(l))+1,y_rev_pix(F1(l))), C_thr1, C_thr2, Thr, Thr1, p1, p2);  
      Capacity= Capacity+cap1;
        end
    end
    
    [rowF cardS]=size(S);
    
     if cardS>2
         
       [S, cap1] = MPass(S, cardS); 
       Capacity= Capacity+cap1;
       for l=1:1:cardS
       output_image(x_rev_pix(S1(l)),y_rev_pix(S1(l)))=S(l);
       end
       
         [rsize, csize]=size(e1);
         for pv=1:1:csize
          pvo1(pv1+pv)=e1(pv); 
          pvo2(pv1+pv)=e2(pv); 
        end
        pv1=pv1+csize;
        
    else
        for l=1:1:cardS

      [output_image(x_rev_pix(S1(l)),y_rev_pix(S1(l))), cap1, d1, d2, P_error]=pixel_embed(output_image(x_rev_pix(S1(l)),y_rev_pix(S1(l))), output_image(x_rev_pix(S1(l)),y_rev_pix(S1(l))-1), output_image(x_rev_pix(S1(l))-1,y_rev_pix(S1(l))), output_image(x_rev_pix(S1(l)),y_rev_pix(S1(l))+1), output_image(x_rev_pix(S1(l))+1,y_rev_pix(S1(l))), C_thr1, C_thr2, Thr, Thr1, p1, p2);  
     Capacity= Capacity+cap1;
        end
     end    
     
     
  %y-set Embedding  
    
    %%Flushing the arrays
    G1=1;
    G2=1;
    F=[];
    S=[];
    F1=[];
    S1=[];
    
    pix=[output_image(i,j+1) output_image(i,j+3) output_image(i+1,j) output_image(i+1,j+2) output_image(i+2,j+1) output_image(i+2,j+3) output_image(i+3,j) output_image(i+3,j+2)];
    m(1)=(output_image(i,j)+output_image(i-1,j+1)+output_image(i,j+2)+output_image(i+1,j+1))/4;   %i,j+1
    m(1)=new_predictor(output_image(i,j),output_image(i-1,j+1),output_image(i,j+2),output_image(i+1,j+1), Thr, Thr1);
    m(2)=(output_image(i,j+2)+output_image(i-1,j+3)+output_image(i,j+4)+output_image(i+1,j+3))/4;   %i,j+3
    m(2)=new_predictor(output_image(i,j+2),output_image(i-1,j+3),output_image(i,j+4),output_image(i+1,j+3), Thr, Thr1);
    m(3)=(output_image(i+1,j-1)+output_image(i,j)+output_image(i+1,j+1)+output_image(i+2,j))/4 ;   %i+1,j
    m(3)=new_predictor(output_image(i+1,j-1),output_image(i,j),output_image(i+1,j+1),output_image(i+2,j), Thr, Thr1);
    m(4)=(output_image(i+1,j+1)+output_image(i,j+2)+output_image(i+1,j+3)+output_image(i+2,j+2))/4 ;   %i+1,j+2
    m(4)=new_predictor(output_image(i+1,j+1),output_image(i,j+2),output_image(i+1,j+3),output_image(i+2,j+2), Thr, Thr1);
    m(5)=(output_image(i+2,j)+output_image(i+1,j+1)+output_image(i+2,j+2)+output_image(i+3,j+1))/4 ; %i+2,j+1
    m(5)=new_predictor(output_image(i+2,j),output_image(i+1,j+1),output_image(i+2,j+2),output_image(i+3,j+1), Thr, Thr1);
    m(6)=(output_image(i+2,j+2)+output_image(i+1,j+3)+output_image(i+2,j+4)+output_image(i+3,j+3))/4;   %i+2,j+3
    m(6)=new_predictor(output_image(i+2,j+2),output_image(i+1,j+3),output_image(i+2,j+4),output_image(i+3,j+3), Thr, Thr1);
    m(7)=(output_image(i+3,j-1)+output_image(i+2,j)+output_image(i+3,j+1)+output_image(i+4,j))/4  ; %i+3,j
    m(7)=new_predictor(output_image(i+3,j-1),output_image(i+2,j),output_image(i+3,j+1),output_image(i+4,j), Thr, Thr1);
    m(8)=(output_image(i+3,j+1)+output_image(i+2,j+2)+output_image(i+3,j+3)+output_image(i+4,j+2))/4; %i+3,j+2
    m(8)=new_predictor(output_image(i+3,j+1),output_image(i+2,j+2),output_image(i+3,j+3),output_image(i+4,j+2), Thr, Thr1);
     M=(m(1)+m(2)+m(3)+m(4)+m(5)+m(6)+m(7)+m(8))/8;
    x_rev_pix=[i i i+1 i+1 i+2 i+2 i+3 i+3];
    y_rev_pix=[j+1 j+3 j j+2 j+1 j+3 j j+2];
    
    %Grouping of pxels
   for k=1:1:8
       if (m(k)<M)
           F(G1)=pix(k);
           F1(G1)=k;
           G1=G1+1;
       else
           S(G2)=pix(k);
           S1(G2)=k;
           G2=G2+1;
       end
   end
   
   % Embedding based on cardinality of each group
    [rowF cardF]=size(F);
    
    
    if cardF>2
       [F, cap1] = MPass(F, cardF); 
       Capacity= Capacity+cap1;
       for l=1:1:cardF
       output_image(x_rev_pix(F1(l)),y_rev_pix(F1(l)))=F(l);
       end
       [rsize, csize]=size(e1);
         for pv=1:1:csize
          pvo1(pv1+pv)=e1(pv); 
          pvo2(pv1+pv)=e2(pv); 
        end
        pv1=pv1+csize;
    else
        for l=1:1:cardF

      [output_image(x_rev_pix(F1(l)),y_rev_pix(F1(l))), cap1, d1, d2, P_error]=pixel_embed(output_image(x_rev_pix(F1(l)),y_rev_pix(F1(l))), output_image(x_rev_pix(F1(l)),y_rev_pix(F1(l))-1), output_image(x_rev_pix(F1(l))-1,y_rev_pix(F1(l))), output_image(x_rev_pix(F1(l)),y_rev_pix(F1(l))+1), output_image(x_rev_pix(F1(l))+1,y_rev_pix(F1(l))), C_thr1, C_thr2, Thr, Thr1, p1, p2);  
      Capacity= Capacity+cap1;
        end
    end
    
    [rowF cardS]=size(S);
    
     if cardS>2
         
       [S, cap1] = MPass(S, cardS); 
       Capacity= Capacity+cap1;
       for l=1:1:cardS
       output_image(x_rev_pix(S1(l)),y_rev_pix(S1(l)))=S(l);
       end
       
      [rsize, csize]=size(e1);
         for pv=1:1:csize
          pvo1(pv1+pv)=e1(pv); 
          pvo2(pv1+pv)=e2(pv); 
        end
        pv1=pv1+csize;
        
    else
        for l=1:1:cardS

      [output_image(x_rev_pix(S1(l)),y_rev_pix(S1(l))), cap1, d1, d2, P_error]=pixel_embed(output_image(x_rev_pix(S1(l)),y_rev_pix(S1(l))), output_image(x_rev_pix(S1(l)),y_rev_pix(S1(l))-1), output_image(x_rev_pix(S1(l))-1,y_rev_pix(S1(l))), output_image(x_rev_pix(S1(l)),y_rev_pix(S1(l))+1), output_image(x_rev_pix(S1(l))+1,y_rev_pix(S1(l))), C_thr1, C_thr2, Thr, Thr1, p1, p2);  
     Capacity= Capacity+cap1;
        end
     end        
end    
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
[hh,tt]=hist(pvo1,[-15:1:15]);
figure;
M=bar(tt,hh); 
% % [hh,tt]=sort(hh,'descend');
% 
[hh,tt]=hist(pvo2,[-15:1:15]);
figure;
M=bar(tt,hh); 
% % [hh,tt]=sort(hh,'descend');

        
        
   
   
   
   