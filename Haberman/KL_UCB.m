function [idxW]=KL_UCB(R,V,totalAction)


             %%
       variant = false;
       c=0;
       
            if any(V==0)
                idxW = find(V==0, 1);
                ucb = ones(size(V));
                %%
            else
                if (variant)
                    ucb = klIC(R./self.N, (log(totalAction./R) ...
                      + c*log(log(totalAction)))./V);
                else
                    ucb = klIC(R./V, ...
                      (log(totalAction) + c*log(log(totalAction)))./V);
                end
                m = max(ucb); I = find(ucb == m);
                idxW = I(1+floor(length(I)*rand));
            end
             
             
             %%
function qM = klIC(p, d)
    lM = p; uM = min(1,p+sqrt(d/2)); % ones(size(p));
    for j = 1:16
        qM = (uM+lM)/2;
        down = kl(p,qM) > d;
        uM(down) = qM(down);
        lM(~down) = qM(~down);
    end
    qM = uM;
end

function y = kl(p,q)
  p = max(p, eps); p = min(p, 1-eps);  
  q = max(q, eps); q = min(q, 1-eps);
  y = p.*log(p./q) + (1-p).*log((1-p)./(1-q));
end

% This is much longer (using fzero)...
function qM = klIC_alt(p, d)
    if (kl_shift(p,1,d) <= 0)
        qM = 1;
    else
        lM = p; uM = min(1,p+sqrt(d/2));
        options = optimset('TolX',1e-5);
        qM = fzero(@(q) kl_shift(p,q,d), [lM uM], options);
    end
end

function y = kl_shift(p,q,d)
  y = kl(p,q)-d;
end
end
