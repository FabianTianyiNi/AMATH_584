x = 5:400;
cnm = zeros(1,0);
cnm_2 = zeros(1,0);
for k = 5:400
    matrix = randn(k.^2, k);
    condition_number = cond(matrix);
    cnm = [cnm condition_number];
    
    col = matrix(:,1);
    matrix_2 = [matrix col];
    condition_number_2 = cond(matrix_2);
    cnm_2 = [cnm_2 condition_number_2];
end

cnm_2 = cnm_2 * (10.^(-15));
plot(x, cnm, x, cnm_2);
xlabel('The value of n from 5 to 400');
ylabel('The condition number of the matrix (m=n^2,n)')
hold on