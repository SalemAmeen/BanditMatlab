function [ W1,W2 ] = cut( W1,W2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
W=W1(:,1:5); % input diminstion + 1
for i=1:20
    Wcol=W(i,:);
    if Wcol==0
        W2(1,i)=0;
        %fprintf('1\n')

%else
%fprintf('2\n')
    end
end
end

