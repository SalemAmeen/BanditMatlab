function [ Acc,AccRWD,TStime ] = TSDrawing(  )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
clear all;
clc;
close all;



%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
 
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

%% ThompsonSampling needs to run at least every arm once 
% so will run on sample of the dataset over 20

hiddenWeights=W1;

totalAction=SizeOfWeight;
tic 
for j=1:playTimes
    [idxW]=ThomsonSamoling(Reward,Value);
    
    %fprintf('Index = %d\n',idxW)
    
    
    
    temp=hiddenWeights(idxW);
    hiddenWeights(idxW)=0;
    
    
    
    [Yhat,E,NSSE_te2ThompsonSampling] = nneval(NetDef,hiddenWeights,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2ThompsonSampling);
    
   delta = NSSE_te2 - NSSE_te2ThompsonSampling ; 
      rwd=max(0,0.1+delta);
      
      %%
      % Compute accumlative rewards
      if j>1
               AccRWD(j)=rwd+AccRWD(j-1);
      else
                AccRWD(j)=rwd;
      end
  %%    
      
        %fprintf('Test Error : %d\n',rwd);
     
        
        Reward(idxW)=Reward(idxW)+rwd;

          Value(idxW)=Value(idxW)+1;
               mean(idxW)=mean(idxW)+1/playTimes;
     hiddenWeights(idxW)=temp;   
     
totalAction= totalAction + 1;
end

TStime = toc

RewardBuck=Reward;
SizeOfRemovedWeights=sum(RewardBuck(:)>0);
%save('ThomsonSampling_octavePlayTimesBeforPruning_1000000')

for j=1:SizeOfRemovedWeights
    
    [i,k]=max(Reward(:));
    Reward(k)=0;
    W1(k)=0;
                        [W1,W2]= cut(W1,W2);

    [Yhat,E,NSSE_te2ThompsonSampling] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2ThompsonSampling);
  Acc(j)= NSSE_te2ThompsonSampling;
end


Acc=sort(Acc);


end

