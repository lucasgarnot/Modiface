function [centerLeft,centerRight,eyemask] = eyeMask(im,skinmask, mouth_position)
% Lucas
% Cette fonction renvoie la position des yeux à partir de l'image 255, du
% masque de la peau et de la position de la bouche.

e = eyeMask1(im,skinmask);

%Premièrement on fait le masque grossié des yeux que l'on multipli par le
%masque de la peau

[centerLeft,centerRight,eyemaskextract] = extractEyes(e,mouth_position);

% Ensuite on prends les composantes qui sont à peu pres symetrique par
% rapport a l'axe verticale de la bouche et a peu pres a la meme ordonnee.
% Les conditions sont donc de ne pas avoir la tete penchee.
% Le probleme de cette methode c'est qu'elle arrete l'algorithme dans le
% cas ou elle ne detecte qu'un oeil car il n'y a pas les output prevues

eyemask = maskPupille(im,eyemaskextract);

% Enfin on extrait les pupille grace a un seuillage locale

end