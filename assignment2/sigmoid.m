function g = sigmoid(z)

g= ones(size(z)) ./(ones(size(z))+ exp(-z)) ;

end
