function [idxW,As,Q,R]=banditE(N,Aq,E)


%FUNCTION [As,Q,R]=banditE(N,Aq,E)
%  Performs the N-armed bandit example using epsilon-greedy
%    strategy.
%  Inputs:
%        N=number of trials total
%        Aq=Actual rewards for each bandit (these are the mean rewards)
%        E=epsilon for epsilon-greedy algorithm
%  Outputs:
%        As=Action selected on trial j, j=1:N
%        Q are the reward estimates
%        R is N x 1, reward at step j, j=1:N

numbandits=length(Aq);       %Number of Bandits
ActNum=zeros(numbandits,1);  %Keep a running sum of the number of times
                             %  each action is selected.
ActVal=zeros(numbandits,1);  %Keep a running sum of the total reward
                             %  obtained for each action.
Q=zeros(1,numbandits);       %Current reward estimates
As=zeros(N,1);               %Storage for action
R=zeros(N,1);                %Storage for averaging reward
idxW=0;
%*********************************************************************
%  Set up a flag so we know when to choose at random (using epsilon)
%*********************************************************************
greedy=zeros(1,N);
if E>0
   m=round(E*N);  %Total number of times we should choose at random
   greedy(1:m)=ones(1,m);
   m=randperm(N);
   greedy=greedy(m);
   clear m
end
if E>=1
    error('The epsilon should be between 0 and 1\n');
end
%********************************************************************
%
%  Now we're ready for the main loop
%********************************************************************
for j=1:N
    %STEP ONE:  SELECT AN ACTION  (cQ) , GET THE REWARD  (cR) !
        if greedy(j)>0
            cQ=ceil(rand*numbandits);
            cR=randn+Aq(cQ);
            idxW=cQ;
             %fprintf('index at rand: %d\n',cQ );

        else
            [val,idx]=find(Q==max(Q));
            m=ceil(rand*length(idx));  %Choose a max at random
            cQ=idx(m);
            cR=randn+Aq(cQ);
            idxW=cQ;

                        %fprintf('index at max: %d\n',cQ );

        end
        R(j)=cR;

    %UPDATE FOR NEXT GO AROUND!
        As(j)=cQ;
        ActNum(cQ)=ActNum(cQ)+1;
        ActVal(cQ)=ActVal(cQ)+cR;
        Q(cQ)=ActVal(cQ)/ActNum(cQ);
end
