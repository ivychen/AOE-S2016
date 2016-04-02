% Ivy Chen | ic2389 | AOE Spring 2016

% The meteorologist needs to know when heat waves occur. He defines heat
% waves as periods of time where the maximum temperature exceeds 90
% degrees Fahrenheit for more than 7 continuous days.  Create a
% function, heat_wave (in the file heat_wave.m), that utilizes a while
% loop to count how many heat wave events occur in addition to the total
% number of days that were part of a heat wave. This function should
% take in a 1-by-n matrix, D, of temperature data (where n can be any
% positive integer) as its input.  The function should output a two
% element matrix, were the first element reflects the number of heat
% wave events that occurred within the data set and the second the
% number of total days that were part of any heat wave.

function heat = heat_wave(D)
[rows,cols] = size(D);
numHeatWaves = 0;
numDays = 0;

col = 1;
while col < cols
    if D(1,col) > 90
        numHeatWaves = numHeatWaves + 1;
    end
    
    while D(1,col) > 90
        numDays = numDays + 1;
        if col + 1 <= cols
            col = col + 1;
        end
    end
    col = col + 1;
end

heat = [numHeatWaves, numDays];