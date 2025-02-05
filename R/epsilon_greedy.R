
# =============================

init_epsilon_greedy <- function(k, epsilon=0.25) {
  epsilon <- as.double(epsilon)
  k <- as.integer(k)

  Mu <- rep(Inf, k)
  Nu <- rep.int(0, k)
  t <- 1
  list(
    epsilon = epsilon,
    k = k,
    Mu = Mu,
    Nu = Nu,
    t = t
  )
}

choose_epsilon_greedy <- function() {
  if (t <= k) {
    list(which = t, why = "explore")
  }
  else {
    whatdo <- exploit_or_not(epsilon)
    which <- switch(
      whatdo,
      "exploit" = which.max(Mu),
      "explore" = sample(1:k, size = 1, replace = TRUE)
    )
    list(which = which, why = whatdo)
  }
}

receive_epsilon_greedy <- function(arm, reward) {
  if (Nu[arm] == 0) {
    Mu[arm] <<- reward
  }
  else {
    Mu[arm] <<- ((Mu[arm] * Nu[arm] + reward) / (Nu[arm] + 1))
  }
  Nu[arm] <<- Nu[arm] + 1
  t <<- t + 1
}

exploit_or_not <- function(epsilon) {
  sample(
    c("exploit", "explore"),
    size = 1,
    replace = TRUE,
    prob = c(1 - epsilon, epsilon)
  )
}


