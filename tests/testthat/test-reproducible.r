


context("reproducibility - old api")

test_that("Setting the seed causes result to be reproducible (1 core)", {
  set.seed(18900217)
  mod <- gbm(Species == 'setosa' ~ ., data=iris, distribution="bernoulli",
             cv.folds=3, n.trees=100, shrinkage=.1, n.cores=1)
  nt1 <- gbm.perf(mod, method="cv", plot.it=FALSE)
  ri1 <- relative.influence(mod, n.trees=nt1)

  set.seed(18900217)
  mod <- gbm(Species == 'setosa' ~ ., data=iris, distribution="bernoulli",
             cv.folds=3, n.trees=100, shrinkage=.1, n.cores=1)
  nt2 <- gbm.perf(mod, method="cv", plot.it=FALSE)
  ri2 <- relative.influence(mod, n.trees=nt2)
  
  expect_equal(nt1, nt2,
               label="Number of trees match when same seed is used")
  expect_equal(ri1, ri2,
               label="Relative influences match when same seed is used")
})

test_that("Setting different seeds causes result to be different (1 core)", {
  set.seed(18900217)
  mod <- gbm(Species == 'setosa' ~ ., data=iris, distribution="bernoulli",
             cv.folds=3, n.trees=100, shrinkage=.1, n.cores=1)
  nt1 <- gbm.perf(mod, method="cv", plot.it=FALSE)
  ri1 <- relative.influence(mod, n.trees=nt1)

  set.seed(19620729)
  mod <- gbm(Species == 'setosa' ~ ., data=iris, distribution="bernoulli",
             cv.folds=3, n.trees=100, shrinkage=.1, n.cores=1)
  nt2 <- gbm.perf(mod, method="cv", plot.it=FALSE)
  ri2 <- relative.influence(mod, n.trees=nt2)

  expect_false(isTRUE(all.equal(ri1, ri2)),
              label="Relative influences don't match when different seeds are used")
})

