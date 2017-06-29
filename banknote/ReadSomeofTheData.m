%%   banknote authentication Data Set 
% https://archive.ics.uci.edu/ml/datasets/banknote+authentication
%%
% read that data
%fulldata=csvread('spambase.data');
fulldata=csvread('banknote.txt');
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
trainData=Data(1:1000,:) ;
testData=Data(1000:1372,:);
trainlabel=label(1:1000,:) ;
testlabel=label(1000:1372,:);
%load('tr');
%trparms=tr;
y2=testlabel;
save('dataSetofSpam.mat');


