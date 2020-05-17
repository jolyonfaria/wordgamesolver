context("Test k-mers tree")

test_that("test that 2 x 2 matrix returns 4 1 mers", {
  letter_matrix <- matrix(
    c("a", "b",
      "c", "d"),
    nrow = 2
  )
  mers_tree <- make_mers_tree(letter_matrix)
  expect_equal(length(mers_tree[[1]]), 4)
})

test_that("test 2", {
  expect_true(TRUE)
})
