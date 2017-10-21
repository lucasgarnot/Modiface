function [C] = incrusterMouth(im, maskOptimized,x,y)
% Lucas
% Mariem

obj = maskOptimized;
% figure(55);
% imagesc(obj);
[a,b,c] = size(im);
[d,e,f] = size(obj);
z = zeros(a,b);
A (:,:,1)= z;
A (:,:,2)= z;
A (:,:,3)= z;
for m = x+1 : x+e 
    for n = y+1 : y+d
            %if obj2((n-y),m-x,1)>0 | obj2(n-y,m-x,2)>0 | obj2(n-y,m-x,3)>0
             A(n,m,:) = double(obj(n-y,m-x,:));%.*(double(im(n,m,:))/255);
            %end
    end
end
B = A>0.1;
C = B(:,:,1);
end