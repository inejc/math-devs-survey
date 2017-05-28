# Ordinal Logistic Regression
#
# Parameters:
#   todo
#
# Returns:
#   todo

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
