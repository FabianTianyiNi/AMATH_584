x = 5:1000;
cnm = zeros(1,0);
for k = 5:1000
    matrix = randn(k,4*k+5);
    condition_number = cond(matrix);
    cnm = [cnm condition_number];
end

plot(x, cnm, '-');
ylim([0 10]);
xlabel('The value of x from 5 to 1000');
ylabel('The condition number of the matrix (x, 4*x+5)')
hold on