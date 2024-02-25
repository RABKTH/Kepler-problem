function [x,y] = fixpunkt(p, q, k, h)
    x = p;
    y = q;
    %k är antalet fixpunktsiterationer
    for j = 1:k
        x = p - h*gradient_q(y);
        y = q + h*gradient_p(x);
    end
end