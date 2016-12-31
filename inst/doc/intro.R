## ---- echo=FALSE---------------------------------------------------------
library(simputation)

## ---- eval=FALSE---------------------------------------------------------
#  impute_<model>(data, formula, [model-specific options])

## ---- eval=FALSE---------------------------------------------------------
#  IMPUTED ~ MODEL_SPECIFICATION [ | GROUPING ]

## ------------------------------------------------------------------------
dat <- iris
dat[1:3,1] <- dat[3:7,2] <- dat[8:10,5] <- NA
head(dat,10)

## ------------------------------------------------------------------------
da1 <- impute_lm(dat, Sepal.Length ~ Sepal.Width + Species)
head(da1,3)

## ------------------------------------------------------------------------
da2 <- impute_median(da1, Sepal.Length ~ Species)
head(da2,3)

## ------------------------------------------------------------------------
da3 <- impute_cart(da2, Species ~ .)
head(da3,10)

## ---- eval=FALSE---------------------------------------------------------
#  library(magrittr)
#  da4 <- dat %>%
#    impute_lm(Sepal.Length ~ Sepal.Width + Species) %>%
#    impute_median(Sepal.Length ~ Species) %>%
#    impute_cart(Species ~ .)

## ------------------------------------------------------------------------
da5 <- impute_rlm(dat, Sepal.Length + Sepal.Width ~ Petal.Length + Species)
head(da5)

## ------------------------------------------------------------------------
da6 <- impute_lm(dat, . - Species ~ 0 + Species, add_residual = "normal")
head(da6)

## ------------------------------------------------------------------------
# New data set, leaving Species intact
dat <- iris
dat[1:3,1] <- dat[3:7,2] <- NA

# split dat into groups according to 'Species', impute, combine and return.
da8 <- impute_lm(dat, Sepal.Length ~ Petal.Width | Species)
head(da8)

## ----eval=FALSE----------------------------------------------------------
#  library(magrittr)
#  library(dplyr)
#  
#  dat <- iris
#  dat[1:3,1] <- dat[3:7,2] <- NA
#  
#  dat %>% group_by(Species) %>%
#    impute_lm(Sepal.Length ~ Petal.Width)

## ----eval=FALSE----------------------------------------------------------
#  dat <- data.frame(
#    foo = c(1,2,NA,4)
#    , bar = c(1,NA,8,NA)
#  )
#  # sequential hotdeck imputation, no sorting variables
#  impute_shd(dat, . ~ 1, pool="complete")
#  impute_shd(dat, . ~ 1, pool="univariate")
#  impute_shd(dat, .~1, backend="VIM")

