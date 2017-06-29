function [idxW]=banditBysesian_UCB(R,V,totalAction)


             %%
       
            if any(V==0)
                idxW = find(V==0, 1);
                quantiles = ones(size(V));
            else
                quantiles = betaincinv(1-1/(totalAction),R+1,V-R + 1);
                % Using beta quantile
                m = max(quantiles); I = find(quantiles == m);
                idxW = I(1+floor(length(I)*rand));
            end
             
             
             %%

end
