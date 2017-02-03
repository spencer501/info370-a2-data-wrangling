# File containing functions for various segregation metrics
#

# Gini
gini <- function(city) {

    t <- city$pop
    p <- city$pct.not.white
    x <- city$pop.not.white


    i.j <- expand.grid(1:nrow(city), 1:nrow(city))

    topSum <- function(i, j) {
        sum(t[i] * t[j] * abs(p[i] - p[j]))
    }

    index <- topSum(i.j[, 1], i.j[, 2]) / (2 * sum(t)**2 * (sum(x)/sum(t))*(1-(sum(x)/sum(t))))

    return(index)
}
