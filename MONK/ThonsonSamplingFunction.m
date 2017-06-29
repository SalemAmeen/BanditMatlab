clear all;
clc;
close all;
%get the directory of your input files:
pathname = fileparts('C:\Users\lza028\Documents\spam_nn\NNSYSID20\ThompsonSampling\');
%use that when you save



%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);
  number=1;
  figure;
drawnet(W1,W2,eps,{'x'},{'y'})
figfile = fullfile(pathname, sprintf('ThompsonSamplingFigureModelBeforePruning_%02f.png',number));
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
        %fprintf('Test Error : %d\n',rwd);
     
        
        Reward(idxW)=Reward(idxW)+rwd;

          Value(idxW)=Value(idxW)+1;
               mean(idxW)=mean(idxW)+1/playTimes;
     hiddenWeights(idxW)=temp;   
     
totalAction= totalAction + 1;
end


bar(Reward);

title('Reward of ThompsonSampling Algorithm');
xlabel('Wieght');
ylabel('Delta Error');
number=1;
    figfile = fullfile(pathname, sprintf('ThompsonSamplingFigureReward_%02d.png',number));
saveas(gcf,figfile);


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
toc
save('ThomsonSampling_octavePlayTimesBeforPruning_1000000');

Acc=sort(Acc);

figure;
plot(Acc,'Color',[0,0.7,0.9]);

title('Error by Applying ThompsonSampling');
xlabel('Number of Weights removed');
ylabel('Test Error');

number=1;
    figfile = fullfile(pathname, sprintf('ThompsonSamplingFigureAcuracyAfterPruning_%02d.png',number));
saveas(gcf,figfile);

figure;
drawnet(W1,W2,eps,{'x'},{'y'})
number=1;
    figfile = fullfile(pathname, sprintf('ThompsonSamplingFigureModelAfterPruning_%02d.png',number));
saveas(gcf,figfile);


%save('classificationErrorsThompsonSampling_1000000_octave','classificationErrorsEpsilonAfterPruning');
%save('ThompsonSampling_octavePlayTimesAfterPruning_10000')
%save(sprintf('ThompsonSampling_PlayTimesAfterPrunin_%02d',playTimes))