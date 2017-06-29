clear all;
clc;
%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);

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

%% UCB1 needs to run at least every arm once 
% so will run on sample of the dataset over 20
 
for i=1:SizeOfWeight
     
    temp=weight(i);
    weight(i)=0;
    
    [Yhat,E,NSSE_te2UCB1] = nneval(NetDef,weight,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2UCB1);
    
   delta = NSSE_te2 - NSSE_te2UCB1 ; 
      rwd=max(0,0.1+delta);
      
          Value(i)=Value(i)+1;
               mean(i)=mean(i)+1/playTimes;
     weight(i)=temp;   
end

totalAction=SizeOfWeight;

  weight=W1;

tic
for j=1:playTimes
    [idxW]=banditUCB1(Reward,Value,totalAction);
    
    
    
    temp=weight(idxW);
    weight(idxW)=0;
   
    [Yhat,E,NSSE_te2UCB1] = nneval(NetDef,weight,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2UCB1);
    
    delta = NSSE_te2 - NSSE_te2UCB1 ; 
      rwd=max(0,0.1+delta);
      
     Reward(idxW)=Reward(idxW)+rwd;
          Value(idxW)=Value(idxW)+1;
               mean(idxW)=mean(idxW)+1/playTimes;


     weight(idxW)=temp;
     
totalAction= totalAction + 1;
end



bar(Reward);

title('Reward of UCB1 Algorithm');
xlabel('Wieght');
ylabel('Delta Error');

save('UCB1_octavePlayTimesBeforPruning_10000')

for j=1:10000
    
    [i,k]=max(Reward(:));
    Reward(k)=0;
    W1(k)=0;
    [Yhat,E,NSSE_te2UCB1] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2UCB1);
  Acc(j)= NSSE_te2UCB1;
end
toc
    Acc=sort(Acc);

figure;
plot(Acc,'Color',[0,0.7,0.9]);

title('Error by Applying UCB1');
xlabel('Number of Weights removed');
ylabel('Log (Test Error');

figure;
drawnet(W1,W2,eps,{'x'},{'y'})

%save('classificationErrorsUCB1_1000000_octave','classificationErrorsEpsilonAfterPruning');
%save('UCB1_octavePlayTimesAfterPruning_1000000')


%%

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);

  weight=W2;
%%
[r,c]=size(W2);
    SizeOfWeight=r*c;  
    %SizeOfWeight=1;
    

 %%
playTimes=10000;
Reward=zeros(SizeOfWeight,1); % m is the Reward
Value=zeros(SizeOfWeight,1); % Value is the total pulled armed
mean=zeros(SizeOfWeight,1); % mean is the mean of pulled armed

%% UCB1 needs to run at least every arm once 
% so will run on sample of the dataset over 20
 
for i=1:SizeOfWeight
     
    temp=weight(i);
    weight(i)=0;
    
    [Yhat,E,NSSE_te2UCB1] = nneval(NetDef,W1,weight,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2UCB1);
    
   delta = NSSE_te2 - NSSE_te2UCB1 ; 
      rwd=max(0,0.1+delta);
      
          Value(i)=Value(i)+1;
               mean(i)=mean(i)+1/playTimes;
     weight(i)=temp;   
end

totalAction=SizeOfWeight;

  weight=W2;

tic
for j=1:playTimes
    [idxW]=banditUCB1(Reward,Value,totalAction);
    
    
    
    temp=weight(idxW);
    weight(idxW)=0;
   
    [Yhat,E,NSSE_te2UCB1] = nneval(NetDef,W1,weight,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2UCB1);
    
    delta = NSSE_te2 - NSSE_te2UCB1 ; 
      rwd=max(0,0.1+delta);
      
     Reward(idxW)=Reward(idxW)+rwd;
          Value(idxW)=Value(idxW)+1;
               mean(idxW)=mean(idxW)+1/playTimes;


     weight(idxW)=temp;
     
totalAction= totalAction + 1;
end



bar(Reward);

title('Reward of UCB1 Algorithm');
xlabel('Wieght');
ylabel('Delta Error');

save('UCB1_octavePlayTimesBeforPruning_10000')

for j=1:10000
    
    [i,k]=max(Reward(:));
    Reward(k)=0;
    W2(k)=0;
    [Yhat,E,NSSE_te2UCB1] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2UCB1);
  Acc(j)= NSSE_te2UCB1;
end
toc
    Acc=sort(Acc);

figure;
plot(Acc,'Color',[0,0.7,0.9]);

title('Error by Applying UCB1');
xlabel('Number of Weights removed');
ylabel('Log (Test Error');

figure;
drawnet(W1,W2,eps,{'x'},{'y'})

%save('classificationErrorsUCB1_1000000_octave','classificationErrorsEpsilonAfterPruning');
%save('UCB1_octavePlayTimesAfterPruning_1000000')