function [xq yq R2 exitflag] = sinfit(x,y,xn,lb,ub,plotop)
x = x(~isnan(y)); y = y(~isnan(y));
yu = max(y);
yl = min(y);
yr = (yu-yl);                               % Range of �y�
yz = y-yu+(yr/2);
zx = x(yz .* circshift(yz,[0 1]) <= 0);     % Find zero-crossings
per = 2*mean(diff(zx));                     % Estimate period
ym = mean(y);                               % Estimate offset
fit = @(b,x)  b(1).*(sin(2*pi*x./b(2) + 2*pi/b(3))) + b(4);    % Function to fit
fcn = @(b) sum((fit(b,x) - y).^2);                              % Least-Squares cost function
options = optimset('MaxFunEvals',1e6);
[s,fval,exitflag,output] = fminsearchcon(fcn, [yr;  per;  -1;  ym],lb,ub,[],[],[],options)       ;                % Minimise Least-Squares
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


