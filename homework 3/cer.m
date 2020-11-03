clear('xlabel')
clear('ylabel')
A = randn(100,99);
col = A(:,1);
epsi = 1:0.1:10;
cn_list = zeros(1,0);
rand_v = randn(400, 1);
for k = 1:0.1:10
    col = col + k*rand;
    new_A = [A col];
    condition_number = cond(new_A);
    % condition_number = condition_number * (10.^(-15));
    cn_list = [cn_list condition_number];
    col = A(:,1);
end
plot(epsi, cn_list);
xlabel('The value of epsilon');
ylabel('The condition number');
hold on