function [ regret ] = Regret( rewards , type )
global D theta_star
%REWARD Returns reward from feed it
[T,~] = size(rewards);
regret = zeros(T,1);
Time = 1:T;


switch type
    case 'linear'
        mu_star = max(D*theta_star);
        regret = mu_star.*Time' - cumsum(rewards);    
        
    case 'rbf'
        mu_star = max( exp(-diag(D*D')) );       
        regret = mu_star.*Time' - cumsum(rewards);
        
    case 'poly'
        % Get Poly-Features
        [I, J] = size(D);
        DP = zeros(I,J*(J-1)/2);
        for k = 1:I
            incr = 1;
            for i = 1:J
                for j = i:J
                    DP(k,incr) = D(k,i)*D(k,j);
                    incr = incr+1;
                end
            end
        end
        %Get reward
        mu_star = max(DP*theta_star);
        regret = mu_star.*Time' - cumsum(rewards);
end

end

