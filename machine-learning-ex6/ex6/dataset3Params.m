function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

% Get values to loop over
%Cvalues = [0.01 0.1 1 10 100 1000];
%sigma_values = [0.01 0.05 0.1 0.5 1 5];
Cvalues = [0.5 1 5];
sigma_values = [0.08 0.1 0.3];
prediction_errors = zeros(length(Cvalues), length(sigma_values));

for i = 1:length(Cvalues)
	for j = 1:length(sigma_values)
		model = svmTrain(X, y, Cvalues(i), @(x1, x2) gaussianKernel(x1, x2, sigma_values(j)));
		predictions = svmPredict(model, Xval);
		prediction_errors(i, j) = mean(double(predictions ~= yval));
end

[colMin, colIndex] = min(min(prediction_errors)); 
[minValue, rowIndex] = min(prediction_errors(:,colIndex));

C = Cvalues(rowIndex);
sigma = sigma_values(colIndex);

% =========================================================================

end
