function [result,listPixels, centerMouth] = extractMouth(mouth) % mouth = masque non optimisé
% Mariem

% composantes connexes 
[l,num]= bwlabel(mouth,8);
s = regionprops(l,'centroid');
% figure();
% imagesc(l);

% détermination des centres de chaque objet connexe
centroids = cat(1, s.Centroid);
% imshow(l)
hold on
plot(centroids(:,1),centroids(:,2), 'b*')
hold off

xCenters = centroids(:,1);
yCenters = centroids(:,2);

% isolation de la bocuhe : composante connexe ayant la plus grande ordonnée
% = num ligne
ymax= max(yCenters);
ymaxIndex = find(yCenters==ymax); % indice dans l
xmax= xCenters(ymaxIndex); % abscisse = num colonnes
maskmouth=(l==ymaxIndex); % mask final 1D

%mask 3D
maskfinal(:,:,1) = maskmouth;
maskfinal(:,:,2) = maskmouth;
maskfinal(:,:,3) = maskmouth;

%determination de la liste de pixels constituant la bouche
pixels= regionprops(maskmouth,'PixelList'); 
list= cat(1,pixels.PixelList);

% Affectation des résultats
result = maskfinal;
centerMouth= [xmax,ymax];
listPixels = list;

% figure();
% imagesc(result);
% colormap gray;
end