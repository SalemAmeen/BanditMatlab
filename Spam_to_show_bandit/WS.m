function [ Acc,AccRWD, WStime ] = WS(  )
clear all;
clc;
close all;

load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);

  hiddenWeights=W1;
%%
[r,c]=size(W1);
    SizeOfWeight=r*c;  
    %SizeOfWeight=1;
   


%Initialize Actual Payoffs, Number of times to play, initial value of beta
NumMachines=SizeOfWeight;
AccRWD=zeros(SizeOfWeight,1);



ActQ=randn(NumMachines,1);  %10 machines
NumPlay=10000;                %Play 100 times
%Initialbeta=10;                      %Initial value of temperature ("High in beginning")
%Endingbeta=0.5;
NumPlayed=zeros(NumMachines,1);  %Keep a running sum of the number of times each action is selected
ValPlayed=zeros(NumMachines,1);  %Keep a running sum of the total reward for each action
EstQ=zeros(NumMachines,1);
PayoffHistory=zeros(NumPlay,1);  %Keep a record of our payoffs
Initialbeta=0.01;                      %Initial value of temperature ("High in beginning")
Endingbeta=0.0001;
beta=Initialbeta;

Probs=(1/NumMachines)*ones(NumMachines,1);

tic

for i=1:NumPlay
    
    %Pick a machine to play:
    [a,Probs]=winstay(EstQ,Probs,beta);
   %Play the machine and update EstQ, beta
    [Yhat,E,NSSE_te2DecayingWinStay] = nneval(NetDef,hiddenWeights,W2,PHI2,Y2,1);
    
    delta = NSSE_te2 - NSSE_te2DecayingWinStay ; 
      rwd=max(0,0.1+delta);
    
     %%
      % Compute accumlative rewards
      if i>1
               AccRWD(i)=rwd+AccRWD(i-1);
      else
                AccRWD(i)=rwd;
      end
  %%    
    %%
      
      temp=hiddenWeights(a);
    hiddenWeights(a)=0;
     EstQ(a)=EstQ(a)+rwd;
     hiddenWeights(a)=temp;
    
    beta=Initialbeta*(Endingbeta/Initialbeta)^(i/NumPlay);
end

WStime = toc
EstQ=EstQ./NumPlay;


Reward=EstQ;
RewardBuck=Reward;
SizeOfRemovedWeights=sum(RewardBuck(:)>0);
for j=1:SizeOfRemovedWeights
    
    [i,k]=max(Reward(:));
    Reward(k)=0;
    W1(k)=0;
                [W1,W2]= cut(W1,W2);

    [Yhat,E,NSSE_te2DecayingWinStay] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2DecayingWinStay);
  Acc(j)= NSSE_te2DecayingWinStay;
end



Acc=sort(Acc);

end

