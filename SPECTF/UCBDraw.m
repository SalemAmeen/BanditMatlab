function [ Acc, AccRWD, UCB1Stime] = UCBDraw(  )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
clear all;
clc;
close all;

%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);
  
%drawnet(W1,W2,eps,{'x'},{'y'})

  weight=W1;
%%
[r,c]=size(W1);
    SizeOfWeight=r*c;  
    %SizeOfWeight=1;
 AccRWD=zeros(SizeOfWeight,1);


 %%
playTimes=10000;
Reward=zeros(SizeOfWeight,1); % m is the Reward
Value=zeros(SizeOfWeight,1); % Value is the total pulled armed
mean=zeros(SizeOfWeight,1); % mean is the mean of pulled armed

%% UCB1 needs to run at least every arm once 
% so will run on sample of the dataset over 20
 
for i=1:SizeOfWeight
     
    temp=weight(i);
    weight(i)=0;
    
    [Yhat,E,NSSE_te2UCB1] = nneval(NetDef,weight,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2UCB1);
    
   delta = NSSE_te2 - NSSE_te2UCB1 ; 
      rwd=max(0,0.1+delta);
           %Reward(i)=Reward(i)+rwd;

      
          Value(i)=Value(i)+1;
               mean(i)=mean(i)+1/playTimes;
     weight(i)=temp;   
end

totalAction=SizeOfWeight;

  weight=W1;

tic
for j=1:playTimes
    [idxW]=banditUCB1(Reward,Value,totalAction);
    
    
    
    temp=weight(idxW);
    weight(idxW)=0;
   
    [Yhat,E,NSSE_te2UCB1] = nneval(NetDef,weight,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2UCB1);
    
    delta = NSSE_te2 - NSSE_te2UCB1 ; 
      rwd=max(0,0.1+delta);
     %%
      % Compute accumlative rewards
      if j>1
               AccRWD(j)=rwd+AccRWD(j-1);
      else
                AccRWD(j)=rwd;
      end
  %%     
     Reward(idxW)=Reward(idxW)+rwd;
          Value(idxW)=Value(idxW)+1;
               mean(idxW)=mean(idxW)+1/playTimes;


     weight(idxW)=temp;
     
totalAction= totalAction + 1;
end

UCB1Stime = toc

RewardBuck=Reward;
SizeOfRemovedWeights=sum(RewardBuck(:)>0);
for j=1:SizeOfRemovedWeights
    
    [i,k]=max(Reward(:));
    Reward(k)=0;
    W1(k)=0;
    
                    [W1,W2]= cut(W1,W2);

   
    [Yhat,E,NSSE_te2UCB1] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2UCB1);
  Acc(j)= NSSE_te2UCB1;
end

    Acc=sort(Acc);



end

