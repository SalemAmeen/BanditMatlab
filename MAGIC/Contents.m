%                                NNSYSID
%                       
%           NEURAL NETWORK BASED SYSTEM IDENTIFICATION TOOLBOX
%
%                             Version 2.0
%                         
%                       Department of Automation
%                           Building 326
%                         2800 Kgs. Lyngby, Denmark
%                        
%                   Technical University of Denmark
%
%                                --OO--
%
%
%FUNCTIONS FOR TRAINING NETWORKS:
%batbp    : Batch version of the back-propagation algorithm.
%igls     : Iterated generalized least squares training of multi-output networks.
%incbp    : Recursive (/incremental) version of back-propagation.
%marq     : Levenberg-Marquardt method.
%marqlm   : Memory-saving implementation of the Levenberg-Marquardt method.
%rpe      : Recursive prediction error (Gauss-Newton) method.
%
%
%FUNCTIONS FOR PRETREATING THE DATA:
%dscale   : Scale data to zero mean and variance one.
%
%
%FUNCTIONS FOR TRAINING NETWORKS TO MODEL DYNAMIC SYSTEMS:
%lipschit : Determine the lag space.
%nnarmax1 : Identify a Neural Network ARMAX (or ARMA) model (Linear MA filter).
%nnarmax2 : Identify a Neural Network ARMAX (or ARMA) model.
%nnarx    : Identify a Neural Network ARX (or AR) model.
%nnarxm   : Identify a multi-output Neural Network ARX (or AR) model.
%nnigls   : Iterated generalized LS training of multi-output NNARX models.
%nniol    : Identify a Neural Network model suited for I-O linearization control
%nnoe     : Identify a Neural Network Output Error model.
%nnrarmx1 : Recursive counterpart to NNARMAX1.
%nnrarmx2 : Recursive counterpart to NNARMAX2.
%nnrarx   : Recursive counterpart to NNARX.
%nnssif   : Identify a NN State Space Innovations form model.
%
%
%FUNCTIONS FOR PRUNING NETWORKS:
%netstruc : Extract weight matrices from matrix of parameter vectors.
%nnprune  : Prune models of dynamic systems with Optimal Brain Surgeon (OBS).
%obdprune : Prune feed-forward networks with Optimal Brain Damage (OBD).
%obsprune : Prune feed-forward networks with Optimal Brain Surgeon (OBS).
%
%
%FUNCTIONS FOR EVALUATING TRAINED NETWORKS:
%fpe      : FPE estimate of the generalization error for feed-forward nets.
%ifvalid  : Validation of models generated by NNSSIF.
%ioleval  : Validation of models generated by NNIOL.
%kpredict : k-step ahead prediction of network output.
%loo      : Leave-One-Out estimate of generalization error for feed-forward nets
%nneval   : Validation of feed-forward networks (trained by marq,rpe,bp).
%nnfpe    : FPE for I/O models of dynamic systems.
%nnloo    : Leave-One-Out estimate of generalization error for NNARX models.
%nnsimul  : Simulate model of dynamic system from control sequence alone.
%nnvalid  : Validation of I/O models of dynamic systems.
%wrescale : Rescale weights of trained network.
%xcorrel  : High-order cross-correlation functions to test independence.
%
%
%MISCELLANOUS FUNCTIONS:
%README   : Installation information.
%Contents : Contents file.
%Crossco  : Calculate correlation coefficients.
%drawnet  : Draws a two layer neural network.
%getgrad  : Derivative of network outputs w.r.t. the weights.
%pmntanh  : Fast tanh function.
%settrain : Set parameters for training algorithms.
%
%
%DEMOS:
%test1    : Demonstrates different training methods on a curve fitting example.
%test2    : Demonstrates the NNARX function.
%test3    : Demonstrates the NNARMAX2 function.
%test4    : Demonstrates the NNSSIF function.
%test5    : Demonstrates the NNOE function.
%test6    : Demonstrates the effect of regularization by weight decay.
%test7    : Demonstrates pruning by OBS on the sunspot benchmark problem.
%
%
%OTHER FILES IN DIRECTORY
%pmnshow, test6mat, test7mat, and solplet.asc are used by the test programs.