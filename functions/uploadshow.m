function html=uploadshow(headers,config)
% Cyril
% Lucas
% Amale

% Cette fonction implémente les action à faire lorsque l'on upload une
% image

filename_in=headers.Content.imagefile.Filename;
filename_in_html=filename_in(length(config.www_folder)+2:end);
[pathstr,name,ext] = fileparts(filename_in);
filename_out=[pathstr '/' name 'indien' ext]; % fichier de sortie en sauvegarde sur le serveur

J = modiface(filename_in,headers.Content.eyesColor.ContentData,headers.Content.skinColor.ContentData,headers.Content.mouthColor.ContentData,headers.Content.objet.ContentData,headers.Content.deform_eye.ContentData,headers.Content.deform_mouth.ContentData,headers.Content.deform_nose.ContentData);

% On lance la fonction MODIFACE avec tous les parametres recuperees

headers.Content

 imwrite(J,filename_out);
 filename_out_html=filename_out(length(config.www_folder)+2:end);

%Cette partie implémente les boutons de l'interface du site web
html='<html><head></head><body>';
html=[html 'This html is produced by upload show.m <br><br>'];
html=[html 'skinColor' headers.Content.skinColor.ContentData ' <br><br>'];
html=[html 'eyesColor' headers.Content.eyesColor.ContentData ' <br><br>'];
html=[html 'mouthColor' headers.Content.mouthColor.ContentData ' <br><br>'];
html=[html 'objet' headers.Content.objet.ContentData ' <br><br>'];
html=[html 'deform_eye' headers.Content.deform_eye.ContentData ' <br><br>'];
html=[html 'deform_mouth' headers.Content.deform_mouth.ContentData ' <br><br>'];
html=[html 'deform_nose' headers.Content.deform_nose.ContentData ' <br><br>'];
html=[html 'Your image<br><img src="../' filename_in_html '" alt="Uploaded image"/> <br>'];
html=[html '<br><br>'];
html=[html '<img src="../' filename_out_html '" alt="Uploaded image"/> <br>'];
html=[html 'Blurred Grey scale version of your image <br>'];
html=[html '</body></html>'];
