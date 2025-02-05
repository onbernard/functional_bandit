
# =============================

init_ucb <- function(k, alpha=1) {
  alpha <- as.double(alpha)
  k <- as.integer(k)

  Mu <- rep(Inf, k)
  Nu <- rep.int(0, k)
  t <- 1
  list(alpha=alpha, k=k, Mu=Mu, Nu=Nu, t=t)
}

choose_ucb <- function() {
  indices <- mapply(ucb, Mu, Nu, MoreArgs = list(alpha, t))
  which <- which.max(indices)
  maxucb <- max(indices)
  list(which=which, maxucb=maxucb)
}

receive_ucb <- function(arm, reward) {
  if (Nu[arm] == 0) {
    Mu[arm] <<- reward
  }
  else {
    Mu[arm] <<- ((Mu[arm] * Nu[arm] + reward) / (Nu[arm] + 1))
  }
  Nu[arm] <<- Nu[arm] + 1
  t <<- t+1
}

#' Upper Confidence Bound value of an arm
#'
#' @param mu observed mean
#' @param nu number of trials
#' @param alpha exploration parameter
#' @param t iteration index
#'
#' @return double value
#' @export
#'
ucb <- function(mu, nu, alpha, t) {
  if (nu == 0) {
    Inf
  }
  else {
    mu + alpha * sqrt((2 * log(t)) / nu)
  }
}

