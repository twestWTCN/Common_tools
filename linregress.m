function [yCalc b Rsq] = linregress(X,Y)
        X = [ones(length(X),1) X];
        b = X\Y;
        yCalc = X*b;
        Rsq = 1 - sum((Y - yCalc).^2)/sum((Y - mean(Y)).^2);
