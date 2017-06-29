function [PSI,E]=getgrad(method,NetDef,NN,W1,W2,Chat,Y,U)
%  GETGRAD
%  -------
%          Produces a matrix of derivatives of network output w.r.t.
%          each network weight for use in the functions NNPRUNE and NNFPE.
%
%  Call: 
%  Network generated by nnarx (or nnrarx):
%           [PSI,E] = getgrad('nnarx',NetDef,NN,W1,W2,[],Y,U)
%
%  Network generated by nnarmax1 (or nnrarmx1):
%           [PSI,E] = getgrad('nnarmax1',NetDef,NN,W1,W2,Chat,Y,U)
%
%  Network generated by nnarmax2 (or nnrarmx2):
%           [PSI,E] = getgrad('nnarmax2',NetDef,NN,W1,W2,[],Y,U)
%
%  Network generated by nnoe:
%           [PSI,E] = getgrad('nnoe',NetDef,NN,W1,W2,[],Y,U)
%
%  NB: For time series, U is left out!
% 
%  Programmed by : Magnus Norgaard, IAU/EI/IMM, Technical Univ. of Denmark
%  LastEditDate  : Sep. 8, 1995


% >>>>>>>>>>>>>>>>>>>>>>>>>>>>      GET PARAMETERS     <<<<<<<<<<<<<<<<<<<<<<<<<<<< 
if strcmp(method,'nnarx') | strcmp(method,'nnrarx'),
  mflag=1;
elseif strcmp(method,'nnarmax1') | strcmp(method,'nnrarmx1'),
  mflag=2;
elseif strcmp(method,'nnarmax2') | strcmp(method,'nnrarmx2'),
  mflag=3;
elseif strcmp(method,'nnoe'),
  mflag=4;
else
  disp('Unknown method!!!!!!!!');
  return
end


% >>>>>>>>>>>>>>>>>>>>>>>>>>>>     INITIALIZATIONS     <<<<<<<<<<<<<<<<<<<<<<<<<<<< 
Ndat     = length(Y);                   % # of data
na = NN(1);

% ---------- NNARX model ----------
if mflag==1 | mflag==4,
  if length(NN)==1                      % nnar model
    nb = 0;
    nk = 0;
    nu = 0;
  else                                  % nnarx or nnoe model
    [nu,N] = size(U); 
    nb = NN(2:1+nu); 
    nk = NN(2+nu:1+2*nu);
  end
  nc = 0;

% --------- NNARMAX1 model --------
elseif mflag==2 | mflag==3,
  if length(NN)==2                      % nnarma model
    nc     = NN(2);
    nb     = 0;
    nk     = 0;
    nu     = 0;
  else                                  % nnarmax model
    [nu,Ndat]= size(U); 
    nb     = NN(2:1+nu);
    nc     = NN(2+nu);
    nk     = NN(2+nu+1:2+2*nu);
  end
end


% --------- Common initializations --------
nmax     = max([na,nb+nk-1,nc]);        % 'Oldest' signal used as input to the model
N        = Ndat - nmax;                 % Size of training set
nab      = na+sum(nb);                  % na+nb
nabc     = nab+nc;                      % na+nb+nc
outputs     = 1;                        % Only MISO models considered
L_hidden = find(NetDef(1,:)=='L')';     % Location of linear hidden neurons
H_hidden = find(NetDef(1,:)=='H')';     % Location of tanh hidden neurons
L_output = find(NetDef(2,:)=='L')';     % Location of linear output neurons
H_output = find(NetDef(2,:)=='H')';     % Location of tanh output neurons
[hidden,inputs] = size(W1);
inputs          = inputs-1;
E        = zeros(outputs,N);
y1       = zeros(hidden,N);
y1       = [y1;ones(1,N)];
Yhat     = zeros(outputs,N);
index = outputs*(hidden+1) + 1 + [0:hidden-1]*(inputs+1); % A useful vector!
index2  = (0:N-1)*outputs;              % Yet another useful vector
ones_h   = ones(hidden+1,1);            % A vector of ones
ones_i   = ones(inputs+1,1);            % Another vector of ones
parameters = (inputs+1)*hidden+(hidden+1)*outputs; % Total # of weights
PSI      = zeros(parameters,outputs*N); % Deriv. of each output w.r.t. each weight
RHO      = zeros(parameters,outputs*N); % Partial derivatives


