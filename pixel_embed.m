function [output_image1, cap1, d1, d2, P_error] = pixel_embed(output_image1, L_output_image1, T_output_image1, R_output_image1, B_output_image1, C_thr1, C_thr2, Thr, Thr1, p1, p2)
cap1=0;
p1=1;
p2=1;
Mean_Avg=round((L_output_image1 + T_output_image1 + R_output_image1 + B_output_image1)/4);
% dd1=Mean_Avg;
complexity=round((((Mean_Avg-L_output_image1).^2)+((Mean_Avg-T_output_image1).^2)+((Mean_Avg-R_output_image1).^2)+((Mean_Avg-B_output_image1).^2))/4);
 if complexity<C_thr1
     
     P_error=256;  %To map errors for identifying peak bins of histograms
         image_block = [L_output_image1 T_output_image1 R_output_image1 B_output_image1];
         [S_value Index_value]=sort(image_block);    
        dd1=floor((S_value(1)+S_value(2)+S_value(3))/3);
         d1=double(output_image1-dd1);
         if d1==p1
                 a1=0; x1=1;
                  b=round(a1+(x1-a1)*rand(1));
                output_image1=output_image1+b; 
                cap1=cap1+1;
            elseif  d1>p1   
                   output_image1=output_image1+1;         
         end 
         dd2=ceil((S_value(2)+S_value(3)+S_value(4))/3);
%          if dd2==dd1
%              dd2=dd2+1;
%          end
          d2=double(output_image1-dd2);
          
           if d2==p2
                 a1=0; x1=1;
                  b=round(a1+(x1-a1)*rand(1));
                output_image1=output_image1-b; 
                cap1=cap1+1;
            elseif  d2<p2   
                   output_image1=output_image1-1;
                   
           end
 elseif (complexity>=C_thr1 && complexity<C_thr2)
     
     % proposed predictor
     
      d1=256;  %To map errors for identifying peak bins of histograms
      d2=256;  %To map errors for identifying peak bins of histograms
     Hor_P_val=double(round((L_output_image1+R_output_image1)/2));
      Ver_P_val=double(round((T_output_image1+B_output_image1)/2));
      diff=Hor_P_val-Ver_P_val;
      diff1=abs(L_output_image1-R_output_image1);
      diff2=abs(T_output_image1-B_output_image1);
      if (diff<Thr)
        P_value=Mean_Avg;
      elseif ((diff1-diff2)>-Thr1)
          P_value=Ver_P_val;
      elseif ((diff1-diff2)<Thr1)
        P_value=Hor_P_val;  
      elseif Hor_P_val>Ver_P_val
          P_value=Ver_P_val;
      else
        P_value=Hor_P_val;  
      end
     
      P_error=output_image1-P_value;
      
      %embedding using Sachnev's method
      if P_error==0
            a1=0; x1=1;
              b=round(a1+(x1-a1)*rand(1));
             output_image1=output_image1+b;
             cap1=cap1+1;
             
      elseif P_error==-1
            a1=0; x1=1;
              b=round(a1+(x1-a1)*rand(1));
             output_image1=output_image1-b;
             cap1=cap1+1;
             
         elseif P_error<-1
           output_image1=output_image1-1;
             
      else
           output_image1=output_image1+1;  
           
      end
      
 else
      d1=256;  %To map errors for identifying peak bins of histograms
      d2=256;  %To map errors for identifying peak bins of histograms 
      P_error=256;  %To map errors for identifying peak bins of histograms
     
 end



end

