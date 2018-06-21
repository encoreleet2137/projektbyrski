function [ retval ] = fun1( x )
    retval = 20 * exp(-0.2 * x(1)) + ( (20)/(20-x(1)) );
end

