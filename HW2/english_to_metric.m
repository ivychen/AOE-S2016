% Ivy Chen | ic2389 | AOE Spring 2016

% Create a function english_to_metric in (english_to_metric.m) that can
% convert gallons to liters, pounds to kilograms, Fahrenheit to Celsius,
% and yards to meters. Your function should take two inputs x and y. x
% will be a flag that tells the function what you are trying to convert
% to (let ‘L’ = convert to Liters, ‘Kg’ = convert to kilograms, ‘C’ =
% convert to Celsius, and ‘M’ = convert to meters) and y is the value
% that needs to be converted. Your function should have one output, the
% converted value. Your function should display a message if the user
% inputs a letter that is not one of the recognized flags and return the
% empty matrix ( [] ).

function metrify = english_to_metric(x, y)
if strcmp(x,'L') == 1
    metrify = 3.785411784*y;
elseif strcmp(x,'Kg') == 1
    metrify = .4535923*y;
elseif strcmp(x,'C') == 1
    metrify = f2c(y);
elseif strcmp(x,'M') == 1
    metrify = .9144*y;
else
    display('Please input correct flag.');
    metrify = [];
end