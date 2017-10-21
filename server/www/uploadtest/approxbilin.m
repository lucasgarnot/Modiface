function v = approxbilin(image,y,x)
% Amale
ex = floor(x);
dx = x - floor(x);
ey = floor(y);
dy = y - floor(y);

[lignes,colonnes,canaux]=size(image);

% if(ex<lignes -1 && ey<colonnes-1)
    v00 =image(ey,ex);
    v01= image(ey,ex+1);
    v10 =image(ey+1,ex);
    v11 =image(ey+1,ex+1);
% end
v = (1-dx)*(1-dy)*double(v00) +dx*(1-dy)*double(v10)+(1-dx)*dy*double(v01)+dx*dy*double(v11);
end

