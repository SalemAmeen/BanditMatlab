function [ Acc, Ttime ] = Threshold()
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
clear all;
clc;
close all;

%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);
  
  tic
    OlayTimes = 100;
clear Acc;
threshold = 0.1;
  hiddenWeights=W1;
%%
[r,c]=size(W1);
    SizeOfWeight=r*c;  
    %SizeOfWeight=1;

    for i=1:OlayTimes;
        
indices = find(abs(hiddenWeights)< threshold * i);
hiddenWeights(indices) = 0;  
        
    
    [Yhat,E,NSSE_te2Random] = nneval(NetDef,hiddenWeights,W2,PHI2,Y2,1);
    %fprintf('Test Error : %d\n',NSSE_te2SMingSoftMax);
    Acc(i)= NSSE_te2Random;   
     end
  %%
Ttime = toc