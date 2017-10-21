function [newimage] = changeFormNose(image, center,a,c)
% Amale

%Isolement des coordonnées des centres
x1 = floor(center(1,1));
y1 = floor(center(1,2));

newimage = image;

%canaux rouge, vert, bleu
r = image(:,:,1);
v = image(:,:,2);
b = image(:,:,3);

newr = r;
newb = b;
newv = v;


for i=x1-a:x1+a
   for j =y1-c:y1+c
        r1 =sqrt((i-x1)*(i-x1)/(a*a)+(j-y1)*(j-y1)/(c*c));
       
        if(r1<1)
            s=signoid(r1);
            ii = x1+s*(i-x1);
            jj = y1+s*(j-y1);
            newr(j,i) = approxbilin(r,jj,ii);
            newv(j,i) = approxbilin(v,jj,ii);
            newb(j,i) = approxbilin(b,jj,ii);
        end
   end
end

newimage(:,:,1) = newr;
newimage(:,:,2) = newv;
newimage(:,:,3) = newb;
% 
% figure();
% imagesc(newimage./255);

end
