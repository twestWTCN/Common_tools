function [r,lags] = my_xcorr(x1,x2,lags)
% lags = -256:1:256;
for i = 1:numel(lags)
    ra = corrcoef(x1,circshift(x2,lags(i)));
    r(i) = ra(2);
end