function [maskf] = maskPupille(im,mask)
% Lucas

% prend en argument un masque 1D et renvoie un autre masque 1D
[a,b,c] = size(im);
imagehsv = rgb2hsv(im);
mask2 = imagehsv(:,:,3);   
%saturation de l'image

mask3 = mask(:,:,1).*mask2; 
%masque avec saturation

maskb = mask3<(max(mask2(:))-min(mask3(:)))*0.5;
%détéction des parties noirs de toute l'image

maskc = maskb.*mask3;       
maskblanc = maskc>0.1;
se = strel ('disk',1); % rayon du disque
maskerod = imerode(maskblanc,se);
maskdilate=  imdilate(maskerod,se); % Petite erosion pour retirer les cils
maskf = (maskdilate.*mask3)>0.1;

% figure();
% imshow(maskf);
end