function [output_image1, P_value, Rhombus_Avg, L_mean, H_mean, L_complexity] = C_predictor(output_image1, L_output_image1, T_output_image1, R_output_image1, B_output_image1, Thr, Thr1 )
     Rhombus_Avg=round((L_output_image1 + T_output_image1 + R_output_image1 + B_output_image1)/4);   % rhombus mean
     L_complexity=round((((Rhombus_Avg-L_output_image1).^2)+((Rhombus_Avg-T_output_image1).^2)+((Rhombus_Avg-R_output_image1).^2)+((Rhombus_Avg-B_output_image1).^2))/4);  % Local Complexity
     image_block = [L_output_image1 T_output_image1 R_output_image1 B_output_image1];    
         [S_value Index_value]=sort(image_block);   
     L_mean=round((S_value(1)+S_value(2)+S_value(3))/3);      % Mean of minimum three srrounding pixels 
     H_mean=round((S_value(2)+S_value(3)+S_value(4))/3);      % Mean of maximum three srrounding pixels 
      
     % our preecitor working starts
     
     Hor_P_val=double(round((L_output_image1+R_output_image1)/2));
      Ver_P_val=double(round((T_output_image1+B_output_image1)/2));
      diff=Hor_P_val-Ver_P_val;
      diff1=abs(L_output_image1-R_output_image1);
      diff2=abs(T_output_image1-B_output_image1);
      if (diff<Thr)
        P_value=Rhombus_Avg;
      elseif ((diff1-diff2)>-Thr1)
          P_value=Ver_P_val;
      elseif ((diff1-diff2)<Thr1)
        P_value=Hor_P_val;  
      elseif Hor_P_val>Ver_P_val
          P_value=Ver_P_val;
      else
        P_value=Hor_P_val;  
      end


end

