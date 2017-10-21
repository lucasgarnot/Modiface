function [maskF,mouth_position] = mouthMask(im, skinmask)
%Mariem

imconvert = double( rgb2ycbcr(im) ); %conversion

canalCbconv = double(imconvert (:,:,2)); %canaux de l'image convertie en YCbCr
canalCrconv = double(imconvert (:,:,3));

% calcul de la formule + normalisatiob
imCr2 = double( canalCrconv).* double (canalCrconv);
imCr2norm= 255* (  ( double( imCr2 ) - double( min( imCr2(:) ) )) ./ ( double ( max(imCr2(:)) ) - double( min( imCr2(:) ) ) ) );

imCrCb = double( canalCrconv)./ double (canalCbconv);
imCrCbnorm= 255* ( ( double( imCrCb ) - double( min( imCrCb(:)) ) ) ./ ( double(max (imCrCb(:) )) - double ( min (imCrCb(:) ) ) ) );


% en tenant compte du masque de la peau
Cr2 = imCr2(skinmask==1);
CrCb = imCrCb(skinmask==1);

% normalisation
CrCbnorm= 255.* ( ( double( CrCb ) - double( min( CrCb(:)) ) ) ./ ( double(max (CrCb(:) )) - double ( min (CrCb(:) )) ) );
Cr2norm= 255.* ( ( double( Cr2 ) - double( min( Cr2(:) ) )) ./ ( double ( max(Cr2(:)) ) - double( min( Cr2(:) ) ) ) );

mean1 = mean(Cr2norm(:)); % calcul des moyennes
mean2 = mean(CrCbnorm(:));
coef = 0.95*(mean1./mean2); % calcul du coeff

% formule complète 
mouthmap= imCr2norm.*((imCr2norm - coef*imCrCbnorm ).^2);

% figure();
% imagesc(mouthmap);
% colormap gray;

% dilatation et érosion 
se= strel('disk',12);
mask= imerode(imdilate(mouthmap, se),se);

mouth = mask >  (max(mask(:)) - 10*mean(mask(:)) ) * (2/7); % seuillage
maskInputExtract = imdilate(mouth, se);

[maskfinal,listPixels,mouth_position] = extractMouth(maskInputExtract);
[maskOptimized,xmin,ymax] = mouthMaskOpt (im,maskfinal,listPixels);

maskF=incrusterMouth(im, maskOptimized, xmin,ymax);
% figure(200);
% imagesc(maskF);
end