# Hierarchical Normal Model with uninformative priors
# (assumption: within group variability constant across groups)
#
# Parameters:
#   k: number of groups
#   n: sample sizes for each groups
#   max_n: largest group sample size
#   y: data matrix of shape (max_n, k)
#      with zero padding at the end for
#      smaller sample sizes
#
# Generates:
#   mu_rep: sample means of posterior predictive datasets
#           of sizes n[i]

data {
  int<lower=2> k;
  int<lower=1> n[k];
  int<lower=1> max_n;
  matrix[max_n, k] y;
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
  bg_mu ~ normal(0, sqrt(10000));
  bg_s2 ~ inv_gamma(0.001, 0.001);
  wg_s2 ~ inv_gamma(0.001, 0.001);

  for (group_i in 1:k) {
    wg_mu[group_i] ~ normal(bg_mu, sqrt(bg_s2));

    for (sample_i in 1:n[group_i])
      y[sample_i, group_i] ~ normal(wg_mu[group_i], sqrt(wg_s2));
  }
}

generated quantities {
  vector[k] mu_rep;

  for (group_i in 1:k) {
    vector[n[group_i]] y_rep_group;

    for (sample_i in 1:n[group_i])
        y_rep_group[sample_i] = normal_rng(wg_mu[group_i], sqrt(wg_s2));

    mu_rep[group_i] = mean(y_rep_group);
  }
}
