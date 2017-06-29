%%  Tic-Tac-Toe Endgame Data Set
% http://mlr.cs.umass.edu/ml/datasets/Tic-Tac-Toe+Endgame

% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\lza028.ISDADS\Documents\BanditMatlab\Tic_Toc\Tic_toc.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.


%% Initialize variables.
filename = 'C:\Users\lza028.ISDADS\Documents\BanditMatlab\Tic_Toc\Tic_toc.txt';
delimiter = ',';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,7,8,9,10]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% Replace specified string with 1.0
R = cellfun(@(x) ischar(x) && strcmp(x,'x'),raw); % Find non-numeric cells
raw(R) = {1.0}; % Replace non-numeric cells

%% Replace specified string with 2.0
R = cellfun(@(x) ischar(x) && strcmp(x,'o'),raw); % Find non-numeric cells
raw(R) = {2.0}; % Replace non-numeric cells

%% Replace specified string with 3.0
R = cellfun(@(x) ischar(x) && strcmp(x,'b'),raw); % Find non-numeric cells
raw(R) = {3.0}; % Replace non-numeric cells

%% Replace specified string with 1.0
R = cellfun(@(x) ischar(x) && strcmp(x,'positive'),raw); % Find non-numeric cells
raw(R) = {1.0}; % Replace non-numeric cells

%% Replace specified string with 0.0
R = cellfun(@(x) ischar(x) && strcmp(x,'negative'),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

%% Create output variable
Tictoc = cell2mat(raw);
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me R;

 fulldata = Tictoc;
 
 [row,col]=size(fulldata);
% Create an random index into your matrices
idx = randperm(row);
% Shuffle both matrices by the same index, preserving the relationship
fulldata = fulldata(idx,:);
% read the data
DataRaw=fulldata(:,1:9);

%% Normalize the data
Dataw = bsxfun(@rdivide,DataRaw,sum(DataRaw)); 
Data=normc(DataRaw);
label=fulldata(:,10);
%% Divide the data to training and testing
trainData=Data(1:800,:) ;
testData=Data(800:958,:);
trainlabel=label(1:800,:) ;
testlabel=label(800:958,:);
%load('tr');
%trparms=tr;
y2=testlabel;
save('dataSetofSpam.mat');