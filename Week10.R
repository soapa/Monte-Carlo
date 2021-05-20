sigma <- 0.5
ndays <- 90 
S0 <- 100 # Starting stock price 
mu <- 0.05 # Stock drift rate per year 
dT <- 1/365 
niters <- 5000 # Number of Monte carlo simulations to do 
strike <- 105
knockoutlevel <- 130
stock.prices <- list()
S90 <- c()
option.payoff.arr <- c()
set.seed(6124)

for(j in 1:niters) { 
   N = rnorm(ndays) 
   S = S0
   S_arr <- c(S0) 
   for(i in 1:ndays) { 
      dS = S*(mu*dT + sigma*sqrt(dT)*N[i])
      S = S + dS
      S_arr <- c(S_arr, S)
   } 
 
   S90 <- c(S90, S)
   stock.prices[[j]] <- S_arr
   
   # For a call option, if the stock price at expiry is 
   # higher than strike price, then we profit 
   # Otherwise, we don't exercise the option 
   
   option.payoff = max(S-strike,0)
   option.payoff.arr <- c(option.payoff.arr, option.payoff)
} 
vanilla.pricing.arr <- option.payoff.arr
for(i in 1:niters) { 
  if (max(stock.prices[[i]])>knockoutlevel){
  option.payoff.arr[i] <- 0
  }
}
exotic.pricing.arr <- option.payoff.arr
vanilla.pricing <- mean(vanilla.pricing.arr)
exotic.pricing <- mean(exotic.pricing.arr)

#library(RColorBrewer)
#palette <- brewer.pal(7,"Dark2")
#plot(stock.prices[[1]], type = "l", lwd = 2, col = palette[1], ylim = c(20,170), xlab = "days", ylab = "Price")
#points(stock.prices[[2]], type = "l", lw = 2,col = palette[2])
#points(stock.prices[[3]], type = "l", lw = 2,col = palette[3])
#points(stock.prices[[4]], type = "l", lw = 2,col = palette[4])
#points(stock.prices[[5]], type = "l", lw = 2,col = palette[5])


length(vanilla.pricing.arr[which(vanilla.pricing.arr>160)])

#For vanilla call option. There is no price >200, so to make the chart readable, only show the price <200.
#For exotic call option, the price >30 is impossible, so only show the price <30. In fact the max value is <25.

hist(vanilla.pricing.arr, n = 50, xlim = c(0,200),main = "Vanilla call option price")
hist(exotic.pricing.arr, n = 50, xlim = c(0,30),main = "Exotic call option price")
mean(vanilla.pricing.arr)
mean(exotic.pricing.arr)


#From the chart and the mean we can know the price of this exotic call option is much lower than vanilla call option.
