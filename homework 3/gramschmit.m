function [Q,R] = gramschmit(A)

[m, n] = size(A);
R = zeros(n);
% set R to be negative as to be the same as qrfactor.m and qr() in matlab
% the first r value is the unit vector of a_1
R(1,1) = -norm(A(:,1));
% this was to get the q_1, which is the first q value based on the r_11 and
% a_1
Q(:,1) = A(:,1)/R(1,1); 

for k = 2:n
    R(1:k-1,k) = Q(:,1:k-1)'*A(:,k);
    Q(:,k) = A(:,k) - Q(:,1:k-1)*R(1:k-1,k);
    %Q(:,k) = A(:,k) - R(1:k-1,k);
    R(k,k) = norm(Q(:,k));
    Q(:,k) = Q(:,k)/R(k,k);
end
