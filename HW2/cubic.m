% Ivy Chen | ic2389 | AOE Spring 2016

%Problem
% The function should accept twoinputs.
% The first input is a 1x4 vector called A where A contains the
% values of a, b, c, and d.  The second is the variable x.

function cube = cubic(A, x)
a = A(1,1)
b = A(1,2)
c = A(1,3)
d = A(1,4)

cube = a*x^3 + b*x^2 + c*x + d