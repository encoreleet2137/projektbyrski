function [ retval ] = fun2( x )
    retval = (x(1)^3 + 2 * x(2)^3) * exp( 1 - x(1)^2 - x(2)^2 ) ;
end

