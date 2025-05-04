function [F, cap2, e1, e2] = IPVO_b_embed(F, cardF)
cap2=0;
p1=-3;
p2=-2;
[S_value, Index]=sort(F);
for i=1:1:cardF-1
    
    if Index(i)<Index(cardF)
     e1(i)=S_value(i)-S_value(cardF);
    else
    e1(i)=S_value(cardF)-S_value(i);
    end
     if (e1(i)==p1 || e1(i)==p2)
%           if (e1(i)==p1)
            a1=0; x1=1;
          b=round(a1+(x1-a1)*rand(1));
          S_value(i)=S_value(i)-b;
          cap2=cap2+1;
   
       elseif e1(i)<p1
              S_value(i)=S_value(i)-1; 
              
        elseif e1(i)>p2
              S_value(i)=S_value(i)-1; 
              
     end
end
       for i=1:1:cardF
              F(Index(i))=S_value(i);
       end
  
p1=-3;
p2=-2;      
  [S_value, Index]=sort(F);

   for i=2:1:cardF
       if Index(1)<Index(i) 
       e2(i-1)=S_value(1)-S_value(i);
       else
          e2(i-1)=S_value(i)-S_value(1);
       end  
       if (e2(i-1)==p1 || e2(i-1)==p2)
       
            a1=0; x1=1;
          b=round(a1+(x1-a1)*rand(1));
         S_value(i)=S_value(i)+b;
          cap2=cap2+1;
   
         elseif e2(i-1)<p1
              S_value(i)=S_value(i)+1; 
              
          elseif e2(i-1)>p2
              S_value(i)=S_value(i)+1; 
       end
        end

      for i=1:1:cardF
              F(Index(i))=S_value(i);
      end

end



