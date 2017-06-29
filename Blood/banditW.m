%Script file to run the N-armed bandit using the Win-Stay, Lose-Shift strategy

%Initialize Actual Payoffs, Number of times to play, initial value of tau
NumMachines=10;
ActQ=randn(NumMachines,1);  %10 machines
%ActQ=[0.5453,1.0130,-0.2397,-0.5880,-0.4892,0.6382,0.7758,0.4898,0.3438,-1.2270]';
NumPlay=1000;                %Play 100 times
Initialbeta=0.01;                      %Initial value of temperature ("High in beginning")
Endingbeta=0.001;
beta=Initialbeta;
NumPlayed=zeros(NumMachines,1);  %Keep a running sum of the number of times each action is selected
ValPlayed=zeros(NumMachines,1);  %Keep a running sum of the total reward for each action
EstQ=zeros(NumMachines,1);
PayoffHistory=zeros(NumPlay,1);  %Keep a record of our payoffs
Probs=(1/NumMachines)*ones(10,1);

for i=1:NumPlay
    
    %Pick a machine to play:
    [a,Probs]=winstay(EstQ,Probs,beta);
    
    %Play the machine and update EstQ, tau
    Payoff=randn+ActQ(a);
    NumPlayed(a)=NumPlayed(a)+1;
    ValPlayed(a)=ValPlayed(a)+Payoff;
    EstQ(a)=ValPlayed(a)/NumPlayed(a);
    PayoffHistory(i)=Payoff;
    beta=Initialbeta*(Endingbeta/Initialbeta)^(i/NumPlay);
end
[v,winningmachine]=max(ActQ)
NumPlayed
plot(1:10,ActQ,'k',1:10,EstQ,'r')