% >>>>>>>>>>>>>>>>>>>>  CONSTRUCT THE REGRESSION MATRIX PHI   <<<<<<<<<<<<<<<<<<<<<
PHI = zeros(nab,N);
jj  = nmax+1:Ndat;
for k = 1:na, PHI(k,:)    = Y(jj-k); end
index4 = na;
for kk = 1:nu,
  for k = 1:nb(kk), PHI(k+index4,:) = U(kk,jj-k-nk(kk)+1); end
  index4 = index4 + nb(kk);
end


% >>>>>>>>>>>>>>>>>>>>>>>>>>   COMPUTE NETWORK OUTPUT   <<<<<<<<<<<<<<<<<<<<<<<<<<<
% ---------- NNARX model ----------
if mflag==1,
  PHI_aug=[PHI;ones(1,N)];
  Y  = Y(nmax+1:Ndat);
  h1 = W1*PHI_aug;  
  y1(H_hidden,:) = pmntanh(h1(H_hidden,:));
  y1(L_hidden,:) = h1(L_hidden,:);
    
  h2 = W2*y1;
  Yhat(H_output,:) = pmntanh(h2(H_output,:));
  Yhat(L_output,:) = h2(L_output,:);

  E     = Y - Yhat;                       % Error between Y and deterministic part

% --------- NNARMAX1 model --------
elseif mflag==2,
  Y  = Y(nmax+1:Ndat);
  PHI_aug=[PHI;ones(1,N)];
  h1 = W1*PHI_aug;  
  y1(H_hidden,:) = pmntanh(h1(H_hidden,:));
  y1(L_hidden,:) = h1(L_hidden,:);
    
  h2 = W2*y1;
  Yhat(H_output,:) = pmntanh(h2(H_output,:));
  Yhat(L_output,:) = h2(L_output,:);

  Ebar     = Y - Yhat;                    % Error between Y and deterministic part
  E        = filter(1,Chat,Ebar);         % Prediction error
  Yhat     = Y - E;                       % One step ahead prediction


% --------- NNARMAX2 model --------
elseif mflag==3,
  Y  = Y(nmax+1:Ndat);
  PHI_aug=[PHI;zeros(nc,N);ones(1,N)];
  for t=1:N,
    h1 = W1*PHI_aug(:,t);  
    y1(H_hidden,t) = pmntanh(h1(H_hidden));
    y1(L_hidden,t) = h1(L_hidden);    

    h2 = W2*y1(:,t);
    Yhat(H_output,t) = pmntanh(h2(H_output,:));
    Yhat(L_output,t) = h2(L_output,:);

    E(:,t) = Y(:,t) - Yhat(:,t);          % Prediction error
    for d=1:min(nc,N-t),
      PHI_aug(nab+d,t+d) = E(:,t);
    end
  end


% ---------- NNOE model ----------
elseif mflag==4,
  Y  = Y(nmax+1:Ndat);
  PHI_aug=[PHI;ones(1,N)];
  for t=1:N,
    h1 = W1*PHI_aug(:,t);;  
    y1(H_hidden,t) = pmntanh(h1(H_hidden));
    y1(L_hidden,t) = h1(L_hidden);    

    h2 = W2*y1(:,t);
    Yhat(H_output,t) = pmntanh(h2(H_output,:));
    Yhat(L_output,t) = h2(L_output,:);

    for d=1:min(na,N-t),
      PHI_aug(d,t+d) = Yhat(:,t);
    end
  end
  E     = Y - Yhat;                       % Error between Y and deterministic part
end


