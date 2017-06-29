function [rewards, pulled] = KernelUCB(T,lambda,delta,K,type)
% Implements KernelUCB on a problem (meaning choice of expected reward
% function) of type 'type', with algorithm parameters lambda and delta,
% up to time T.
global  DK


% initialization
ucb = zeros(K,1);
ucb(1) = 1;

predictions = zeros(K,1);
variances = zeros(K,1);
pulled = zeros(T,1);
rewards = zeros(T,1);


for t=1:T
    
    % pulling the arms
    [~,it]  = max(ucb);
    rt = Reward(it,type);
    
    % tracking
    pulled(t) = it;
    rewards(t) = rt;
    
    %online updatees
    y = rewards(1:t,1);
   
    kx = DK(it,pulled(1:t))';

    % Compute Regularised Kernel Inverse    
    if length(kx)==1
        Kinv = 1./(kx + lambda);
    else
        b = kx(1:end-1);
        bKinv = b'*Kinv;
        Kinvb = Kinv*b;
        
        K22 = 1./((kx(end) + lambda) - bKinv*b);
        K11 = Kinv + K22*Kinvb*bKinv;
        K12 = -K22*Kinvb;
        K21 = -K22*bKinv;
        Kinv = [K11 K12; K21 K22];
    end

    eta = sqrt((log(2*T*K/delta)/(2*lambda)));
    
    % compute UCBs  
    for i = 1:K
        kx = DK(i,pulled(1:t))';
        predictions(i) = kx'*Kinv*y;
        variances(i) = DK(i,i)-kx'*Kinv*kx;
        ucb(i) = predictions(i) + eta*sqrt(variances(i));
    end
    
end
