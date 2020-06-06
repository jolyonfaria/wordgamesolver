#' run_random_letter_matrix
#'
#' @description Find possible words in letter matrix.
#'
#' @param word_length Number of characters in words
#' @param known_words Table of known words
#' @return A character vector of known words that are in the letter matrix
#' @export
run_solve_random_letter_matrix <- function(known_words, word_length) {
  word_lengths <- rep(word_length, word_length)
  word_letters <- NA
  words <- c()
  for (i in seq(1, word_length)) {
    words <- c(words, get_random_word(known_words, word_lengths))
  }
  letter_matrix <- make_letter_matrix(words, word_length)
  mers_tree <- make_mers_tree(letter_matrix)
  possible_words <- find_possible_words(mers_tree, known_words, word_lengths, word_letters)
}
