function [x0, y0, score] = runGradientDescent(func, fx, fy, alpha, delay)
    % fx and fy are the partial derivatives of the function
    % It is also possible to compute them using the symbolic toolbox to
    % make the function more generic, but we chose to hardcode them because
    % the code runs much faster
    
    if nargin < 5
        delay = .2;
    end
    
    epsilon = 1E-6;
    maxIter = 1 * 1000 * 1000;
    i = 0;
    x0 = rand() * 20 - 10;
    y0 = rand() * 20 - 10;
    
%     x0 = rand() - 0.5;
%     y0 = rand() - 0.5;
        
    sprintf('Starting at %d, %d function value: %d ', x0, y0, func(x0,y0))
    
    plotGradientDescent(x0, y0, func);
        
    while (func(x0, y0)) > epsilon && i < maxIter
        i = i + 1;
        gx = fx(x0, y0);
        gy = fy(x0, y0);
        x0 = x0 - alpha * gx;
        y0 = y0 - alpha * gy;
        if mod(i,10000) == 0
            sprintf('Current value %d, %d function value: %d ', x0, y0, func(x0,y0))
            if delay > 0 % Skip plotting if delay is 0 to speed up experiments
                plotGradientDescent(x0, y0, func);
                pause(delay);
            end
            
        end;
    end
    score = func(x0,y0);
    plotGradientDescent(x0, y0, func);
    sprintf('Finished at %d, %d function value: %d ', x0, y0, func(x0,y0))
end

function [] = plotGradientDescent(x0, y0, func)
    hold off;
    limits = [-10,10];
    ezsurf(func, limits);
    hold on;
    plot3(x0,y0,func(x0,y0),'r.','MarkerSize',20);
    % cameratoolbar;
    % cameratoolbar('SetMode','orbit');
    rotate3d on;
    view(15,60);
end