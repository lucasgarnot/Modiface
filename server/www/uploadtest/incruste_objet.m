function [imagelun] = incruste_objet(im,objet,centerLeft, centerRight)
% Lucas
% renvoie une image 255 avec un objet incrustee
multiplier = 0;
% Choix de l'objet
switch(objet)
    case{'lunettes'}
        pog = [422,287];
        pod = [765,287];
        obj = imread('Rayban.jpg');
        multiplier = 1;
    case{'lunettes2'}
        pog = [233,130];
        pod = [556,136];
        obj = imread('lunettes2.jpg');
        multiplier = 1; 
    otherwise
        pog = [0,0];
        pod = [0,0];
end

coef = double(centerRight(1) - centerLeft(1))/double(pod(1) - pog(1));
pog2 = floor(coef*pog);
obj2 = imresize(obj,coef);
% On resize l'image en fonction de la distance entre les deux yeux

[a,b,c] = size(im);
[d,e,f] = size(obj2);
z = zeros(a,b);
A (:,:,1)= z;
A (:,:,2)= z;
A (:,:,3)= z;

x = floor(centerLeft(1) - pog2(1));
y = floor(centerLeft(2) - pog2(2));
% incruste l'objet en parcourant pixel par pixel 
for m = x:x+e 
    for n = y:y+d
        if x+m<b && y+n<a
            if obj2(max(1,n-y),max(1,m-x),1)<230 && obj2(max(1,n-y),max(1,m-x),2)<230 && obj2(max(1,n-y),max(1,m-x),3)<230
                % Si le pixel n'est pas blanc alors on le remplace
            A(n,m,:) = double(obj2(max(1,n-y),max(1,m-x),:));   %.*(double(im(n,m,:))/255);
            end
        end
    end
end
B = A>0.1;
se = strel ('disk',2);
mask = imerode (B,se);

%Selon les objets on peut multiplier ou superposer l'objet a l'image
if multiplier == 1
    imagelun1 = (double(A)/255).*double(mask).*(double(im)/255) + (1-double(mask)).*(double(im)/255);
else    
    imagelun1 = (double(A)/255).*double(mask) + (1-double(mask)).*(double(im)/255);
end
imagelun = imagelun1*255;

% figure();
% imagesc(imagelun./255);
end