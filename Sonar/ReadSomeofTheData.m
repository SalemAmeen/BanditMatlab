%%  Liver Disorders Data Set
% http://mlr.cs.umass.edu/ml/datasets/Liver+Disorders

%% read that data
%fulldata=csvread('spambase.data');
fulldata=csvread('liver.txt');
[row,col]=size(fulldata);
% Create an random index into your matrices
idx = randperm(row);
% Shuffle both matrices by the same index, preserving the relationship
fulldata = fulldata(idx,:);
% read the data
DataRaw=fulldata(:,1:6);

%% Normalize the data
Dataw = bsxfun(@rdivide,DataRaw,sum(DataRaw)); 
Data=normc(DataRaw);
label=fulldata(:,7);
%% Divide the data to training and testing
trainData=Data(1:250,:) ;
testData=Data(250:345,:);
trainlabel=label(1:250,:) ;
testlabel=label(250:345,:);
%load('tr');
%trparms=tr;
y2=testlabel;
save('dataSetofSpam.mat');


