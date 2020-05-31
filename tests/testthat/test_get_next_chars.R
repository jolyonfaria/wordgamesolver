context("Test get next characters")

test_that("given 3x3 matrix and starting at the centre letter, when get_next_chars, then return surrounding letters", {

  focus_char <- "e"
  focus_char_pos <- c(2, 2)
  prev_chars <- "a"
  letter_matrix <- matrix(
    c("a", "b", "c",
      "d", "e", "f",
      "g", "h", "i"),
    ncol = 3,
    byrow = TRUE
  )

  next_chars <- get_next_chars(focus_char, focus_char_pos, prev_chars, letter_matrix)

  expect_equal(length(next_chars), 7)
  expect_identical(sort(next_chars), c("b", "c", "d", "f", "g", "h", "i"))
})
