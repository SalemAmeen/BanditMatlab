size=500;

%%
chk=length(Accobsprune)
if chk>size
Accobsprune=Accobsprune(1:size);
xs=[1:size];
else
xs=[1:length(Accobsprune)];
end
%%
chk=length(Accobdprune)
if chk>size
Accobdprune=Accobdprune(1:size);
xd=[1:size];
else
xd=[1:length(Accobdprune)];
end


%%
chk=length(ARN)
if chk>size
ARN=ARN(1:size);
x0=[1:size];
else
x0=[1:length(ARN)];
end


%%

chk=length(AEG)
if chk>size
AEG=AEG(1:size);
x1=[1:size];
else
x1=[1:length(AEG)];
end

%%

chk=length(ASM)
if chk>size
ASM=ASM(1:size);
x2=[1:size];
else
x2=[1:length(ASM)];
end

%%

chk=length(AWS)
if chk>size
AWS=AWS(1:size);
x3=[1:size];
else
x3=[1:length(AWS)];
end

%%
chk=length(AUCBDraw)
if chk>size
AUCBDraw=AUCBDraw(1:size);
x4=[1:size];
else
x4=[1:length(AUCBDraw)];
end
%%

%x2=[1:length(ATSDrawing)];
chk=length(ATSDrawing)
if chk>size
ATSDrawing=ATSDrawing(1:size);
x5=[1:size];
else
x5=[1:length(ATSDrawing)];
end


%plot(x0,ARN,x1,AEG,x2,ASM,x3,AWS,x4,AUCBDraw,x5,ATSDrawing);


%%
%plot(x0,ARN,'DisplayName','Random');

plot(x1,AEG,'DisplayName','Epsilon Greedy');
hold on

plot(x2,ASM,'DisplayName','SoftMax');
plot(x3,AWS,'DisplayName','Win Stay');
plot(x4,AUCBDraw,'DisplayName','UCB1');
plot(x5,ATSDrawing,'DisplayName','Thompson Sampling');
plot(xs,Accobsprune,'DisplayName','OBS');
plot(xd,Accobdprune,'DisplayName','OBD');


hold off
%%
grid on;
grid minor;
title('Different Multi Armed Bandit techniques');
xlabel('Number of Removed Weights');
ylabel('Test Error');
legend('show');
%%
save('DrawAllData');