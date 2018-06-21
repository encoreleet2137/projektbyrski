function [ retval ] = fun2( x )
    retval = (x(1)^3 + 2 * x(2)^3) * exp( 1 - sum(-1 * x.^2) ) ;
end

