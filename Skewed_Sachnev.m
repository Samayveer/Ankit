function [output_image1, cap1] = Skewed_Sachnev(output_image1, Pmean, L_mean, H_mean, L_complexity, C_thr1, C_thr2)
cap1=0;
p1=1;
p2=1;

  %embedding using sKwed method
 if L_complexity<C_thr1

         d1=double(output_image1-L_mean);
         if d1==p1
                 a1=0; x1=1;
                  b=round(a1+(x1-a1)*rand(1));
                output_image1=output_image1+b; 
                cap1=cap1+1;
            elseif  d1>p1   
                   output_image1=output_image1+1;         
         end 
       
          d2=double(output_image1-H_mean);
          
           if d2==p2
                 a1=0; x1=1;
                  b=round(a1+(x1-a1)*rand(1));
                output_image1=output_image1-b; 
                cap1=cap1+1;
            elseif  d2<p2   
                   output_image1=output_image1-1;
                  
           end
  
           
  %embedding using Sachnev's method
           
 elseif (L_complexity>=C_thr1 && L_complexity<C_thr2)
     
         
      P_error=output_image1-Pmean;
      

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
      
 

     
 end



end

