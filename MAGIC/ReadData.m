% read that data
fulldata=csvread('spambase.data');



DataRaw=fulldata(:,1:57);

Dataw = bsxfun(@rdivide,DataRaw,sum(DataRaw)); % Normalize the data

Data=normc(DataRaw);

label=fulldata(:,58);

% Divide the data to training and testing
trainData=Data(1:3000,:) ;
testData=Data(3000:4601,:);

trainlabel=label(1:3000,:) ;
testlabel=label(3000:4601,:);

save('dataSetofSpam.mat');


