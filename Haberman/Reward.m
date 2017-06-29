function [ reward ] = Reward( it, type )
global D theta_star Sigma
%REWARD Returns reward from feed it
switch type
    case 'linear'
        reward = random('Normal',dot(theta_star,D(it,:)),Sigma(it));
    case 'rbf'
        reward = random('Normal',exp( - dot(D(it,:),D(it,:)) ),Sigma(it));
    case 'poly'
        % Get Poly-Features
        [~, length] = size(D);
        DP = zeros(length*(length-1)/2);
        incr = 1;
        for i = 1:length
            for j = i:length
                DP(incr) = D(it,i)*D(it,j);
                incr = incr+1;
            end
        end      
        %Get reward
        reward = random('Normal',dot(theta_star,DP),Sigma(it));
end


