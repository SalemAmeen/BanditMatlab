clear all;
clc;
close all;
%get the directory of your input files:
pathname = fileparts('C:\Users\lza028\Documents\spam_nn\NNSYSID20\GreedyNaive\');
%use that when you save

%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);
WBuck=W1;
  weight=W1;
%%
[r,c]=size(W1);
    SizeOfWeight=r*c;  
    %SizeOfWeight=1;
    maxExplore=10;
    
 %%
playTimes=10000;
tic
Grid = 0;
    W1=WBuck;
  weight=WBuck;
Reward=zeros(SizeOfWeight,1); % m is the Reward

Value=zeros(SizeOfWeight,1); % Value is the total pulled armed
mean=zeros(SizeOfWeight,1); % mean is the mean of pulled armed



totalAction=SizeOfWeight;

for j=1:playTimes
    clear Acc;
    [idxW]=banditNormalGreedy(mean,Value,Grid,SizeOfWeight,maxExplore);    
    temp=weight(idxW);
    weight(idxW)=0;
   
    [Yhat,E,NSSE_te2Grid] = nneval(NetDef,weight,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2GridSelection);
    
    delta = NSSE_te2 - NSSE_te2Grid ; 
      rwd=max(0,0.1+delta);
      
     Reward(idxW)=Reward(idxW)+rwd;
          Value(idxW)=Value(idxW)+1;
               mean(idxW)=mean(idxW)+1/playTimes;


     weight(idxW)=temp;
     
totalAction= totalAction + 1;
end



figure;
bar(Reward);

title('Reward of Greedy Algorithm');
xlabel('Wieght');
ylabel('Delta Error');

 figfile = fullfile(pathname, sprintf('GridSelectionFigureReward_%05f.png',Grid));
saveas(gcf,figfile);

RewardBuck=Reward;
SizeOfRemovedWeights=sum(RewardBuck(:)>0);
for j=1:1000
    
    [i,k]=max(Reward(:));
    Reward(k)=0;
    W1(k)=0;
               [W1,W2]= cut(W1,W2);

    [Yhat,E,NSSE_te2Grid] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2Grid);
  Acc(j)= NSSE_te2Grid;
  %fprintf('%f\n',NSSE_te2Grid);

end

toc

Acc=sort(Acc);

figure;
plot(Acc,'Color',[0,0.7,0.9]);

Acc=Acc.*100;

title('Error by Greedy');
xlabel('Number of Weights removed');
ylabel('Test Error');
figfile = fullfile(pathname, sprintf('GridSelectionFigureAccuracy_%05f.png',Grid));
saveas(gcf,figfile);

figure;
drawnet(W1,W2,eps,{'x'},{'y'})
figfile = fullfile(pathname, sprintf('GridSelectionFigureModel_%05f.png',Grid));
saveas(gcf,figfile);


