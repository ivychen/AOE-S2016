diary hw2diary.txt

% Ivy Chen | ic2389 | AOE Spring 2016

%Problem 1
A = [16 4 3 0;9 20 5 1;34 16 7 8]

B = [23 1 0 5;9 8 16 7;34 12 3 2]

c = [A(3,3)];

D = [A(:,4)]

E = [B(1:2:3,:)]

F = [A;B]

%The lone colon means it is iterating through every column
G = [A(2:3,:)]

%Problem 2
P1 = [1,2,3,4];
P2 = [2 5 9 6];
x1 = 1;
cubic(P2, x1)
cubic(P1, x1)

%Problem 3
prompt = 'Enter a number:';
x = input(prompt)

if 0 < x < 100
    y = x - 30
elseif x > 100
    y = .20*x + 800
else
    y = -50
end

if x < 0
    z = -1
elseif x == 0
    z = 0
else
    z = 1
end

%Problem 4
z = english_to_metric('L', 64)

z = english_to_metric('Kg', 100)

z = english_to_metric('C', 32)

z = english_to_metric('M', 1)

z = english_to_metric('D', 50)

%Problem 5
h = heat_wave([78,77,80,81,83,82,84,85,90,90,91,92,97,96,99,97,101,99,98,99,96,97,94,90,89,87,88,82,80,78])

%Problem 6
s = my_search([78,77,80,81,83,82,84,85,90,90,91,92,97,96,99,97,101,99,98,99,96,97,94,90,89,87,88,82,80,78],78)

diary off