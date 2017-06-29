
clear all;
clc;
load('NetArtetechure.mat'); 

[r,c]=size(hiddenWeights);
    SizeOfWeight=r*c;     
[correctlyClassified, classificationErrors] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputValues, labels);
fprintf('Classification errors Befor pruning: %d\n', classificationErrors);
fprintf('Correctly classified Befor pruning: %d\n', correctlyClassified);

 %%

Ravg=zeros(1000,1);
E=0.9;
m=zeros(SizeOfWeight,1);

for j=1:500000
    [idxW,As,Q,R]=banditE(1000,m,E);
    
    Ravg=Ravg+R;
    %%if mod(j,10)==0
        %fprintf('On iterate %d\n',j);
    %end
    
    temp=hiddenWeights(idxW);
    hiddenWeights(idxW)=0;
    %fprintf('index at max: %d\n',idxW );
    [correctlyClassifiedEpsilon, classificationErrorsEpsilon] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputValues, labels);
%fprintf('Classification errors  AFTER EPSILON pruning: %d\n', classificationErrorsEpsilon);
%fprintf('Correctly classified AFTER EPSILON pruning: %d\n', correctlyClassifiedEpsilon);

      delta = classificationErrorsEpsilon - classificationErrors ; 
      rwd=max(0,0.2+delta);
      
     m(idxW)=m(idxW)+rwd;
     hiddenWeights(idxW)=temp;
     


end


Ravg=Ravg./500000;
plot(Ravg);