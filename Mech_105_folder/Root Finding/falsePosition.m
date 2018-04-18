function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
%Function calculates roots using False Position Method. False Position
%method uses a linear line to estimate root
%Input:
%   func = name of function 
%   xl = lower guess
%   xu = upper guesses
%   es = desired relative error (default = 0.0001%)
%   maxiter = the max number of iterations desired (should default to 200 for a max)
%
% output:
%   root = real root
%   fx = function value at root
%   ea = approximate relative error (%)
%   iter = number of iterations

if nargin < 3 %check if they had sufficient inputs
    error('Need 3 inputs at a minimum')
end
if nargin < 4 %if only 3, must default es and maxiter
    es=.0001;
    maxiter=200;
end
if nargin < 5 %only 4, default maxiter
    maxiter=200;
end
iter=0; xr=xl; ea=100; %define variables to allow the while loop to start

while ea >= es && iter < maxiter; %criteria for loop
    xrold=xr; %save root estimate to old root for estimation calculation
    iter=iter+1; %count iterations
   
    xr=xu-(func(xu)*(xl-xu))/(func(xl)-func(xu)); %formula for false position
    
    ea = abs((xr - xrold)/xr) * 100; % calculate approximate error
    
    test=func(xr)*func(xl); %sign change test
   
    if test < 0 % sign change occured
        xu=xr;
    elseif test > 0 %no sign change
        xl=xr;
    else
        ea=0; %That means that you either guessed the root or xr is the root
    end
end
root=xr; % set function ouputs and print results
fx = func(xr);
fprintf('The root is %f\n',root)
fprintf('The relative error is %f percent. \n', ea)
fprintf('It took %d iterations.\n',iter)
fprintf('The functional value is %f\n',fx)

end
        
        
        
    


