
context("utilities")

test_that("grouping",{
  expect_equal(groups(iris, Sepal.Length ~ . | Species),"Species")
  if (suppressPackageStartupMessages(require(dplyr))){
    i2 <- group_by(iris,Species)
    expect_equal(groups(i2, Sepal.Length ~ . | Species),"Species")
  }  
 
  expect_equal(groups(mtcars,mpg ~ disp | cyl + gear),c("cyl","gear"))
  if (require(dplyr)){
    mt2 <- group_by(mtcars, cyl , am)
    expect_equal(sort(groups(mt2, mpg ~ disp | cyl + gear)),c("am","cyl","gear"))
  }
  
  expect_equal(remove_groups(x ~ y | z + w),x ~ y)
  expect_equal(y ~ x ,remove_groups(y ~ x))
  
  expect_true(has_groups(x ~ y | z))
  expect_false(has_groups(x ~ y + z))
  
})

test_that("split-apply-combine",{
  i2 <- iris
  i2[1,5] <- NA
  expect_error(do_by(i2,"Species",.fun = function(x) x))
})

