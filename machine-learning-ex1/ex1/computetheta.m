function theta = computetheta(X, y, alpha, theta, m, j)

  val = 0;
  for i = 1:m
    val = val + (X(i,:)*theta - y(i,1))*X(i,j); 
  end
  
  theta(j) = theta(j) - alpha*(1/m)*val;
  theta;

end