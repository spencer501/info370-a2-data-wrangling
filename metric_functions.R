# File containing functions for various segregation metrics
#

# Gini Coefficient
giniCoeff <- function(city) {

    t <- city$pop           # total population of each census tract
    p <- city$pct.not.white # ratio of non white population to total population in each census tract
    x <- city$pop.not.white # non white population in each census tract

    # help from: http://stackoverflow.com/questions/11388359/
    combinations <- expand.grid(1:nrow(city), 1:nrow(city))
    i <- combinations[, 1]
    j <- combinations[, 2]

    # inspired by: https://stat.ethz.ch/pipermail/r-help/2008-August/172358.html
    top.sum <- sum(t[i] * t[j] * abs(p[i] - p[j]))

    total.pct.not.white <- sum(x)/sum(t)
    denominator <- 2 * sum(t)**2 * total.pct.not.white * (1 - total.pct.not.white)

    coeff <- top.sum / denominator

    return(coeff)
}

# Correlation Ratio
correlationRatio <- function(city) {

    x <- city$pop.not.white # non white population in each census tract
    t <- city$pop           # total population of each census tract

    total.pct.not.white <- sum(x) / sum(t)

    isolation <- sum((x/sum(x)) * (x/t))

    corr <- (isolation - total.pct.not.white) / (1 - total.pct.not.white)

    return(corr)
}


# Delta
delta <- function(city) {

    x <- city$pop.not.white # non white population in each census tract
    a <- city$area          # area of each census tract

    x.tot <- sum(x)
    a.tot <- sum(a)

    result <- .5 * sum(abs((x/x.tot) - (a/a.tot)))

    return(result)
}
