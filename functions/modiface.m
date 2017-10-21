function [newimage] = modiface(fichier, eyecolor,skincolor,mouthcolor,objet,deform_eye,deform_mouth,deform_nose)
% Amale 
% Mariem 
% Lucas

% Fonction principale de l'aplication. elle permet de prende un nom de fichier et tous les
% arguments puis de faire tous les traitements et de renvoyer une image RVB
% entre 0 et 1 modifiée

im = imread(fichier);

% Premièrement on calcule tous les masques sur l'image d'origine.
% On est obligé de faire cela car on a effectué toutes les détections sur
% l'image d'origine et on n'est pas certain que la bouche sera detectee si
% l'on a modifie la couleur de la peau auparavant.
% Le principal problème de cette integration de derniere minute est que
% tout les maques doivent marcher sinon la fonction plante (meme si on ne voulait
% qu'un traitement et que le masque qui servait à notre traitement avait fonctionné)

skinmask = skinMask(im);
[mouthmask, centerMouth] = mouthMask(im,skinmask);
[centerLeft,centerRight,eyemask] = eyeMask(im,skinmask, centerMouth);
centerNose = extractNose(centerLeft,centerRight,centerMouth);

% Ensuite on effectue les changements de couleur

if(strcmp(eyecolor,'null') == 0)
    im1 = changeColor(im,eyemask,eyecolor);
else
    im1 = im;
end

if(strcmp(mouthcolor,'null') == 0)
    im2 = changeColor(im1,mouthmask,mouthcolor);
else
    im2 = im1;
end

if(strcmp(skincolor,'null') == 0)
    im3 = changeColor(im2,skinmask,skincolor);
else
    im3 = im2;
end

if (strcmp(deform_eye,'null')==0)
    im5 = changeFormEye(im3, centerLeft, centerRight, 50);
else
    im5=im3;
end

if (strcmp(deform_mouth,'null')==0)
    im6 = changeFormMouth(im5, centerMouth, 70, 40);
else
    im6=im5;
end

if (strcmp(deform_nose,'null')==0)
    im7 = changeFormNose(im6, centerNose, 40,70);
else
    im7=im6;
end
    
if(strcmp(objet,'null') == 0)
    im8 = incruste_objet(im7,objet,centerLeft,centerRight);
else
    im8 = im7;
end
newimage = double(im8);
figure(123456);
image(newimage./255);
end