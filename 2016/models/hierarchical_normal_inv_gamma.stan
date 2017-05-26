# Hierarchical Normal Model (within group variability constant across groups)
#
# Parameters:
#   k: number of groups
#   n: sample sizes for each groups
#   max_n: largest group sample size
#   y: todo
#   bg_mu_mu: between group mean prior - mean
#   bg_mu_s2: between group mean prior - variance
#   bg_s2_a: between group sampling variability prior - a
#   bg_s2_b: between group sampling variability prior - b
#   wg_s2_a: within group sampling variability prior - a
#   wg_s2_b: within group sampling variability prior - b
#
# Returns:
#   todo

data {
  int<lower=2> k;
  int<lower=1> n[k];
  int<lower=1> max_n;
  matrix[max_n, k] y;

  # between group priors
  real bg_mu_mu;
  real<lower=0> bg_mu_s2;

  real<lower=0> bg_s2_a;
  real<lower=0> bg_s2_b;

  # within group priors
  real<lower=0> wg_s2_a;
  real<lower=0> wg_s2_b;
}

parameters {
  # between group parameters
  real bg_mu;
  real<lower=0> bg_s2;

  # within group parameters
  real wg_mu[k];
  real<lower=0> wg_s2;
}

model {
  bg_mu ~ normal(bg_mu_mu, sqrt(bg_mu_s2));
  bg_s2 ~ inv_gamma(bg_s2_a, bg_s2_b);
  wg_s2 ~ inv_gamma(wg_s2_a, wg_s2_b);

  for (group_i in 1:k) {
    wg_mu[group_i] ~ normal(bg_mu, sqrt(bg_s2));

    for (sample_i in 1:n[group_i])
      y[sample_i, group_i] ~ normal(wg_mu[group_i], sqrt(wg_s2));
  }
}

#generated quantities {
#}
