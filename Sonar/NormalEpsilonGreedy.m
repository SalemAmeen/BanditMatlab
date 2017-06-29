clear all;
clc;
load('NetArtetechure.mat'); 

[r,c]=size(hiddenWeights);
    %SizeOfWeight=r*c;  
    SizeOfWeight=10;
    
[correctlyClassified, classificationErrors] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputValues, labels);
fprintf('Classification errors Befor pruning: %d\n', classificationErrors);
fprintf('Correctly classified Befor pruning: %d\n', correctlyClassified);

 %%
playTimes=2;
Reward=zeros(SizeOfWeight,1); % m is the Reward
Value=zeros(SizeOfWeight,1); % Value is the total pulled armed
mean=zeros(SizeOfWeight,1); % mean is the mean of pulled armed

%% UCB1 needs to run at least every arm once 
% so will run on sample of the dataset over 20


totalAction=SizeOfWeight;
E=0.9;

for j=1:playTimes
    [idxW]=banditNormalEpsilon(Reward,Value,E);
    
    
    
    temp=hiddenWeights(idxW);
    hiddenWeights(idxW)=0;
    %fprintf('index at max: %d\n',idxW );
    [correctlyClassifiedEpsilonNormal, classificationErrorsEpsilonNormal] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputValues, labels);
%fprintf('Classification errors  AFTER EPSILON pruning: %d\n', classificationErrorsEpsilon);
%fprintf('Correctly classified AFTER EPSILON pruning: %d\n', correctlyClassifiedEpsilon);

      delta = classificationErrorsEpsilonNormal - classificationErrors ; 
      rwd=max(0,0.2+delta);
      
     Reward(idxW)=Reward(idxW)+rwd;
          Value(idxW)=Value(idxW)+1;
               mean(idxW)=mean(idxW)+1/playTimes;


     hiddenWeights(idxW)=temp;
     
totalAction= totalAction + 1;
end


plot(Reward);