diary hw1diary.txt

% Ivy Chen | ic2389 | AOE Spring 2016

%Problem 1
r = 25;

diameter = 2 * r;
circumference = 2 * pi * r;
area = pi * r.^2;

display(diameter);
display(circumference);
display(area);

%Problem 2
help rand;

rand1 = rand;
rand2 = rand;
rand3 = rand;

display(rand1);
display(rand2);
display(rand3);

%Problem 3
a = 1;
b = 0;
c = -9;

plus_root = (-b + sqrt(b.^2 - 4*a*c)/(2*a));
minus_root = (-b - sqrt(b.^2 - 4*a*c)/(2*a));

display(plus_root);
display(minus_root);

%Problem 4
f1 = 0;
f2 = 70;
f3 = -50;
X1 = [num2str(f1), ' degrees Farenheit to Celcius: ', num2str(f2c(f1))];
X2 = [num2str(f2), ' degrees Farenheit to Celcius: ', num2str(f2c(f2))];
X3 = [num2str(f3), ' degrees Farenheit to Celcius: ', num2str(f2c(f3))];
disp(X1);
disp(X2);
disp(X3);

%Problem 5
g1 = 0;
g2 = 30;
g3 = -5;
Y1 = [num2str(g1), ' degrees Celcius to Farenheit: ', num2str(c2f(g1))];
Y2 = [num2str(g2), ' degrees Celcius to Farenheit: ', num2str(c2f(g2))];
Y3 = [num2str(g3), ' degrees Celcius to Farenheit: ', num2str(c2f(g3))];
disp(Y1);
disp(Y2);
disp(Y3);

%Problem 6
h1 = 0;
h2 = 67;
h3 = -33;
Z1 = [num2str(h1), ' degrees Farenheit to Kelvin: ', num2str(f2k(h1))];
Z2 = [num2str(h2), ' degrees Farenheit to Kelvin: ', num2str(f2k(h2))];
Z3 = [num2str(h3), ' degrees Farenheit to Kelvin: ', num2str(f2k(h3))];
disp(Z1);
disp(Z2);
disp(Z3);

diary off