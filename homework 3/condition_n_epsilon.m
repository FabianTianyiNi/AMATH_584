A = randn(400,100);

col = A(:,1);

eps = (-2:0.001:2);

cn_list = zeros(1,0);

for k = -2:0.001:2
    col = col * k;
    new_A = [A col];
    condition_number = cond(new_A);
    cn_list = [cn_list condition_number];
end

plot(eps, cn_list);
hold on