function [I2, points] = adaptrap(f, a, b, tol, fa, fb)
%
%
% Syntax: [I2, points] = adaptrap(f, a, b, tol, fa, fb)
%
% Approssimazione dell'integrale definito di f(x) con estremi a e b, 
% mediante la formula adattiva dei trapezi
% 	f- 	funzione 
%	a,b-	estremi intervallo
%	tol-	tolleranza
%	fa,fb-	valore della funzione valutata negli punti a,b
%		
%	points-	punti valutati
%	I2-	valore dell'integrale di f(x)
% 
global points
delta = 0.5;
if nargin<=4
    fa = feval(f, a );
    fb = feval(f, b );
    if nargout==2
        points = [a fa; b fb];
    else
        points = [];
    end
end
h = b-a;
x1 = (a+b)/2;
f1 = feval(f, x1);
if ~isempty(points)
    points = [points; [x1 f1]];
end
I1 = .5*h*(fa+fb);
I2 = .5*(I1+h*f1);
e = abs(I2-I1)/3;
if e>tol || abs(b-a) > delta
    I2 = adaptrap(f, a, x1, tol/2, fa, f1) + adaptrap(f, x1, b, tol/2, f1, fb);
end
return
end
