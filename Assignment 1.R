# Homework assignment 1

# The text file DATA.txt contains data on the amount of time students from three high schools
# (s = 1, 2, 3) spent on studying or homework during an exam period. For each school we use
# the Gaussian model

# SCHOOL s=1
Y1 = c(2.11,9.75,13.88,11.3,8.93,15.66,16.38,4.54,8.86,11.94,12.47,11.11,11.65,14.53,9.61,7.38,3.34,9.06,9.45,5.98,7.44,8.5,1.55,11.45,9.73)

# SCHOOL s=2
Y2 = c(0.29,1.13,6.52,11.72,6.54,5.63,14.59,11.74,9.12,9.43,10.64,12.28,9.5,0.63,15.35,5.31,8.49,3.04,3.77,6.22,2.14,6.58,1.11)

# SCHOOL s=3
Y3 = c(4.33,7.77,4.15,5.64,7.69,5.04,10.01,13.43,13.63,9.9,5.72,5.16,4.33,12.9,11.27,6.05,0.95,6.02,12.22,12.85)


# For each school generate a posterior sample of size T = 20, 000 
# and use the posterior samples to Monte Carlo approximate the following:



# part a.)   #################################################

gibbs_mean <- function(y, T) {
  n <- length(y)
  yHat <- mean(y)
  
  mu_store <- numeric(T)
  sigma_store <- numeric(T)
  
  mu <- 5
  tau <- 1
  
  for (t in 1:T) {
    #  mu | tau, y
    Vn <- 1 / (n * tau + 1/4)
    mn <- Vn * (n * tau * yHat + 5/4)
    mu <- rnorm(1, mn, sqrt(Vn))
    
    # tau | mu, y
    shape <- 1 + n/2
    rate <- 4 + 0.5 * sum((y - mu)^2)
    tau <- rgamma(1, shape = shape, rate = rate)
    
    mu_store[t] <- mu
    sigma_store[t] <- 1 / sqrt(tau)
  }
  
  return(c(mean(mu_store), mean(sigma_store)))
    
}

T = 20000

means1 <- gibbs_mean(Y1, T)
means2 <- gibbs_mean(Y2, T)
means3 <- gibbs_mean(Y3, T)

means1
means2
means3


#Part b.)   ###########################################################

gibbs <- function(y, T) {
  n <- length(y)
  yHat <- mean(y)
  
  mu_store <- numeric(T)
  sigma_store <- numeric(T)
  
  mu <- 5
  tau <- 1
  
  for (t in 1:T) {
    #  mu | tau, y
    Vn <- 1 / (n * tau + 1/4)
    mn <- Vn * (n * tau * yHat + 5/4)
    mu <- rnorm(1, mn, sqrt(Vn))
    
    # tau | mu, y
    shape <- 1 + n/2
    rate <- 4 + 0.5 * sum((y - mu)^2)
    tau <- rgamma(1, shape = shape, rate = rate)
    
    mu_store[t] <- mu
    sigma_store[t] <- 1 / sqrt(tau)
  }
  
  return(list(mu = mu_store, sigma = sigma_store))
  
}

T = 20000

dist1 <- gibbs(Y1, T)
dist2 <- gibbs(Y2, T)
dist3 <- gibbs(Y3, T)


CI_mu1 <- quantile(dist1$mu, c(0.025, 0.975))
CI_mu2 <- quantile(dist2$mu, c(0.025, 0.975))
CI_mu3 <- quantile(dist3$mu, c(0.025, 0.975))

CI_sigma1 <- quantile(dist1$sigma, c(0.025, 0.975))
CI_sigma2 <- quantile(dist2$sigma, c(0.025, 0.975))
CI_sigma3 <- quantile(dist3$sigma, c(0.025, 0.975))

CI_mu1
CI_mu2
CI_mu3
CI_sigma1
CI_sigma2
CI_sigma3


# Part c)   ###################################################

mu1 <- dist1$mu
mu2 <- dist2$mu
mu3 <- dist3$mu


p_123 <- mean(mu1 < mu2 & mu2 < mu3)
p_132 <- mean(mu1 < mu3 & mu3 < mu2)
p_213 <- mean(mu2 < mu1 & mu1 < mu3)
p_231 <- mean(mu2 < mu3 & mu3 < mu1)
p_312 <- mean(mu3 < mu1 & mu1 < mu2)
p_321 <- mean(mu3 < mu2 & mu2 < mu1)

p_123
p_132
p_213
p_231
p_312
p_321

# Part d) ##################################################

sigma1 <- dist1$sigma
sigma2 <- dist2$sigma
sigma3 <- dist3$sigma

# generaing y's

y1_tilde <- rnorm(T, mu1, sigma1)
y2_tilde <- rnorm(T, mu2, sigma2)
y3_tilde <- rnorm(T, mu3, sigma3)

p_y123 <- mean(y1_tilde < y2_tilde & y2_tilde < y3_tilde)
p_y132 <- mean(y1_tilde < y3_tilde & y3_tilde < y2_tilde)
p_y213 <- mean(y2_tilde < y1_tilde & y1_tilde < y3_tilde)
p_y231 <- mean(y2_tilde < y3_tilde & y3_tilde < y1_tilde)
p_y312 <- mean(y3_tilde < y1_tilde & y1_tilde < y2_tilde)
p_y321 <- mean(y3_tilde < y2_tilde & y2_tilde < y1_tilde)

p_y123
p_y132
p_y213
p_y231
p_y312
p_y321

# part e.)  ################################################

mu1 <- dist1$mu
mu2 <- dist2$mu
mu3 <- dist3$mu

mu1_larger <- mean(mu2 < mu1 & mu3 < mu1)

mu1_larger

#part f.) ################################################

y1_tilde <- rnorm(T, mu1, sigma1)
y2_tilde <- rnorm(T, mu2, sigma2)
y3_tilde <- rnorm(T, mu3, sigma3)

y1_larger <- mean(y2_tilde < y1_tilde & y3_tilde < y1_tilde)

y1_larger



