function [skinmask] = skinMask (im)
%Mariem

[a,b,c] = size(im);
canalR = im(:,:,1); %canal rouge
canalV = im(:,:,2); %canal vert
canalB = im(:,:,3); %canal bleu

cond1 = log(double(canalR)./double(canalV))>= 0.15 & log(double(canalR)./double(canalV)) <= 1.1;
cond2 = log(double(canalB)./double(canalV))>= -4   & log(double(canalB)./double(canalV)) <= 0.3;

mask = cond1 & cond2;
se = strel ('disk',floor(sqrt(a*b)/100));
s1 = imdilate (mask,se);
s2 = imerode (s1,se);

[l,num]= bwlabel(s2,8);
s_mat = regionprops(l,'area');
areas = cat(1, s_mat.Area);
valmax= max(areas);
valmaxindex= find(areas==valmax);
skinmask=(l==valmaxindex);
s_mat2 = regionprops(skinmask,'centroid');
Centroid = cat(1,s_mat2.Centroid);
center= Centroid;

% figure(33);
% imagesc(skinmask);
end