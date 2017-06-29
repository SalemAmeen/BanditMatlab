function [ Acc,AccRWD] = SM(  )

clear all;
clc;
close all;

%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);

  hiddenWeights=W1;
%%
[r,c]=size(W1);
    SizeOfWeight=r*c;  
    %SizeOfWeight=1;
   


%Initialize Actual Payoffs, Number of times to play, initial value of tau
NumMachines=SizeOfWeight;



%ActQ=randn(NumMachines,1);  %10 machines
AccRWD=zeros(SizeOfWeight,1);

NumPlay=10000;                %Play 100 times
Initialtau=10;                      %Initial value of temperature ("High in beginning")
Endingtau=0.5;
tau=10;
NumPlayed=zeros(NumMachines,1);  %Keep a running sum of the number of times each action is selected
ValPlayed=zeros(NumMachines,1);  %Keep a running sum of the total reward for each action
EstQ=zeros(NumMachines,1);
PayoffHistory=zeros(NumPlay,1);  %Keep a record of our payoffs
tic
for i=1:NumPlay
    
    %Pick a machine to play:
    a=softmax(EstQ,tau);
   
    %Play the machine and update EstQ, tau
    [Yhat,E,NSSE_te2DecayingSoftMax] = nneval(NetDef,hiddenWeights,W2,PHI2,Y2,1);
    
    delta = NSSE_te2 - NSSE_te2DecayingSoftMax ; 
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
    
    tau=Initialtau*(Endingtau/Initialtau)^(i/NumPlay);
end
figure;

EstQ=EstQ./NumPlay;

Reward=EstQ;
RewardBuck=Reward;
SizeOfRemovedWeights=sum(RewardBuck(:)>0);
for j=1:SizeOfRemovedWeights
    
    [i,k]=max(Reward(:));
    Reward(k)=0;
    W1(k)=0;
        [W1,W2]= cut(W1,W2);

    [Yhat,E,NSSE_te2DecayingSoftMax] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2DecayingSoftMax);
  Acc(j)= NSSE_te2DecayingSoftMax;
end

toc

Acc=sort(Acc);


end

