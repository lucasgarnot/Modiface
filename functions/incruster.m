function [newimage] = incruster (imagea,colorimage)
% Lucas

% prend en argument deux images 255 et renvoie une image résultant de la
% fusion des deux images (255) comme si l'image colorimage était en mode
% incrustation sur photoshop et était par dessus imagea
im1 = imagea;
im2 = colorimage;
maskR = im1(:,:,1)>128;
maskG = im1(:,:,2)>128;
maskB = im1(:,:,3)>128;

% On crée des masques selon les trois canaux qui correspondent aux endroit
% ou la couleur de canal est forte (lumineuse).

newimage(:,:,1) = double(maskR).*(eclaircir(im1(:,:,1),im2(:,:,1))) + (1-double(maskR)).*(assombrir(im1(:,:,1),im2(:,:,1)));
newimage(:,:,2) = double(maskG).*(eclaircir(im1(:,:,2),im2(:,:,2))) + (1-double(maskG)).*(assombrir(im1(:,:,2),im2(:,:,2)));
newimage(:,:,3) = double(maskB).*(eclaircir(im1(:,:,3),im2(:,:,3))) + (1-double(maskB)).*(assombrir(im1(:,:,3),im2(:,:,3)));

% Si la couleur est forte, on fusionne en utilisant l'algorithme l'éclaicissement
% Si elle est faible on utilise l'algorithme de fusion assombrissement. Cela
% permet d'incruster la couleur tout en gardant le contraste de l'image

% figure(1111);
% imagesc(newimage./255);
end

function[mata] = eclaircir(mat1,mat2)
a = 1-(double(mat1)/255);
b = 1-(double(mat2)/255);
mata = (1 - 2*a.*b)*255;
end

% Prend en argument deux images 1D 255 et renvoie une image 255
% Même principe que assombrir mais on multiplie 1 - image cette fois pour
% amplifier la luminosité

function[matb] = assombrir(mat1,mat2)
matb = (2*double(mat1).*double(mat2))/(255);

% Prend en argument deux images 1D 255 et renvoie une image 255 qui est la
% multiplication des deux matrices point par point. Cela donnera un résultat
% plus sombre que les deux images. On multiplie par deux pour mettre à
% l'échelle: si l'une des deux image vaut 0.5, alors la résultante ne change
% pas.
end