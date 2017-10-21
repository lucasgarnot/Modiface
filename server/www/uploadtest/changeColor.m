function [newim] = changeColor(im,mask,color)
%Lucas

%prend en argument une image 255 et un masque 1D et renvoie l'image 255 (double) avec la couleur modifiée selon les zones blanches du masque

s = mask;
mask3D(:,:,1) = s;
mask3D(:,:,2) = s;
mask3D(:,:,3) = s;

% On met le masque en 3D pour pouvoir faire des opérations avec l'image

skin = createColor(im,color);

% On crée une image 255 de la même taille que im mais avec une couleur uniforme

imagecolor= incruster(im,skin);

% On fusionne l'image de couleur uniforme avec l'image d'origine selon la
% méthode d'incrustation de calque de photoshop

newim = double(mask3D).*(double(imagecolor)) + (double(im)).*(1 - double(mask3D));

% On garde la photo avec la couleur modifiée uniquement selon le masque

% figure(1);
% imagesc(newim./255);
end