function [ReturnValue, goldenValues] = DFP(functname,dvar0, bounds,niter,tol,lowbound,intvl,ntrials)
clf
e3 = 1.0e-04;  
nvar = length(dvar0);
if (nvar == 2)
	x1 = bounds(1):0.1:bounds(2);
	x2 = bounds(1):0.1:bounds(2);

	x1len = length(x1);
	x2len = length(x2);
    fun = zeros(x1len, x2len);
	for i = 1:x1len;
        for j = 1:x2len;
            x1x2 =[x1(i) x2(j)];
            fun(j,i) = feval(functname,x1x2);
        end
    end
	contour(x1,x2,fun,[3.1 3.25 3.5 4 6 10 15 20 25],'k');
	grid
	xlabel('x_1')
   ylabel('x_2')
   fname = strrep(functname,'_','-');
	title(strcat('Davidon-Fletcher-Powell (DFP): ',fname))
end
xs(1,:) = dvar0;
x = dvar0;
Lc = 'r';
fs = zeros(niter);
fs(1) = feval(functname,x);
grad = (gradfunction(functname,x));
A = eye(nvar);
goldenIterations = 0;
goldenValues = [];
mainIterations = 0;
convg = zeros(niter);
convg(1)=grad*grad';
for i = 1:niter-1
   mainIterations = mainIterations + 1;
   fprintf('iteration number:  '),disp(i)
   s = (-A*grad')'; 
   [output, nIters, gValues] = GoldSection_nVar(functname,tol,x,s,lowbound,intvl,ntrials);
   goldenIterations = goldenIterations + nIters;
   goldenValues = [goldenValues; gValues];
   as(i+1) = output(1);
   fs(i+1) = output(2);
   for k = 1:nvar
      xs(i+1,k)=output(2+k);
      x(k)=output(2+k);
   end
   grad= (gradfunction(functname,x));
   convg(i+1)=grad*grad';
   fprintf('gradient length squared:  '),disp(convg(i+1));
	fprintf('objective function value:  '),disp(fs(i+1));
   if (nvar == 2)
       line([xs(i,1) xs(i+1,1)],[xs(i,2) xs(i+1,2)],'LineWidth',2,'Color',Lc)
       if strcmp(Lc,'r') 
             Lc = 'k';
       else
             Lc = 'r';
       end
       pause(1)  
    end

if(convg(i+1)<= e3) 
    break;
end;
delx = (x - xs(i,:))';
Y = (grad -gradfunction(functname,xs(i,:)))';
Z = A*Y;
B = (delx*delx')/(delx'*Y);
C = -(Z*Z')/(Y'*Z);
A = A + B + C;
end
len=length(as);
designvar=xs(length(as),:);
mainIterations
goldenIterations
designvar
fs(len)
ReturnValue = [designvar fs(len)];