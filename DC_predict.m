function [P_value] = DC_predict(L,T,R,B,Thr)
      Hor_P_val=double(round((L+R)/2));
      Ver_P_val=double(round((T+B)/2));
      diff=Hor_P_val-Ver_P_val;
       if (diff<Thr)
        P_value=double(round((L+T+R+B)/4));
      elseif Hor_P_val>Ver_P_val
          P_value=Ver_P_val;
      else
        P_value=Hor_P_val;  
      end 
end

