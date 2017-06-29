%noOfweightsRemoved=10000;

load('NetArtetechure.mat');   


    [correctlyClassified, classificationErrors] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputValues, labels);
    
    fprintf('Classification errors: %d\n', classificationErrors);
    fprintf('Correctly classified: %d\n', correctlyClassified);
    
    [r,c]=size(hiddenWeights);
    SizeOfWeight=r*c;
    
%% Random Pruining 
[ classificationErrorsRanom ] = FunctRandomPruning( SizeOfWeight );
   
 %% Epsilon Greedy Algorithm
 
 [ classificationErrorsEpsilon ] = FunctEpsilionPruning( SizeOfWeight );

 
    
    