% >>>>>>>>>>>>>>>>>>>>>>>>>>>   COMPUTE THE RHO MATRIX   <<<<<<<<<<<<<<<<<<<<<<<<<<
% Partial derivative of output (y2) with respect to each weight and neglecting
% that the model inputs (the residuals) depends on the weights

  % ==========   Elements corresponding to the linear output units   ============
  for i = L_output'
    index1 = (i-1) * (hidden + 1) + 1;

    % -- The part of RHO corresponding to hidden-to-output layer weights --
    RHO(index1:index1+hidden,index2+i) = y1;
    % ---------------------------------------------------------------------
 
    % -- The part of RHO corresponding to input-to-hidden layer weights ---
    for j = L_hidden',
      RHO(index(j):index(j)+inputs,index2+i) = W2(i,j)*PHI_aug;
    end
     
    for j = H_hidden',
      tmp = W2(i,j)*(1-y1(j,:).*y1(j,:)); 
      RHO(index(j):index(j)+inputs,index2+i) = tmp(ones_i,:).*PHI_aug;
    end 
    % ---------------------------------------------------------------------    
  end

  % ============  Elements corresponding to the tanh output units   =============
  for i = H_output',
    index1 = (i-1) * (hidden + 1) + 1;

    % -- The part of RHO corresponding to hidden-to-output layer weights --
    tmp = 1 - y2(i,:).*y2(i,:);
    RHO(index1:index1+hidden,index2+i) = y1.*tmp(ones_h,:);
    % ---------------------------------------------------------------------
         
    % -- The part of RHO corresponding to input-to-hidden layer weights ---
    for j = L_hidden',
      tmp = W2(i,j)*(1-y2(i,:).*y2(i,:));
      RHO(index(j):index(j)+inputs,index2+i) = tmp(ones_i,:).* PHI_aug;
    end
      
    for j = H_hidden',
      tmp  = W2(i,j)*(1-y1(j,:).*y1(j,:));
      tmp2 = (1-y2(i,:).*y2(i,:));
      RHO(index(j):index(j)+inputs,index2+i) = tmp(ones_i,:)...
                                                .*tmp2(ones_i,:).* PHI_aug;
    end
    % ---------------------------------------------------------------------
  end
  


% >>>>>>>>>>>>>>>>>>>>>>>>>>   COMPUTE THE PHI MATRIX   <<<<<<<<<<<<<<<<<<<<<<<<<<<
% ==================== NNARX model ====================
if mflag==1,
  PSI = RHO;


% ==================== NNARMAX1 model ====================
elseif mflag==2,
    % Partial deriv. of output wrt. each C-par.
      RHO2     = zeros(nc,N);
    for i=1:nc,
      RHO2(i,nmax+i-1:N) = E(1:N-i-nmax+2);
    end
    PSI = [PSI;zeros(nc,N)];
    for i=1:parameters-nc,
      PSI(i,:) = filter(1,Chat,RHO(i,:));
    end
    for i=1:nc,
      PSI(parameters+i,:) = filter(1,Chat,RHO2(i,:)); % PSI_red
    end
  
   

% ==================== NNARMAX2 model ====================
elseif mflag==3,
  dy2de    = zeros(nc,N);                 % Der. of outputs wrt. the past residuals
  index4   = nab+1:nabc;                  % And a fourth
  
    % ---------- Find derivative of output wrt. the past residuals ----------
    for t=1:N,
      dy2dy1 = W2(:,1:hidden);
      for j = H_output',
        dy2dy1(j,:) = W2(j,1:hidden)*(1-y2(j,t).*y2(j,t));
      end

      % Matrix with partial derivatives of the output from each hidden neurons with
      % respect to each input:
      dy1de = W1(:,index4);
      for j = H_hidden',
        dy1de(j,:) = W1(j,index4)*(1-y1(j,t).*y1(j,t));
      end

      % Matrix with partial derivative of each output with respect to each input
      dy2de(:,t)= (dy2dy1 * dy1de)';
    end


    % ---------- Determine PSI by "filtering" ----------
    for t=1:N,
      PSI(:,t)=RHO(:,t);
      for t1=1:min(nc,t-1),
        PSI(:,t)  = PSI(:,t)-dy2de(t1,t)*PSI(:,t-t1);
      end
    end
    

% ==================== NNOE model ====================
elseif mflag==4,

   % ---------- Find derivative of output wrt. the past outputs ----------
  dy2dy    = zeros(na,N);                 % Der. of output wrt. the past outputs
  dy1dy    = zeros(hidden,na);            % Der. of hidden unit outp. wrt. past outputs
    index4   = 1:na;                        % And a fourth
    for t=1:N,
      dy2dy1 = W2(:,1:hidden);
      for j = H_output',
        dy2dy1(j,:) = W2(j,1:hidden)*(1-y2(j,t).*y2(j,t));
      end
      
      % Matrix of partial derivatives of the output from each hidden unit with
      % respect to each input:
      dy1dy(L_hidden,:) = W1(L_hidden,index4);
      for j = H_hidden',
        dy1dy(j,:) = W1(j,index4)*(1-y1(j,t).*y1(j,t));
      end

      % Matrix of partial derivatives of each output with respect to each input
      dy2dy(:,t)= (dy2dy1 * dy1dy)';
    end


    % ---------- Determine PSI by "filtering" ----------
    for t=1:N,
      PSI(:,t)=RHO(:,t);
      for t1=1:min(na,t-1),
        PSI(:,t)  = PSI(:,t)+dy2dy(t1,t)*PSI(:,t-t1);
      end
    end
end
