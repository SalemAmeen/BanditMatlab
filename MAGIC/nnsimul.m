function Yhat=nnsimul(method,NetDef,NN,W1,W2,Y,U,obsidx)
%  NNSIMUL
%  -------
%        Simulate a neural network model of a dynamic system from a sequence
%        of controls alone (not using observed outputs). The simulated output
%        is compared to the observed output. For NNARMAX and state space
%        models the residuals are set to 0.
%        
%
%  Call: 
%  Network generated by NNARX (or NNRARX):
%           Ysim = nnsimul('nnarx',NetDef,NN,W1,W2,Y,U)
%  (Likewise for NNOE and NNARMAX1+2)
%
%  Network generated by NNSSIF:
%           Ysim = nnsimul('nnssif',NetDef,nx,W1,W2,Y,U,obsidx)
%
%  Inputs:
%        See NNVALID/IFVALID
%
%  Output:
%        Ysim: Vector containing the simulated outputs.
%
%  NB! Does not work for models generated by NNIOL.

%  Programmed by : Magnus Norgaard, IAU/IMM, Technical Univ. of Denmark
%  LastEditDate  : July 17, 1996

% >>>>>>>>>>>>>>>>>>>>>>>>>>>>      GET PARAMETERS     <<<<<<<<<<<<<<<<<<<<<<<<<<<< 
skip = 1;
if strcmp(method,'nnarx') | strcmp(method,'nnrarx'),
  mflag=1;

elseif strcmp(method,'nnarmax1') | strcmp(method,'nnrarmx1'),
  mflag=2;
 
elseif strcmp(method,'nnarmax2') | strcmp(method,'nnrarmx2'),
  mflag=3;

elseif strcmp(method,'nnoe'),
  mflag=4;
  
elseif strcmp(method,'nnssif')
  mflag=5;

else
  disp('Unknown method!!!!!!!!');
  break
end


% >>>>>>>>>>>>>>>>>>>>>>>>>>>>     INITIALIZATIONS     <<<<<<<<<<<<<<<<<<<<<<<<<<<< 
[ny,Ndat] = size(Y);                     % # of outputs and # of data
[nu,Ndat] = size(U);                     % # of inputs 
na        = NN(1);


% ---------- NNARX/NNOE model ----------
if mflag==1 | mflag==4,
  nb = NN(2:1+nu);
  nc = 0;
  nk = NN(2+nu:1+2*nu);

% --------- NNARMAX1 model --------
elseif mflag==2, 
  nb = NN(2:1+nu);
  nc     = 0;
  nk     = NN(2+nu+1:2+2*nu);

% --------- NNARMAX2 model --------
elseif mflag==3, 
  nb = NN(2:1+nu);
  nc     = NN(2+nu);
  nk     = NN(2+nu+1:2+2*nu);
end
nmax     = max([na,nb+nk-1]);           % 'Oldest' signal used as input to the model
N        = Ndat - nmax;                 % Size of training set
nab      = na+sum(nb);                  % na+nb
nabc     = nab+nc;                      % na+nb+nc
outputs     = 1;                        % Only MISO models considered
  
% --------- NNSSIF model --------
if mflag==5, 
  nx = NN;
  na = nx;
  nab = nx+nu;
  nabc = nab+ny;
  nk      = 1;
  nmax    = 1;                         % 'Oldest' signal used as input to the model
  N       = Ndat - nmax;               % Size of training set
  outputs = ny;
  obsidx=obsidx(:)';                   % Find row indices
  rowidx=obsidx;
  for k=2:ny,
    rowidx(k)=obsidx(k)+rowidx(k-1);
  end
  nrowidx = 1:nx;                      % Not row indices
  nrowidx(rowidx)=[];
  Cidx=[1 rowidx(1:ny-1)+1];
  C = zeros(ny,nx);
  C(1:ny,Cidx)=eye(ny);
end


% --------- Common initializations --------
L_hidden = find(NetDef(1,:)=='L')';     % Location of linear hidden neurons
H_hidden = find(NetDef(1,:)=='H')';     % Location of tanh hidden neurons
L_output = find(NetDef(2,:)=='L')';     % Location of linear output neurons
H_output = find(NetDef(2,:)=='H')';     % Location of tanh output neurons
[hidden,inputs] = size(W1);
inputs          = inputs-1;
y1       = [zeros(hidden,N);ones(1,N)];
Yhat     = zeros(outputs,N);


% >>>>>>>>>>>>>>>>>>>>>>>>>>   COMPUTE NETWORK OUTPUT   <<<<<<<<<<<<<<<<<<<<<<<<<<<
% ---------- NNARX/NNOE/NNARMAX1/NNARMAX2 model ----------
if mflag==1 | mflag==2 | mflag==3 | mflag==4,

% -----  CONSTRUCT THE REGRESSION MATRIX PHI   -----
  PHI_aug = [zeros(nab,N);ones(1,N)];
  jj  = nmax+1:Ndat;
  index = na;
  for kk = 1:nu,
    for k = 1:nb(kk), PHI_aug(k+index,:) = U(kk,jj-k-nk(kk)+1); end
    index = index + nb(kk);
  end
  
  % ----- DETERMINE SIMULATED OUTPUT -----
  for t=1:N,
    h1 = W1(:,[1:nab nabc+1])*PHI_aug(:,t);;  
    y1(H_hidden,t) = pmntanh(h1(H_hidden));
    y1(L_hidden,t) = h1(L_hidden);    

    h2 = W2*y1(:,t);
    Yhat(H_output,t) = pmntanh(h2(H_output,:));
    Yhat(L_output,t) = h2(L_output,:);

    for d=1:min(na,N-t),
      PHI_aug(d,t+d) = Yhat(:,t);
    end
  end

% ---------- State space model ----------
elseif mflag==5,
  % -----  CONSTRUCT THE REGRESSION MATRIX PHI   -----
  PHI = zeros(inputs,N);
  PHI(nx+1:nx+nu,:) = U(:,1:N);
  PHI_aug = [PHI;ones(1,N)];              % Augment PHI with a row containing ones

  % ----- DETERMINE SIMULATED OUTPUT -----
  for t=1:N,
    h1 = W1*PHI_aug(:,t);                 % Hidden neuron outputs
    y1(H_hidden,t) = pmntanh(h1(H_hidden));
    y1(L_hidden,t) = h1(L_hidden);    

    h2 = W2*y1(:,t);                      % Predicted states
    y2(H_output,t) = pmntanh(h2(H_output,:));
    y2(L_output,t) = h2(L_output,:);
    y2(nrowidx,t)  = y2(nrowidx,t) + PHI_aug(nrowidx+1,t);
    Yhat(:,t)      = C*y2(:,t);
  
    for d=1:min(1,N-t),
      PHI_aug(1:nx,t+1) = y2(:,t);
    end
  end
end


% >>>>>>>>>>>>>>>>>>>>>>>>>>      PLOT THE RESULTS      <<<<<<<<<<<<<<<<<<<<<<<<<<<
si = figure-1;
Y = Y(:,nmax+1:Ndat);
for k=1:outputs,
  if outputs>1,
    figure(si+k);
  end
  plot(Y(k,:),'b-'); hold on
  plot(Yhat(k,:),'r--');hold off
  xlabel('time (samples)')
  if outputs==1,
    title('Output (dashed) and simulated output (solid)')
  else
    title(['Output (dashed) and simulated output (solid)  #' int2str(k)])
  end
  grid
end