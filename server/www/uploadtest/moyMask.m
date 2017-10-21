function moyEachChannel = moyMask(mask, image) % mask = maskbouche ou maskpeau (1D)
% Mariem

% mask 3D
mask3D=true(size(image));

mask3D(:,:,1) = mask;
mask3D(:,:,2) = mask;
mask3D(:,:,3) = mask;

% multiplication du masque par l'image initiale + normalisation
imageMask = image(mask3D);

imageMask=reshape(imageMask,sum(mask(:)),3);


% calcul des moyennes sur chaque canal 
% ATTENTION : ne pas tenir compte des 0 dans le calcul 

moyEachChannel= mean(imageMask);


end