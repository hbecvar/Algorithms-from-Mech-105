function [L,U,P]= luFactor(A)
%The function decomposes matrix A into a Lower Triagular Matrix and a Upper
%Triagular Matrix using LU Factorization with pivoting. LU Factorization is
%used to solve linear equations given the coefficients of the equations.
%
%input:
%A = coefficient matrix for linear equations
%
%Outputs:
%L = lower trigular matrix
%U = upper triangular matrix
%P = pivot matrix

clc                   %clear command window

[R,C]=size(A);        %store row and column length of A

if R~=C
    error('Must input a SQUARE coefficient matrix') %must give a square matrix
end

P=eye(R);             %create the initial pivot matrix (identity matrix)
L=eye(R);             %create the intial lower triangular matrix

for i=1:R-1        %column counter variable
    numb_loop=0;   %Counter for number of loops, only want one loop inside if statement
                   %b/c one pivot max per column
    
    for j=1:R      %row counter variable
        
        if abs(A(j,i))==max(abs(A(i:R,i))) && numb_loop==0   %determine which row absolute max occurs
            A_temp=A(i,:);   %Stores initial row
            A(i,:)=A(j,:);   %These three lines of code pivot the A matrix
            A(j,:)=A_temp;
            
            P_temp=P(i,:);
            P(i,:)=P(j,:);    %Pivot the pivoting matrix
            P(j,:)=P_temp;
            
            if i>1
              L_temp=L(i,i-1);     %Since elimination doesn't occur until after the first
              L(i,i-1)=L(j,i-1);   %pivot an additional for loop is required
              L(j,i-1)=L_temp;
            end
            
            for k=i:C-1    % Elimination occurs here, need an additional for loop b/c
                           % for loop needs to be inside the if statement
                
                elim_factor=A(k+1,i)/A(i,i);          %Calculate the elimination constant
                A(k+1,:)=A(k+1,:)-elim_factor*A(i,:); %Subtract the rows
                L(k+1,i)=elim_factor;                 %Store factor in L matrix
            end
            
        end
    end
end
L
U=A    %Display results, the new A is U
P
end





            
