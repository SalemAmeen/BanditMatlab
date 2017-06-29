function [idxW]=banditUCB1(R,V,totalAction)

ucb=R./V + sqrt(2  * log (totalAction)./V);

             [M,idxW] = max(ucb(:));   


end
