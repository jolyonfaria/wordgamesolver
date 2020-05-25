#' Find possible words
#'
#' @description Find possible words in letter matrix.
#'
#' @param mers_tree K-mers within letter matrix.
#' @param known_words Table of known words.
#' @param word_lengths Lengths of words to find.
#' @param word_letters First letters of words to find.
#'
#' @return A character vector of known words that are in the letter matrix
#' @export
find_possible_words <- function(mers_tree, known_words, word_lengths, word_letters) {
  possible_words <- list()
  for (i in seq(1, length(word_lengths))) {
    print(paste0("Word number (length): ", i, " (", word_lengths[i], ")"))
    # Subset known words to those with input length and starting letters
    known_words_subset <- subset_known_words(known_words, word_lengths[i], word_letters[i])
    # Subset to known words that can be created in the letter matrix
    possible_words[[i]] <- restrict_using_first_2_letters(known_words_subset, mers_tree[[word_lengths[i]]])
    print(paste0("The possible words are: ", paste(possible_words[[i]], collapse = " ")))
  }
  return(possible_words)
}
