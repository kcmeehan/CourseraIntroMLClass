function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%

% Add ones to the X data matrix
X = [ones(m, 1) X]; % size: 5000 x 401

% Compute the activation values for the hidden layer
a1 = sigmoid(X * Theta1'); % size: 5000 x 25

% Compute the activation values for the output layer
a1 = [ones(m, 1) a1]; % size: 5000 x 26
a2 = sigmoid(a1 * Theta2'); % size: 5000 x 10

% Compute the prediction
[val, ind] = max(a2');
p = ind';

% =========================================================================


end
