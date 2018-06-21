function [value, goldenValues ] = executeDFP( inputFun, x, boundaries )
    [value, goldenValues] = DFP(inputFun,x,boundaries,20, 0.0001, 0,1 ,20)
end

