%%  Haberman's Survival Data Set 
% https://archive.ics.uci.edu/ml/datasets/Haberman's+Survival
%%
% read that data
%fulldata=csvread('spambase.data');
fulldata=csvread('Haberman.txt');
[row,col]=size(fulldata);
% Create an random index into your matrices
idx = randperm(row);
% Shuffle both matrices by the same index, preserving the relationship
fulldata = fulldata(idx,:);
% read the data
DataRaw=fulldata(:,1:3);

%% Normalize the data
Dataw = bsxfun(@rdivide,DataRaw,sum(DataRaw)); 
Data=normc(DataRaw);
label=fulldata(:,4);
%% Divide the data to training and testing
trainData=Data(1:200,:) ;
testData=Data(200:306,:);
trainlabel=label(1:200,:) ;
testlabel=label(200:306,:);
%load('tr');
%trparms=tr;
y2=testlabel;
save('dataSetofSpam.mat');


