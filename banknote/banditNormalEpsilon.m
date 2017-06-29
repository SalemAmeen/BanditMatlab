function [idxW]=banditNormalEpsilon(M,V, E,SizeOfWeight,maxExplore)

                 [j,idxW] = max(V(:));
             while j> maxExplore
                 %fprintf('stuck here %d\n',j);
                 V(idxW)=0;
                 [j,idxW] = max(V(:));
             end
                 


if(E > rand()) % Explore
    
    [jj,itest] = max(M(:));
    
    ii=randi(SizeOfWeight);
    while ii==itest
            ii=randi(SizeOfWeight);
    end
    
        idxW=ii;

else % Exploit
    
             [jj,idxW] = max(M(:));   


end