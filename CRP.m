function [P_value] = CRP(L, T, R, B, Thr, Thr1)
      Hor_P_val=double(round((L+R)/2));
      Ver_P_val=double(round((T+B)/2));
      diff=Hor_P_val-Ver_P_val;
      diff1=abs(L-R);
      diff2=abs(T-B);
       if (diff<Thr)
        P_value=double(round((L+T+R+B)/4));
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

