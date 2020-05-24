context("Test find possible words")

test_that("test that given 6x6 matrix and user inputs, when search for known word, then known word is found", {
  # Expected word
  expected_word <- "baffle"

  # Make known words file
  test_word_freq_file <-file.path(tempdir(), "known_words.csv")
  write.table(
    data.frame(expected_word, 10),
    file = test_word_freq_file,
    sep = "\t",
    col.names = FALSE,
    row.names = FALSE
  )

  # Input matrix
  letter_matrix <- matrix(
    c("e", "l", "r", "e", "f", "e",
      "f", "x", "b", "e", "u", "b",
      "f", "e", "o", "i", "l", "d",
      "a", "l", "n", "c", "r", "d",
      "b", "p", "u", "f", "l", "e",
      "p", "e", "s", "e", "w", "d"),
    nrow = 6,
    byrow = TRUE
  )

  # Input search word attributes
  word_lengths <- c(6)
  word_letters <- c("b")

  # Input known words
  known_words <- load_known_words(test_word_freq_file, 1)

  # Search for possible words
  mers_tree <- make_mers_tree(letter_matrix)
  possible_words <- find_possible_words(mers_tree, known_words, word_lengths, word_letters)

  # Test that expected word is in the returned possible words
  expect_identical(possible_words[[1]], expected_word)

  # Tear down
  unlink(test_word_freq_file, recursive = TRUE)
})
