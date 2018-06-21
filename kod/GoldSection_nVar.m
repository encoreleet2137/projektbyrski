function [ReturnValue, nIters, gVals] = GoldSection_nVar(functname,tol,x,s,lowbound,intvl,ntrials)
format compact;
nIters = 0;
gVals = [];
upval = UpperBound_nVar(functname,x,s,lowbound,intvl,ntrials);
au=upval(1);
if (au <= 1.0e-06)
   aL = lowbound;  xL = x + aL*s;  
   faL =feval(functname,xL);
   ReturnValue =[aL faL x];
   gVals = [aL faL x];
   return
end
if (tol == 0) 
    tol = 0.0001;
end
eps1 = tol/(au - lowbound);
tau = 0.38197;
nmax = round(-2.078*log(eps1));
aL = lowbound;              
a1 = (1-tau)*aL + tau*au;   x1 = x + a1*s; fa1 = feval(functname,x1);
a2 = tau*aL + (1 - tau)*au; x2 = x + a2*s; fa2 = feval(functname,x2);
for i = 1:nmax
    nIters = nIters + 1;
	if fa1 >= fa2
        aL = a1;
        a1 = a2;	fa1 = fa2;
        a2 = tau*aL + (1 - tau)*au;	x2 = x + a2*s; 
        fa2 = feval(functname,x2);
        gVals = [gVals; x2 fa2];
    else
        au = a2;
        a2 = a1;	fa2 = fa1;
        a1 = (1-tau)*aL + tau*au;	x1 = x + a1*s; 
        fa1 = feval(functname,x1);
        gVals = [gVals; x1 fa1];
	end
end
ReturnValue =[a1 fa1 x1];