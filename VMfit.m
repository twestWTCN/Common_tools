function [xq yq R2 exitflag s] = VMfit(x,y,xn,lb,ub,plotop)
x = x(~isnan(y)); y = y(~isnan(y));
% b(1) - concentration
% b(2) - mu - circular mean?
% b(3) - y scaling
% b(4) - yshift
fit = @(b,x)  b(3)*(1/(2*pi*besseli(0,b(1)))) * exp(b(1)*cos(x-b(2))) + b(4);    % Function to fit
fcn = @(b) sum((fit(b,x) - y).^2);                              % Least-Squares cost function

options = optimset('MaxFunEvals',1e8);
[s,fval,exitflag,output] = fminsearchcon(fcn, [0,0,1,0],lb,ub,[],[],[],options)       ;                % Minimise Least-Squares
yfit = fit(s,x);
xq = linspace(min(x),max(x),xn);
yq = fit(s,xq);

if plotop == 1
    plot(x,y,'b',  xq,yq, 'r')
    grid
end
SSres = (y-yfit).^2;
SStot = (y-mean(y)).^2; % total sum of squares (variance)
R2 = sum(SSres)/sum(SStot);

if exitflag == 0
    s = nan(size(s));
end


