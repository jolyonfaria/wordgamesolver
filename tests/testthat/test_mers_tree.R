context("Test k-mers tree")

test_that("given 2 x 2 matrix, when make mers tree, then returns 4 1-mers", {
  letter_matrix <- matrix(
    c("a", "b",
      "c", "d"),
    nrow = 2
  )
  mers_tree <- make_mers_tree(letter_matrix)
  expect_equal(length(mers_tree[[1]]), 4)
})
