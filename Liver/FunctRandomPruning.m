
clear all;
clc;
close all;
%get the directory of your input files:
pathname = fileparts('C:\Users\lza028\Documents\spam_nn\NNSYSID20\Random\');
%use that when you save
Randm=1;
%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);
  
  tic
  for   OlayTimes = [100,500,1000,1150];
clear Acc;

  hiddenWeights=W1;
%%
[r,c]=size(W1);
    SizeOfWeight=r*c;  
    %SizeOfWeight=1;

    for i=1:OlayTimes;
    
    [ hiddenWeights ] = RandomPruining(hiddenWeights,SizeOfWeight);
    
           [hiddenWeights,W2]= cut(hiddenWeights,W2);

    
    [Yhat,E,NSSE_te2Random] = nneval(NetDef,hiddenWeights,W2,PHI2,Y2,1);
    %fprintf('Test Error : %d\n',NSSE_te2SMingSoftMax);
    Acc(i)= NSSE_te2Random;   
     end
  %%

figure;
plot(Acc,'Color',[0,0.7,0.9]);

title('Error by Applying Random');
xlabel('Number of Weights removed');
ylabel('Test Error');
figfile = fullfile(pathname, sprintf('RandomFigureAccuracyBeforeSorting_%02d.png',OlayTimes));
saveas(gcf,figfile);
  %%
    
Acc=sort(Acc);

figure;
plot(Acc,'Color',[0,0.7,0.9]);

title('Error by Applying Random after Sorting');
xlabel('Number of Weights removed');
ylabel('Test Error');
figfile = fullfile(pathname, sprintf('RandomFigureAccuracy_%02d.png',OlayTimes));
saveas(gcf,figfile);

figure;
drawnet(hiddenWeights,W2,eps,{'x'},{'y'})
figfile = fullfile(pathname, sprintf('RandomFigureModel_%02d.png',OlayTimes));
saveas(gcf,figfile);
  end
  toc

