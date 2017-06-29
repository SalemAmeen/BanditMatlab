%%  default of credit card clients Data Set
% https://archive.ics.uci.edu/ml/datasets/default+of+credit+card+clients

% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: C:\Users\lza028.ISDADS\Documents\BanditMatlab\credit\credit card clients.xls
%    Worksheet: Data
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.


%% Import the data
[~, ~, raw] = xlsread('C:\Users\lza028.ISDADS\Documents\BanditMatlab\credit\credit card clients.xls','Data');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% Exclude rows with non-numeric cells
I = ~all(cellfun(@(x) (isnumeric(x) || islogical(x)) && ~isnan(x),raw),2); % Find rows with non-numeric cells
raw(I,:) = [];

%% Create output variable
creditcardclients = reshape([raw{:}],size(raw));

%% Clear temporary variables
clearvars raw I;

fulldata=creditcardclients;
[row,col]=size(fulldata);
% Create an random index into your matrices
idx = randperm(row);
% Shuffle both matrices by the same index, preserving the relationship
fulldata = fulldata(idx,:);
% read the data
DataRaw=fulldata(:,1:23);

%% Normalize the data
Dataw = bsxfun(@rdivide,DataRaw,sum(DataRaw)); 
Data=normc(DataRaw);
label=fulldata(:,24);
%% Divide the data to training and testing
trainData=Data(1:29000,:) ;
testData=Data(29000:30000,:);
trainlabel=label(1:29000,:) ;
testlabel=label(29000:30000,:);
%load('tr');
%trparms=tr;
y2=testlabel;
save('dataSetofSpam.mat');
