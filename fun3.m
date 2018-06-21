function [ retval ] = fun3( x )
    retval = -20 * exp( -0.2 * sqrt( 0.2 * sum( x.^2 ) ) )-exp( 0.2 * cos(2 * pi * x  )) + 20 + exp(1);
end

