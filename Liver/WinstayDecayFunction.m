%Script file to run the N-armed bandit using the Win-Stay, Lose-Shift strategy

%Initialize Actual Payoffs, Number of times to play, initial value of beta

%Script file to run the N-armed bandit using the WinStay strategy
%%
clear all;
clc;
close all;
%get the directory of your input files:
pathname = fileparts('C:\Users\lza028\Documents\spam_nn\NNSYSID20\DecayingWinStay\');
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
   


%Initialize Actual Payoffs, Number of times to play, initial value of beta
NumMachines=SizeOfWeight;



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
      
      temp=hiddenWeights(a);
    hiddenWeights(a)=0;
     EstQ(a)=EstQ(a)+rwd;
     hiddenWeights(a)=temp;
    
    beta=Initialbeta*(Endingbeta/Initialbeta)^(i/NumPlay);
end
figure;

EstQ=EstQ./NumPlay;
plot(EstQ)

title('Reward of Decay Win Stay Algorithm');
xlabel('Wieght');
ylabel('Delta Error');

 figfile = fullfile(pathname, sprintf('DecayingWinStayFigureReward_%02f.png',beta));
saveas(gcf,figfile);
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

toc

Acc=sort(Acc);

figure;
plot(Acc,'Color',[0,0.7,0.9]);

title('Error by Applying Decaying  Win Stay');
xlabel('Number of Weights removed');
ylabel('Test Error');
figfile = fullfile(pathname, sprintf('DecayingWinStayFigureAccuracy_%02f.png',beta));
saveas(gcf,figfile);

figure;
drawnet(W1,W2,eps,{'x'},{'y'})
figfile = fullfile(pathname, sprintf('DecayingWinStayFigureModel_%02f.png',beta));
saveas(gcf,figfile);


