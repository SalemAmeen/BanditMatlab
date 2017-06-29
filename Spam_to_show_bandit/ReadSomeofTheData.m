%% Spam Dataset
% https://archive.ics.uci.edu/ml/datasets/Spambase

%% Read that data
fulldata=csvread('spambase.data');
[row,col]=size(fulldata);
% Create an random index into your matrices
idx = randperm(row);
% Shuffle both matrices by the same index, preserving the relationship
fulldata = fulldata(idx,:);
DataRaw=fulldata(:,1:57);
%% Normalize the data
Dataw = bsxfun(@rdivide,DataRaw,sum(DataRaw)); % Normalize the data
Data=normc(DataRaw);
label=fulldata(:,58);

%% Divide the data to training and testing
trainData=Data(1:4000,:) ;
testData=Data(4000:4601,:);

trainlabel=label(1:4000,:) ;
testlabel=label(4000:4601,:);
%load('tr');
%trparms=tr;
y2=testlabel;
save('dataSetofSpam.mat');