function [ P_value, Mean_Avg, L_mean, H_mean, L_complexity] = new_predictor(L_output_image1, T_output_image1, R_output_image1, B_output_image1, Thr, Thr1 )
     Mean_Avg=round((L_output_image1 + T_output_image1 + R_output_image1 + B_output_image1)/4);
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


end

