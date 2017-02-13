function [x0, y0] = runGradientDescent(func, fx, fy, alpha)
    % fx and fy are the partial derivatives of the function
    % It is also possible to compute them using the symbolic toolbox to
    % make the function more generic, but we chose to hardcode them because
    % the code runs much faster
    
    epsilon = 1E-6;
    maxIter = 1 * 1000 * 1000;
    i = 0;
    x0 = rand() * 10;
    y0 = rand() * 10;
        
    sprintf('Starting at %d, %d function value: %d ', x0, y0, func(x0,y0))
        
    % while abs(eval(func(x0, y0))) > epsilon && (i < maxIter)
    while ((func(x0, y0))) > epsilon && i < maxIter
        i = i + 1;
        gx = fx(x0, y0);
        gy = fy(x0, y0);
        x0 = x0 - alpha * gx;
        y0 = y0 - alpha * gy;
        if mod(i,10000) == 0
            sprintf('Current value %d, %d function value: %d ', x0, y0, func(x0,y0))
        end;
    end
    sprintf('Finished at %d, %d function value: %d ', x0, y0, func(x0,y0))
end