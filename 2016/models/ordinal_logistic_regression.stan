# Ordinal Logistic Regression
#
# Parameters:
#   n: sample size
#   k: number of classes
#   d: number of regressors
#   y: vector of target variables of shape (n,)
#   x: data matrix of shape (n, d)
#
# Generates:
#   y_rep: posterior predictive datasets of size n

data {
  int<lower=0> n;
  int<lower=2> k;
  int<lower=1> d;
  int<lower=1, upper=k> y[n];
  row_vector[d] x[n];
}

parameters {
  vector[d] beta;
  ordered[k-1] threshold;
}

model {
  for (i in 1:n)
    y[i] ~ ordered_logistic(x[i] * beta, threshold);
}

generated quantities {
  int<lower=1, upper=k> y_rep[n];

  for (i in 1:n)
    y_rep[i] = ordered_logistic_rng(x[i] * beta, threshold);
}
