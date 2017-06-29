%Script file to run the N-armed bandit using the softmax strategy
%%
clear all;
clc;
close all;
%get the directory of your input files:
pathname = fileparts('C:\Users\lza028\Documents\spam_nn\NNSYSID20\DecayingSoftMax\');
%use that when you save

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



ActQ=randn(NumMachines,1);  %10 machines
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
      
      temp=hiddenWeights(a);
    hiddenWeights(a)=0;
    
    
     EstQ(a)=EstQ(a)+rwd;
     hiddenWeights(a)=temp;
    
    tau=Initialtau*(Endingtau/Initialtau)^(i/NumPlay);
end
figure;

EstQ=EstQ./NumPlay;
plot(EstQ)
title('Reward of Decay Soft Max Algorithm');
xlabel('Wieght');
ylabel('Delta Error');

 figfile = fullfile(pathname, sprintf('DecayingSoftMaxFigureReward_%02f.png',tau));
saveas(gcf,figfile);
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

figure;
plot(Acc,'Color',[0,0.7,0.9]);

title('Error by Applying Decaying Decaying Soft Max');
xlabel('Number of Weights removed');
ylabel('Test Error');
figfile = fullfile(pathname, sprintf('DecayingSoftMaxFigureAccuracy_%02f.png',tau));
saveas(gcf,figfile);

figure;
drawnet(W1,W2,eps,{'x'},{'y'})
figfile = fullfile(pathname, sprintf('DecayingSoftMaxFigureModel_%02f.png',tau));
saveas(gcf,figfile);