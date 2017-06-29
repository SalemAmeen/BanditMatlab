clear all;
clc;
close all;
%get the directory of your input files:
pathname = fileparts('C:\Users\lza028\Documents\spam_nn\NNSYSID20\GridSelction\');
%use that when you save



%%
load('modelEvaluation.mat');  

[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);
  number=1;
  figure;
drawnet(W1,W2,eps,{'x'},{'y'})
figfile = fullfile(pathname, sprintf('GridSelectionFigureModelBeforePruning_%02f.png',number));
saveas(gcf,figfile);
%%
[r,c]=size(W1);
    SizeOfWeight=r*c;  
    %SizeOfWeight=1;
 

 %%
playTimes=500;

%% GridSelection needs to run at least every arm once 
% so will run on sample of the dataset over 20
 
for i=1:playTimes
     
    W1(i)=0;
    
                  [W1,W2]= cut(W1,W2);

    [Yhat,E,NSSE_te2GridSelection] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2GridSelection);
    
   delta = NSSE_te2 - NSSE_te2GridSelection ; 
      
            Acc(i)= NSSE_te2GridSelection;


end

number=1;
    figfile = fullfile(pathname, sprintf('GridSelectionFigureReward_%02d.png',number));
saveas(gcf,figfile);



    %Acc=sort(Acc);

figure;
plot(Acc,'Color',[0,0.7,0.9]);

title('Error by Applying GridSelection');
xlabel('Number of Weights removed');
ylabel('Test Error');

number=1;
    figfile = fullfile(pathname, sprintf('GridSelectionFigureAcuracyAfterPruning_%02d.png',number));
saveas(gcf,figfile);

figure;
drawnet(W1,W2,eps,{'x'},{'y'})
number=1;
    figfile = fullfile(pathname, sprintf('GridSelectionFigureModelAfterPruning_%02d.png',number));
saveas(gcf,figfile);



%%
%save('classificationErrorsGridSelection_1000000_octave','classificationErrorsEpsilonAfterPruning');
%save('GridSelection_octavePlayTimesAfterPruning_10000')
%save(sprintf('GridSelection_PlayTimesAfterPrunin_%02d',playTimes))

%[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  %fprintf('Test Error : %d\n',NSSE_te2);



matfile = fullfile(pathname, sprintf('GridSelection_PlayTimesAfterPrunin_%02d',playTimes));
%figfile = fullfile(pathname, 'output.fig');
save(matfile);
%saveas(figfile, ...');

