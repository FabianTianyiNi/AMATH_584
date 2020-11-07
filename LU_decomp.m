function [L,U,P] = LU_decomp(A)
% this function will generate three different matrices
% L is the lower matrix
% U is the upper matrix
% P is the matrix used for pivoting

[m,n]=size(A);  U=A;
% first you have check if the matrix is squared, if not stop the program
if m~=n
    Error("The matrix has to be squared");
end
% Assume the lower matrix's diagonal items are one to make sure the
% decomposition is unique, initialize the diagonal matrix
L=eye(n); 
P=L; 

for k=1:m
    % to find the pivot each column and its index in the pivot
    [pivot pivot_index]=max(abs(U(k:n,k)));
    pivot_index=pivot_index+k-1;
    % to check if the maximum value (pivot) is already on the diagonal
    if pivot_index~=k 
        % switch the pivot and kk
        % switch the whole line but not the single number
        u_store=U(k,:);
        %u_store=U(k,k);
        U(k,:)=U(pivot_index,:);
        %U(k,k)=U(pivot_index,k);
        U(pivot_index,:)=u_store;
        %U(pivot_index,k)=u_store;
        p_store=P(k,:);
        P(k,:)=P(pivot_index,:);
        P(pivot_index,:)=p_store;
        if k >= 2
            l_store=L(k,1:k-1);
            L(k,1:k-1)=L(pivot_index,1:k-1);
            L(pivot_index,1:k-1)=l_store;
        end
    end
    % if not do nothing, no switch
    for j=k+1:m
        L(j,k)=U(j,k)/U(k,k); % l_jk = x_jk/x_kk
        U(j,:)=U(j,:)-L(j,k)*U(k,:);
    end
end