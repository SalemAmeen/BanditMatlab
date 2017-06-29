 alpha = 0.01; method = 'biweight';
 for n= 1:5; X = randn(20,1); X([2 5 10]) = X([1 5 10])*10; X(13:18) = NaN;
 [Index] = find_outliers_Thompson(X, alpha, method, 1), end