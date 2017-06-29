
clear all;
clc;
close all;
%get the directory of your input files:
pathname = fileparts('C:\Users\lza028\Documents\spam_nn\NNSYSID20\DecayingGreedy\');
%use that when you save

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
      
     Reward(idxW)=Reward(idxW)+rwd;
          Value(idxW)=Value(idxW)+1;
               mean(idxW)=mean(idxW)+1/playTimes;


     weight(idxW)=temp;
     
totalAction= totalAction + 1;
end



figure;
bar(Reward);

title('Reward of Epsilon Greedy Algorithm');
xlabel('Wieght');
ylabel('Delta Error');

 figfile = fullfile(pathname, sprintf('DecayingGreedyFigureReward_%02f.png',epsilon));
saveas(gcf,figfile);

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

toc

Acc=sort(Acc);

figure;
plot(Acc,'Color',[0,0.7,0.9]);

title('Error by Applying Decaying Epsilpn Greedy');
xlabel('Number of Weights removed');
ylabel('Test Error');
figfile = fullfile(pathname, sprintf('DecayingGreedyFigureAccuracy_%02f.png',epsilon));
saveas(gcf,figfile);

figure;
drawnet(W1,W2,eps,{'x'},{'y'})
figfile = fullfile(pathname, sprintf('DecayingGreedyFigureModel_%02f.png',epsilon));
saveas(gcf,figfile);


