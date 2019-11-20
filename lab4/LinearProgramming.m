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
ap_RHS = [ 8
          10
           3 ];
% =======================================================

C = zeros(a_n+1,n+a_n+1);           
C(1,1:n) = kint;
C(2:end,1:n) = ap_LHS;
C(2:end,n+1:n+a_n) = eye(a_n);
C(2:end,end) = ap_RHS;

% last row
lastRow = size(C,1);
% last column
lastCol = size(C,2);

beta = [n+1, n+2, n+3];       
      


while true 
  
disp('C=');
disp(C);
disp('beta=');
disp(beta);

% cl = lowest col number
[lowest,cl] = min(C(1:1,1:n));

if (lowest >= 0)
   disp("STOP");
   return
endif

lambda = [];

for (row = 2:lastRow)
   lambda(end+1) = C(row,lastCol) / C(row, cl);
end

lambda(lambda < 0) = NaN;
[m,k_ind] = (min(lambda));
beta(k_ind) = cl;
base_row = k_ind + 1;

el = C(base_row,cl);
C(base_row, :) = C(base_row, :) ./ el;

for (row = 2:lastRow)
  el = C(row, cl);
  if (el ~= 0)
    C(row, :) = C(row, :) ./ el;
    if (row ~= base_row)
      C(row, :) = C(row, :) - C(base_row, :);
    endif
  endif
endfor

C(1, :) = C(1, :) - C(base_row, :) .* lowest;

endwhile



endfunction



