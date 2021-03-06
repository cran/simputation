% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/proxy.R
\name{impute_proxy}
\alias{impute_proxy}
\alias{impute_const}
\title{Impute by variable derivation}
\usage{
impute_proxy(dat, formula, add_residual = c("none", "observed", "normal"), ...)

impute_const(dat, formula, add_residual = c("none", "observed", "normal"), ...)
}
\arguments{
\item{dat}{\code{[data.frame]}, with variables to be imputed and their
predictors.}

\item{formula}{\code{[formula]} imputation model description (See Model description)}

\item{add_residual}{\code{[character]} Type of residual to add. \code{"normal"} 
means that the imputed value is drawn from \code{N(mu,sd)} where \code{mu}
and \code{sd} are estimated from the model's residuals (\code{mu} should equal
zero in most cases). If \code{add_residual = "observed"}, residuals are drawn
(with replacement) from the model's residuals. Ignored for non-numeric 
predicted variables.}

\item{...}{Currently unused}
}
\description{
Impute missing values by a constant, by copying another variable computing 
transformations from other variables.
}
\section{Model Specification}{


Formulas are of the form

\code{IMPUTED_VARIABLES ~ MODEL_SPECIFICATION [ | GROUPING_VARIABLES ] }

The left-hand-side of the formula object lists the variable or variables to 
be imputed. 

For \code{impute_const}, the \code{MODEL_SPECIFICATION} is a single
value and \code{GROUPING_VARIABLES} are ignored.

For \code{impute_proxy}, the \code{MODEL_SPECIFICATION} is a variable or
expression in terms of variables in the dataset that must result in either a
single number of in a vector of length \code{nrow(dat)}.

If grouping variables are specified, the data set is split according to the 
values of those variables, and model estimation and imputation occur 
independently for each group.

Grouping using \code{dplyr::group_by} is also supported. If groups are 
defined in both the formula and using \code{dplyr::group_by}, the data is 
grouped by the union of grouping variables. Any missing value in one of the 
grouping variables results in an error.
}

\examples{
irisNA <- iris
irisNA[1:3,1] <- irisNA[3:7,2] <- NA

# impute a constant 

a <- impute_const(irisNA, Sepal.Width ~ 7)
head(a)

a <- impute_proxy(irisNA, Sepal.Width ~ 7)
head(a)

# copy a value from another variable (where available)
a <- impute_proxy(irisNA, Sepal.Width ~ Sepal.Length)
head(a)

# group mean imputation
a <- impute_proxy(irisNA
  , Sepal.Length ~ mean(Sepal.Length,na.rm=TRUE) | Species)
head(a)

# random hot deck imputation
a <- impute_proxy(irisNA, Sepal.Length ~ mean(Sepal.Length, na.rm=TRUE)
, add_residual = "observed")

# ratio imputation (but use impute_lm for that)
a <- impute_proxy(irisNA, 
  Sepal.Length ~ mean(Sepal.Length,na.rm=TRUE)/mean(Sepal.Width,na.rm=TRUE) * Sepal.Width)

}
