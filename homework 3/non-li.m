x = 5:300;
cnm = zeros(1,0);
for k = 5:300
    matrix = randn(k.^2, k);
    condition_number = cond(matrix);
    cnm = [cnm condition_number];
end

plot(x, cnm, '-');
ylim([0 10]);
xlabel('The value of n from 5 to 300');
ylabel('The condition number of the matrix (m=n^2,n)')
hold on