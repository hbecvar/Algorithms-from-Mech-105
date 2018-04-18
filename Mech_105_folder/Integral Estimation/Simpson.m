function [I] = Simpson(x,y)
%The function estimates the integral of a data set using Simpson's 1/3
%rule.
%If there is an odd number of intervals, the last interval integral is
%estimated with the trapizoid rule
%inputs:
%x = equally spaced x-values of integral 
%y = outputs of data set at x-values
%Outputs:
% I = estimate of the integral

if length(x) ~= length(y)  %make sure they have the same number of x and y values
    error('Your x and y data sets must have equal lengths')
end

for i=1:length(x)-2  %check for equal spacing
    change_x=x(i)-x(i+1);  %calculate first interval change in x
    change_x_int2=x(i+1)-x(i+2); %calculate next interval cahnge in x
    if change_x~=change_x_int2 %test if the changes in x are equal
        error('You must have equally spaced x values') %error if not equally spaced
    end
end

numb_intervals=length(x)-1; %number of intervals
remainder=mod(numb_intervals,2); %if no remainder, there is an even number of intervals
sum_xi=0;
sum_xj=0;

if remainder==0 %even number intervals
    for i=2:2:length(x)-1 %summation for 1/3 Composite rule
        sum_xi=sum_xi+y(i); %sum middle terms in rule
    end
    for i=3:2:length(x)-2 
        sum_xj=sum_xj+y(i); %sum overlapping repeat terms
    end
    I=(x(length(x))-x(1))*(y(1)+4*sum_xi+2*sum_xj+y(length(y)))/(3*numb_intervals);
else %odd number of intervals
    warning('You have an odd number of intervals. The trapizoid rule was used on the last interval')
    for i=2:2:length(x)-2
        sum_xi=sum_xi+y(i); %must adjust rule so it doesn't sum last interval
    end
    for i=3:2:length(x)-2
        sum_xj=sum_xj+y(i); 
    end
    trapizoid= (x(length(x))-x(length(x)-1))*(y(length(y)-1)+y(length(y)))/2;
    %Must adjest formula due to addition trapizoid as well as the bounds
    %for the Simpson Rule
    I=(x(length(x)-1)-x(1))*(y(1)+4*sum_xi+2*sum_xj+y(length(y)-1))/(3*(numb_intervals-1))+trapizoid;
end
end


        

