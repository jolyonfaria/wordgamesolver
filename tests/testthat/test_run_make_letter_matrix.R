context("Run make letter matrix")

test_that("known words and word lengths then make a letter matrix", {
  word_length <- 3
  known_words <- data.frame(
    V1 = c("abc", "efg", "hij"),
    V2 = 1,
    stringsAsFactors = FALSE
  )
  letter_matrix <- run_make_letter_matrix(known_words, word_length)

  # Test letter matrix
  expect_equal(dim(letter_matrix), c(3, 3))
  expect_true(all(letter_matrix %in% unlist(strsplit(known_words$V1, ""))))
})
