%%  Blood Transfusion Service Center Data Set
% https://archive.ics.uci.edu/ml/datasets/Blood+Transfusion+Service+Center
%%
% read that data
%fulldata=csvread('spambase.data');
fulldata=csvread('blood.txt');
[row,col]=size(fulldata);
% Create an random index into your matrices
idx = randperm(row);
% Shuffle both matrices by the same index, preserving the relationship
fulldata = fulldata(idx,:);
% read the data
DataRaw=fulldata(:,1:4);

%% Normalize the data
Dataw = bsxfun(@rdivide,DataRaw,sum(DataRaw)); 
Data=normc(DataRaw);
label=fulldata(:,5);
%% Divide the data to training and testing
trainData=Data(1:600,:) ;
testData=Data(600:748,:);
trainlabel=label(1:600,:) ;
testlabel=label(600:748,:);
%load('tr');
%trparms=tr;
y2=testlabel;
save('dataSetofSpam.mat');


