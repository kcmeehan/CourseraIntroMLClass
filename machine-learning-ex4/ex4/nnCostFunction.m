function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
X  = [ones(m, 1) X]; %% size: 5000 x 401
Y = zeros(m, 10); %% size: 5000 x 10

%% Forward propagation
z2 = X * Theta1';
a2 = sigmoid(z2); %% size: 5000 x 25
a2 = [ones(m, 1) a2]; %% size: 5000 x 26
a3 = sigmoid(a2 * Theta2'); %% size: 5000 x 10
h = a3; %% 5000 x 10

for i=1:m
  index = y(i);	
	Y(i, index) = 1;
  yvec  = Y(i, :); %% size: 1 x 10
	hvec  = h(i, :); %%1 X 10
	J = J -(yvec*log(hvec') + (1-yvec)*log((1-hvec)'))/m;
end

Theta1_temp = Theta1(:, 2:input_layer_size+1);
Theta2_temp = Theta2(:, 2:hidden_layer_size+1);
Theta1_sq = Theta1_temp.^2;
Theta2_sq = Theta2_temp.^2;
Theta1_sum = sum(Theta1_sq(:));
Theta2_sum = sum(Theta2_sq(:));

J = J + lambda/(2*m) * (Theta1_sum + Theta2_sum);

% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.

%% Determining dJ/dTheta(2):
delta_3 = zeros(m, num_labels);
Delta_2 = zeros(num_labels, hidden_layer_size + 1);

delta_3 = a3 - Y; 
Delta_2 = delta_3' * a2;
Theta2_grad = Delta_2./m;

%% Determining dJ/dTheta(1):
delta_2 = zeros(m, hidden_layer_size + 1);
Delta_1 = zeros(hidden_layer_size, input_layer_size + 1);

delta_2 = delta_3 * Theta2; %%size: 5000 x 26
z2 = [ones(m, 1) z2];
delta_2 = delta_2 .* sigmoidGradient(z2);
Delta_1 = delta_2' * X;
Theta1_grad = Delta_1./m;



%for i=1:m


%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%



















% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
