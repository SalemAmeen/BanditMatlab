%%  SPECTF Heart Data Set
% http://mlr.cs.umass.edu/ml/datasets/SPECTF+Heart

%% read that data
%fulldata=csvread('spambase.data');
fulldata1=csvread('train.txt');
fulldata2=csvread('test.txt');

fulldata = vertcat(fulldata1,fulldata2);

[row,col]=size(fulldata);
% Create an random index into your matrices
idx = randperm(row);
% Shuffle both matrices by the same index, preserving the relationship
fulldata = fulldata(idx,:);
% read the data
DataRaw=fulldata(:,2:45);

%% Normalize the data
Dataw = bsxfun(@rdivide,DataRaw,sum(DataRaw)); 
Data=normc(DataRaw);
label=fulldata(:,1);
%% Divide the data to training and testing
trainData=Data(1:200,:) ;
testData=Data(200:267,:);
trainlabel=label(1:200,:) ;
testlabel=label(200:267,:);
%load('tr');
%trparms=tr;
y2=testlabel;
save('dataSetofSpam.mat');


