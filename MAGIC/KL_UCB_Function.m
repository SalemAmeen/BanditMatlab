clear all;
clc;
close all;
%get the directory of your input files:
pathname = fileparts('C:\Users\lza028\Documents\spam_nn\New_of_NNSYSID20\KL_UCB\');
%use that when you save



%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);
  number=1;
  figure;
drawnet(W1,W2,eps,{'x'},{'y'})
figfile = fullfile(pathname, sprintf('KL_UCBFigureModelBeforePruning_%02f.png',number));
saveas(gcf,figfile);
  weight=W1;
%%
[r,c]=size(W1);
    SizeOfWeight=r*c;  
    %SizeOfWeight=1;
 

 %%
playTimes=10000;
Reward=zeros(SizeOfWeight,1); % m is the Reward
Value=zeros(SizeOfWeight,1); % Value is the total pulled armed
mean=zeros(SizeOfWeight,1); % mean is the mean of pulled armed

%% KL_UCB needs to run at least every arm once 
% so will run on sample of the dataset over 20
 
for i=1:SizeOfWeight
     
    temp=weight(i);
    weight(i)=0;
    
    [Yhat,E,NSSE_te2KL_UCB] = nneval(NetDef,weight,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2KL_UCB);
    
   delta = NSSE_te2 - NSSE_te2KL_UCB ; 
      rwd=max(0,0.1+delta);
      
          Value(i)=Value(i)+1;
               mean(i)=mean(i)+1/playTimes;
     weight(i)=temp;   
end

totalAction=SizeOfWeight;

  weight=W1;

tic
for j=1:playTimes
    [idxW]=KL_UCB(Reward,Value,j);
    
    
    
    temp=weight(idxW);
    weight(idxW)=0;
   
    [Yhat,E,NSSE_te2KL_UCB] = nneval(NetDef,weight,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2KL_UCB);
    
    delta = NSSE_te2 - NSSE_te2KL_UCB ; 
      rwd=max(0,0.1+delta);
      
     Reward(idxW)=Reward(idxW)+rwd;
          Value(idxW)=Value(idxW)+1;
               mean(idxW)=mean(idxW)+1/playTimes;


     weight(idxW)=temp;
     
totalAction= totalAction + 1;
end



bar(Reward);

title('Reward of KL_UCB Algorithm');
xlabel('Wieght');
ylabel('Delta Error');
number=1;
    figfile = fullfile(pathname, sprintf('KL_UCBFigureReward_%02d.png',number));
saveas(gcf,figfile);


%save('KL_UCB_octavePlayTimesBeforPruning_10000')
RewardBuck=Reward;
SizeOfRemovedWeights=sum(RewardBuck(:)>0);
for j=1:SizeOfRemovedWeights
    
    [i,k]=max(Reward(:));
    Reward(k)=0;
    W1(k)=0;
    
                    [W1,W2]= cut(W1,W2);

   
    [Yhat,E,NSSE_te2KL_UCB] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2KL_UCB);
  Acc(j)= NSSE_te2KL_UCB;
end
toc
    Acc=sort(Acc);

figure;
plot(Acc,'Color',[0,0.7,0.9]);

title('Error by Applying KL UCB');
xlabel('Number of Weights removed');
ylabel('Test Error');

number=1;
    figfile = fullfile(pathname, sprintf('KL_UCBFigureAcuracyAfterPruning_%02d.png',number));
saveas(gcf,figfile);

figure;
drawnet(W1,W2,eps,{'x'},{'y'})
number=1;
    figfile = fullfile(pathname, sprintf('KL_UCBFigureModelAfterPruning_%02d.png',number));
saveas(gcf,figfile);


%save('classificationErrorsKL_UCB_1000000_octave','classificationErrorsEpsilonAfterPruning');
%save('KL_UCB_octavePlayTimesAfterPruning_10000')
%save(sprintf('KL_UCB_PlayTimesAfterPrunin_%02d',playTimes))

%[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2);



matfile = fullfile(pathname, sprintf('KL_UCB_PlayTimesAfterPrunin_%02d',playTimes));
%figfile = fullfile(pathname, 'output.fig');
save(matfile);
%saveas(figfile, ...');

