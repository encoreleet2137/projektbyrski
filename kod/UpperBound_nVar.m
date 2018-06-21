function ReturnValue = UpperBound_nVar(functname,x,s,a0,da,ns)
format compact
if (ns ~= 0) 
    ntrials = ns;
else ntrials = 10;
end
if (da ~= 0) 
    das = da;
else
    das = 1;
end
for i = 1:ntrials;
   j = 0;	dela = j*das;	a00 = a0 + dela;  
   dx0 = a00*s;	x0 = x + dx0;  f0 = feval(functname,x0);
   j = j+1;	dela = j*das;	a01 = a0 + dela;
   dx1 = a01*s;	x1 = x + dx1;	f1 = feval(functname,x1);
   f1s = f1;
   if f1 < f0 
         for j = 2:ntrials
         	a01 = a0 + j*das;		dx1 = a01*s;	
            x1 = x + dx1;		f1 = feval(functname,x1);
            f1s = min(f1s,f1);
            if f1 > f1s 
      			ReturnValue = [a01 f1 x1];
               return;
            end
         end
         fprintf('\nCannot increase function in ntrials')
      	ReturnValue = [a01 f1 x1];
         return;         
   else	f1 >= f0;
      das = 0.5*das;
   end
end
ReturnValue =[a0 f0 x0];