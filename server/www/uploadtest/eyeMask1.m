function [eyemask] = eyeMask1(im,skinmask) %skinmask) % mask=skinmask
% Mariem
% Lucas
[a,b,c] = size(im);
imconvert = rgb2ycbcr(im); %conversion

canalCb = imconvert (:,:,2); %canaux
canalCr = imconvert(:,:,3);

function [matf] = normalize255(mat)
    matf = ((mat-min(mat(:)))./(max(mat(:))-min(mat(:))))*255;
end

part1 = normalize255(double (canalCb).*double(canalCb));
part2 = normalize255(double (255-canalCr).*double(255-canalCr));
part3 = normalize255(double (canalCb)./double(canalCr));

eyemapC= (1/3).*(part1+part2+part3);       %1er mapping

% figure(1);
% imagesc(eyemapC);
% colormap gray

se = strel ('disk',floor(sqrt(a*b)/65)); 
% rayon du disque en fonction de la taille des yeux et d'un coefficient expérimental décrivant la taille relative des yeux sur une photo
num =  imdilate(imconvert(:,:,1),se);
denom= imerode(imconvert(:,:,1),se) +1;
eyemapL = double (num./denom);          %2ème mapping

% figure(2);
% imagesc(eyemapL);
% colormap gray

eyemap = eyemapC.*eyemapL; %mapping final

% figure (3) ;
% imagesc(eyemap);
% colormap gray;

maskfinal = eyemap > (max(((eyemap(:))-min(eyemap(:)))*(3/9))); %seuil à 3/7ème
%maskfinal= imdilate(masktmp,se2);

% figure(4);
% imagesc(maskfinal);
% colormap gray;
 
se2 = strel ('disk',floor(sqrt(a*b)/30)); 
s = imdilate(skinmask,se2);
%dilation pour compléter les trous qu'il y a dans le masque des yeux au niveau du visage

se3 = strel ('disk',floor(sqrt(a*b)/15)); 
skinmask2 = imerode(s,se3);
%erosion pour suprimmer les composantes parasite sur le contour du visage dans le masque des yeux

eyemask = double(maskfinal(:,:,1).*double(skinmask2));
% Multiplication masque peau/yeux

% figure(44);
% imagesc(skinmask2);
% colormap gray;
% figure(66);
% imagesc(eyemask);
% colormap gray
end