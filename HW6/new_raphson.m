%Newton Raphson slider crank

sc_ini

% t_end = 0.01; %sec

iterations = 5;


for i=1:iterations
    
    sc_phi
    
    fprintf('iteration number %i \n',i)
    
    grad = JAC\PHI;
    
    q = q - grad;
    
    
end

q