% Ivy Chen | ic2389 | AOE Spring 2016

function search = my_search(array, k)
[rows,cols] = size(array);
temp = [];

for row = 1:rows
    for col = 1:cols
        if k == array(row,col)
            temp = [row, col];
        end
    end
end

search = temp;