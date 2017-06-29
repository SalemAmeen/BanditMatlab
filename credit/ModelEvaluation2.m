load('modelEvaluationSmall.mat');  
load('modelEvaluationForTesting.mat'); %for Y2

load('modelEvaluationSmall.mat');  

load('PHI2');
[Yhat,E,NSSE_te2] = nneval(NetDef,W1,W2,PHI2,Y2,1);
  fprintf('Test Error : %d\n',NSSE_te2);
  %%
   NN = [57]; % number of input dimensition
     NetDef = ['HHHHHHHH';'L-------']; % hhh number of hidden layer W1 first coloumn 

   trparms = settrain;
  trparms=settrain(trparms,'maxiter',800,'D',[0.01 0.02]);

 %[thd,NSSEvec,FPEvec,NSSEtestvec,def,pv]=...
          %nnprune('nnarx',NetDef,W1,W2,[],y1,NN,trparms,[50 0],[],y2);
      
   [thd,NSSEvec,FPEvec,NSSEtestvec,def,pv]=...
          obsprune(NetDef,W1,W2,[],Y1,NN,trparms,[0 0],[],Y2);   
      
      %obsprune(NetDef,W1,W2,PHI,Y,trparms,prparms,PHI2,Y2)