function [ Acc,AccRWD, egtime ] = EG(  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

clear all;
clc;
close all;

%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);

  weight=W1;
%%
[r,c]=size(W1);
    SizeOfWeight=r*c;  
    %SizeOfWeight=1;
    maxExplore=10;
   %%
   IntialEpsilon=0.9;
   EndEpsilon=0.001;
   

 %%
playTimes=10000;

Reward=zeros(SizeOfWeight,1); % m is the Reward
Value=zeros(SizeOfWeight,1); % Value is the total pulled armed
mean=zeros(SizeOfWeight,1); % mean is the mean of pulled armed
AccRWD=zeros(SizeOfWeight,1);

totalAction=SizeOfWeight;
tic
for j=1:playTimes
    epsilon= IntialEpsilon * (EndEpsilon/IntialEpsilon)^(j/playTimes);
    
    [idxW]=banditNormalEpsilon(mean,Value,epsilon,SizeOfWeight,maxExplore);    
    temp=weight(idxW);
    weight(idxW)=0;
   
    [Yhat,E,NSSE_te2DecayingGreedy] = nneval(NetDef,weight,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2DecayingGreedy);
    
    delta = NSSE_te2 - NSSE_te2DecayingGreedy ; 
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


egtime = toc

RewardBuck=Reward;
SizeOfRemovedWeights=sum(RewardBuck(:)>0);
for j=1:SizeOfRemovedWeights
    
    [i,k]=max(Reward(:));
    Reward(k)=0;
    W1(k)=0;
    
        [W1,W2]= cut(W1,W2);

    [Yhat,E,NSSE_te2DecayingGreedy] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2DecayingGreedy);
  Acc(j)= NSSE_te2DecayingGreedy;
end



Acc=sort(Acc);



end

