# Hierarchical Normal Model
#
# Parameters:
#   k: number of groups
#   n: sample sizes for each groups
#   max_n: largest group sample size
#   y: todo
#
# Returns:
#   todo

data {
  int<lower=2> k;
  int<lower=0> n[k];
  int<lower=0> max_n;
  matrix[max_n, k] y;
}

parameters {
  # between group parameters
  # mean
  real bg_mu;
  real<lower=0> bg_s2;
  # variance
  real<lower=0> bg_a;
  real<lower=0> bg_b;

  # within group parameters
  real wg_mu[k];
  real<lower=0> wg_s2[k];
}

model {
  # between group parameters priors
  # mean
  bg_mu ~ normal(0, sqrt(1e4));
  bg_s2 ~ inv_gamma(0.001, 0.001);
  # variance
  bg_a ~ inv_gamma(0.001, 0.001);
  bg_b ~ inv_gamma(0.001, 0.001);

  # sampling model
  for (group_i in 1:k) {
    wg_mu[group_i] ~ normal(bg_mu, sqrt(bg_s2));
    wg_s2[group_i] ~ inv_gamma(bg_a, bg_b);

    for (sample_i in 1:n[group_i])
      y[sample_i, group_i] ~ normal(wg_mu[group_i], sqrt(wg_s2[group_i]));
  }
}

#generated quantities {
#}
