function h = signoid( x )
% Amale

f = 1/(1+exp(-2*(2*x-1)));
f0 = 1/(1+exp(2));
f1 = 1/(1+exp(-2));
h = (f-f0)/(f1-f0);


end

