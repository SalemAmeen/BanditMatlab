function [ output_args ] = FunctionEpsilonGready( SizeOfWeight )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
load('NetArtetechure.mat');   



[ hiddenWeights ] = EpsilonPruining(hiddenWeights ,SizeOfWeight );

    [correctlyClassified, classificationErrors] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputValues, labels);
    classificationErrorsRanom(k)=classificationErrors;
    fprintf('Classification errors after %d Random Pruning: %d\n', i,classificationErrors);
   % fprintf('Correctly classified after %d Random Pruning: %d\n', i,correctlyClassified);     
    save('classificationErrorsRanom.mat','classificationErrorsRanom');

end

