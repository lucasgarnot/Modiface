function [newimaged] = changeFormEye(image, centerLeft, centerRight, R)
% Amale

[lignes,colonnes,canaux]=size(image)
max(image(:))

%Isolement des coordonnées des centres
x1 = floor(centerLeft(1,1));
y1 = floor(centerLeft(1,2));

x2 = floor(centerRight(1,1));
y2 = floor(centerRight(1,2));

%canaux rouge, vert, bleu
r = image(:,:,1);
v = image(:,:,2);
b = image(:,:,3);

newr = r;
newb = b;
newv = v;

newimaged = image;

for i = x1-R:x1+R
    for j = y1-R:y1+R
        r1 =sqrt((i-x1)*(i-x1)+(j-y1)*(j-y1));
        
        if(r1<R)
            s=signoid(r1/R);
            ii = x1+s*(i-x1);
            jj = y1+s*(j-y1);
            newr(j,i) = approxbilin(r,jj,ii);
            newv(j,i) = approxbilin(v,jj,ii);
            newb(j,i) = approxbilin(b,jj,ii);
        end
    end
end
for i = x2-R:x2+R
    for j = y2-R:y2+R
        r2 =sqrt((i-x2)*(i-x2)+(j-y2)*(j-y2));
        
        if(r2<R)
            s=signoid(r2/R);
            ii = x2+s*(i-x2);
            jj = y2+s*(j-y2);
            newr(j,i) = approxbilin(r,jj,ii);
            newv(j,i) = approxbilin(v,jj,ii);
            newb(j,i) = approxbilin(b,jj,ii);
          
        end
    end
end

newimaged(:,:,1) = newr;
newimaged(:,:,2) = newv;
newimaged(:,:,3) = newb;
max(newimaged(:))
% figure(1000);
% imagesc(newimaged./255);
end