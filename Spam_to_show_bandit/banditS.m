%Script file to run the N-armed bandit using the softmax strategy

%Initialize Actual Payoffs, Number of times to play, initial value of tau
NumMachines=10;
ActQ=randn(NumMachines,1);  %10 machines
NumPlay=1000;                %Play 100 times
Initialtau=10;                      %Initial value of temperature ("High in beginning")
Endingtau=0.5;
tau=10;
NumPlayed=zeros(NumMachines,1);  %Keep a running sum of the number of times each action is selected
ValPlayed=zeros(NumMachines,1);  %Keep a running sum of the total reward for each action
EstQ=zeros(NumMachines,1);
PayoffHistory=zeros(NumPlay,1);  %Keep a record of our payoffs

for i=1:NumPlay
    
    %Pick a machine to play:
    a=softmax(EstQ,tau);
    %fprintf('A = %d\n', a);
        %fprintf('size of A = %d\n', size(a));

    %Play the machine and update EstQ, tau
    Payoff=randn+ActQ(a);
    NumPlayed(a)=NumPlayed(a)+1;
    ValPlayed(a)=ValPlayed(a)+Payoff;
    EstQ(a)=ValPlayed(a)/NumPlayed(a);
    PayoffHistory(i)=Payoff;
    tau=Initialtau*(Endingtau/Initialtau)^(i/NumPlay);
end
[v,winningmachine]=max(ActQ)
NumPlayed
plot(1:10,ActQ,'k',1:10,EstQ,'r')