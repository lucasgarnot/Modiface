function [centerNose] = extractNose( centerLeft,centerRight,centerMouth )
%Mariem

%Isolement des coordonnées des centres des yeux
x1 = floor(centerLeft(1,1));
y1 = floor(centerLeft(1,2));

x2 = floor(centerRight(1,1));
y2 = floor(centerRight(1,2));

%Coordonnées du milieu du segment joignant les centres des deux yeux
xm = floor((x1+x2)/2);
ym = floor((y1+y2)/2);

%Coordonnées du centre de la bouche
x3 = floor(centerMouth(1,1));
y3 = floor(centerMouth(1,2));

centerNose(1,1) = floor((xm+2*x3)/3);
centerNose(1,2) = floor((ym+2*y3)/3);


end