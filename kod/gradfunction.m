function Return = gradfunction(functname,x)
hstep = 0.001;
n = length(x);
f = feval(functname,x);
gradx = zeros(n,1)';
for i = 1:n
   xs = x;
   xs(i) = xs(i) + hstep;
   gradx(i)= (feval(functname,xs) -f)/hstep;
end
Return = gradx;