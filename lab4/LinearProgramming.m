function LinearProgramming
% veikia tik kai apribojimai yra "<="

% ============ vartotojo ivedami duomenys ==============
% kintamuju skaicius
n = 4;
% koeficientai salia kintamuju
kint = [2, -3, 0, -5];
% apribojimu skaicius
a_n = 3;
% apribojimu kairiosios puses
ap_LHS = [-1  1 -1 -1  
           2  4  0  0  
           0  0  1  1];
% apribojimu desiniosios puses
ap_RHS = [ 1
           4
           7 ];
% =======================================================

M = zeros(a_n+1,n+a_n+1);           
M(1,1:n) = kint;
M(2:end,1:n) = ap_LHS;
M(2:end,n+1:n+a_n) = eye(a_n);
M(2:end,end) = ap_RHS;

% last row
lastRow = size(M,1);
% last column
lastCol = size(M,2);

beta = [n+1, n+2, n+3];       
      
while true 
  
format short g;
  
disp('M=');
disp(M);
disp('beta=');
disp(beta);

% cl = lowest col number
[lowest,cl] = min(M(1:1,1:n));

if (lowest >= 0)
   break
endif

lambda = [];

for (row = 2:lastRow)
   lambda(end+1) = M(row,lastCol) ./ M(row, cl);
end

lambda(lambda < 0) = NaN;
[m,k_ind] = (min(lambda));
beta(k_ind) = cl;
base_row = k_ind + 1;

el = M(base_row,cl);
M(base_row, :) = M(base_row, :) ./ el;

for (row = 2:lastRow)
  el = M(row, cl);
  if (el ~= 0)
    M(row, :) = M(row, :) ./ el;
    if (row ~= base_row)
      M(row, :) = M(row, :) - M(base_row, :);
    endif
  endif
endfor

M(1, :) = M(1, :) - M(base_row, :) .* lowest;
endwhile

RES = [0,0,0,0,0,0,0];
B=M(2:lastRow,lastCol)
RES(beta) = B

X = RES(1:n);
S = RES(n+1:end);
Fmin = -M(1,lastCol);

disp("X=");
disp(X);
disp("S=");
disp(S);
disp("Fmin=");
disp(Fmin);

endfunction



