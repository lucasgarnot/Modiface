function [imcolor] = createColor(im,color)
%Lucas

% On crée une image 255 de la même taille que im mais avec une couleur uniforme

[a,b,c] = size(im);
convert = 1;
switch(color)  
    case{'orange'}
        imhsv2(:,:,1) = 0.05*ones(a,b);
        imhsv2(:,:,2) = ones(a,b);
        imhsv2(:,:,3) = 0.85*ones(a,b);
    case{'jaune'}
        imhsv2(:,:,1) = 0.1*ones(a,b);
        imhsv2(:,:,2) = ones(a,b);
        imhsv2(:,:,3) = 0.95*ones(a,b);
    case{'vert'}
        imhsv2(:,:,1) = 0.35*ones(a,b);
        imhsv2(:,:,2) = 0.8*ones(a,b);
        imhsv2(:,:,3) = 0.80*ones(a,b);
    case{'bleu'}
        imhsv2(:,:,1) = 0.5*ones(a,b);
        imhsv2(:,:,2) = ones(a,b);
        imhsv2(:,:,3) = 0.90*ones(a,b);
    case{'violet'}
        imhsv2(:,:,1) = 0.72*ones(a,b);
        imhsv2(:,:,2) = 0.75*ones(a,b);
        imhsv2(:,:,3) = ones(a,b);
    case{'rose'}
        imhsv2(:,:,1) = 0.8*ones(a,b);
        imhsv2(:,:,2) = 0.6*ones(a,b);
        imhsv2(:,:,3) = 0.98*ones(a,b);
    case{'rouge'}
        imhsv2(:,:,1) = 0.98*ones(a,b);
        imhsv2(:,:,2) = 0.97*ones(a,b);
        imhsv2(:,:,3) = 0.65*ones(a,b);   
   case{'asiat'}
        imhsv2(:,:,1) = 205*ones(a,b);
        imhsv2(:,:,2) = 190*ones(a,b);
        imhsv2(:,:,3) = 72*ones(a,b);
        convert = 0;
    case{'bronze'}
        imhsv2(:,:,1) = 158*ones(a,b);
        imhsv2(:,:,2) = 97*ones(a,b);
        imhsv2(:,:,3) = 26*ones(a,b);
        convert = 0;
    case{'indien'}
        imhsv2(:,:,1) = 123*ones(a,b);
        imhsv2(:,:,2) = 69*ones(a,b);
        imhsv2(:,:,3) = 64*ones(a,b);
        convert = 0;
end
if convert == 1
    imcolor = hsv2rgb(imhsv2).*255;
    % Les couleurs classiques sont trouvé directement sur matlab dans
    % l'espace hsv entre 0 et 1. Par conséquent on les remet en RVB 255
else
    imcolor = imhsv2;
    % Les couleurs de peau sont déjà en RVB et basées à partir des essaies
    % de photoshop
end
end













