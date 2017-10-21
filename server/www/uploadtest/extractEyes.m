function [centreLeft,centreRight,eyemask] =extractEyes(eyemaskarg,positionbouche)
% lucas
% Mariem
% On prends les composantes qui sont à peu pres symetrique par
% rapport a l'axe verticale de la bouche et a peu pres a la meme ordonnee.
% renvoie un masque 1D et la position des yeux

mask = eyemaskarg(:,:,1);
[a,b] = size(mask);
se = strel('disk',floor((sqrt(a*b)/200)));
masktmp= imerode(mask,se);
mask1d= imdilate(masktmp,se);
% erosion/dilatation pour reduire le nompbre de composantes connexe

[l,num]= bwlabel(mask1d,8);
s = regionprops(l,'centroid');
centroids = cat(1, s.Centroid);
xCenters = centroids(:,1);
yCenters = centroids(:,2);
hold on
plot(xCenters,yCenters, 'b*')
hold off

x = positionbouche(1);
y = positionbouche(2);
XMask = xCenters(:)<x
xCenterLeft = xCenters.*XMask;
xCenterRight = xCenters.*(1-XMask);
% On fait la liste des centre des composantes connexes qui sont a gauche te
% a droite de la bouche
listex = [];
[c,d] = size(xCenterLeft);
% On garde chaque composante connexes dans le cas ou il existe une
% composante symétrique par rapport a l'axe de la bouche
% a note que cette methode ne renvoie pas forcement un nombre de
% composante pair
for i = 1:c
      if xCenterRight(i)~=0
          for j = 1:c
              if xCenterLeft(j)~=0
                  e = xCenterRight(i) - xCenterLeft(j);
                  e2 = x - xCenterLeft(j);
                  abs(yCenters(j) - yCenters(i));
                  if e2<(2/3)*e && e2>(1/3)*e && abs(yCenters(j) - yCenters(i))<120
                      listex = [listex [xCenterLeft(j),xCenterRight(i)]];
                  end
              end
          end
      end
end
[g,h] = size(listex);
eyemask = zeros(a,b);

% On reforme le masque avec les composantes selectionnees
for k = 1:h
    for m = 1:c
        tmp = centroids(m,1);
        tmp2 = listex(1,k);
       if tmp == tmp2
           p = [centroids(m,2);centroids(m,1)];
           index = l(floor(centroids(m,2)) ,floor(centroids(m,1)));
           eyemask = eyemask + (l==index);
       end
    end
end
% figure(55);
% imagesc(eyemask);
% colormap gray

% On cherche les centres correspondant aux composantes
[l,num2]= bwlabel(eyemask,8);
s = regionprops(l,'centroid');
centroidfinal = cat(1, s.Centroid);
p1 = centroidfinal(1,:)
p2 = centroidfinal(2,:)
if centroidfinal(1,1)<centroidfinal(2,1)
    centreLeft = p1;
    centreRight = p2;
else
    centreLeft = p2;
    centreRight = p1;
end