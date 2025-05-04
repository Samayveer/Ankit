function [F, cap2, e] = IPVO_b_embed(F, cardF)
cap2=0;
p1=0;
p2=1;
[S_value, Index]=sort(F);
median_ele=round(cardF/2);

for i=1:1:median_ele-1
    
    if Index(i)<Index(cardF)
     e1(i)=S_value(i)-S_value(median_ele);
    else
    e1(i)=S_value(median_ele)-S_value(i);
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

e(1:(median_ele-1))=e1;
    
e1=[];
k=1;

   for i=median_ele+1:1:cardF
    if Index(i)<Index(cardF)
     e1(k)=S_value(i)-S_value(median_ele);
    else
    e1(k)=S_value(median_ele)-S_value(i);
    end
     if (e1(k)==p1 || e1(k)==p2)
%           if (e1(i)==p1)
            a1=0; x1=1;
          b=round(a1+(x1-a1)*rand(1));
          S_value(i)=S_value(i)+b;
          cap2=cap2+1;
   
       elseif e1(k)<p1
              S_value(i)=S_value(i)+1; 
              
        elseif e1(k)>p2
              S_value(i)=S_value(i)+1; 
     end
     k=k+1;
   end
%    e
%    e1
%    median_ele
%    median_ele+k-2
%    median_ele+k-1-median_ele
   
e(median_ele:median_ele+k-2)=e1;
      for i=1:1:cardF
              F(Index(i))=S_value(i);
      end

end



