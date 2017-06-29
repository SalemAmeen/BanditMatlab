function [idxW]=banditNormalGreedy(M,V, E,SizeOfWeight,maxExplore)

                 [j,idxW] = max(V(:));
             while j> maxExplore
                 %fprintf('stuck here %d\n',j);
                 V(idxW)=0;
                 [j,idxW] = max(V(:));
             end
                 

[jj,idxW] = max(M(:));  
[ee,tt] = min(M(:));  


if (jj==0)
        idxW=randi(SizeOfWeight);

elseif  (ee==0)
    idxW=tt;
    
else
    
        [jj,idxW] = max(M(:));   


end