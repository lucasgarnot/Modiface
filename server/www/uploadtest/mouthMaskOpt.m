function [maskOptimised,xmin,ymin]= mouthMaskOpt (im,mouthmask,listPixels) 
  % Mariem

  % listPixels de la bouche (en sortie de extractMouth) 
  %les coordonnées du centre de gravité
                                                                
  % listPixels de la bouche : détermination des coordonnées max et min                                     
  xmin=min(listPixels(:,1));
  xmax= max(listPixels(:,1));
  ymin= min(listPixels(:,2));
  ymax= max(listPixels(:,2));
  
  imcropped = im(ymin:ymax, xmin:xmax , :);
  
  %  figure();
  %  imshow(imcropped);
  imFond = imcropped(1:10, 1:10,:);
  imFondcropped = reshape(imFond,100,3);
  
  %INIT
  m1 = moyMask(mouthmask(:,:,1),im);
  m2 = mean(imFondcropped);
  
  m1current= ones(size(imcropped)); % bouche
  m1current(:,:,1)= double(m1(:,1));
  m1current(:,:,2)= double(m1(:,2));
  m1current(:,:,3)= double(m1(:,3));
  
  m2current = ones(size(imcropped));% peau
  m2current(:,:,1)= double(m2(:,1)); 
  m2current(:,:,2)= double(m2(:,2));
  m2current(:,:,3)= double(m2(:,3));

  m1previous=ones(size(m1current));
  m2previous=ones(size(m2current));
  
  while (m1current ~= m1previous) & (m2current ~= m2previous)
    
      %distance par rapport à la bouche
      
      imdistbouche(:,:,1) = (double(imcropped(:,:,1)) - double(m1current(:,:,1)) ).^2;
      imdistbouche(:,:,2) = (double(imcropped(:,:,2)) - double(m1current(:,:,2)) ).^2;
      imdistbouche(:,:,3) = (double(imcropped(:,:,3)) - double(m1current(:,:,3)) ).^2;
      imdistfinBouche= sqrt ( ( imdistbouche(:,:,1) + imdistbouche(:,:,2) +imdistbouche(:,:,3)) );


      % distance par rapport à la peau
     
      imdistpeau(:,:,1) = (double(imcropped(:,:,1)) - double(m2current(:,:,1)) ).^2;
      imdistpeau(:,:,2) = (double(imcropped(:,:,2)) - double(m2current(:,:,2)) ).^2;
      imdistpeau(:,:,3) = (double(imcropped(:,:,3)) - double(m2current(:,:,3)) ).^2;
      imdistfinPeau= sqrt ( ( imdistpeau(:,:,1) + imdistpeau(:,:,2) +imdistpeau(:,:,3)) );
  
      %masque des deux résultats
      
      maskpeau = imdistfinPeau < imdistfinBouche;
      maskbouche = imdistfinBouche < imdistfinPeau;
      
      % mettre la valeur précédente dans m1previous et m2previous
     
      m1previous = m1current;
      m2previous = m2current;
      
      %Recalculer les points de départ 
     
      m1 = moyMask(maskbouche,imcropped); % moymask = fonction qui calcule la moyenne sur chaque canal
      m2 = moyMask (maskpeau,imcropped);
      
      % bouche
      
      m1current(:,:,1)= double(m1(:,1));
      m1current(:,:,2)= double(m1(:,2));
      m1current(:,:,3)= double(m1(:,3));

      % peau
      
      m2current(:,:,1)= double(m2(:,1)); 
      m2current(:,:,2)= double(m2(:,2));
      m2current(:,:,3)= double(m2(:,3));
  
  end
  
%   figure();
  m = imerode(imdilate(maskbouche,strel('disk',5)),strel('disk',5)) ;
%   imagesc(m);
%   colormap(gray);
  
%   figure();
  maskfinal(:,:,1) = m;
  maskfinal(:,:,2) = m;
  maskfinal(:,:,3) = m;
  maskOptimised = (double(maskfinal) .*(double(imcropped)))/255;
%   imshow( maskOptimised);
 
end
  