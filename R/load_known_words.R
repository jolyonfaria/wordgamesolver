#' Load known words
#'
#' @description Load known words from file.
#'
#' @param known_words_file Known words file path
#' @param n_words Number of words to use
#'
#' @export
load_known_words <- function(known_words_file, n_words = 1000) {
  extra_words <- "arctic"
  stopifnot(file.exists(known_words_file))
  known_words <- utils::read.table(known_words_file, stringsAsFactors = FALSE)
  known_words <- known_words[order(known_words$V2, decreasing = TRUE), ][1:n_words, ]
  known_words <- rbind(known_words, data.frame(V1 = extra_words, V2 = 1000))
  row.names(known_words) <- NULL
  return(known_words)
}

#' Get random word
#'
#' @description Randomly draw word from known words.
#'
#' @param known_words Table of known words
#' @param word_length Number of characters of word to be randomly drawn
#'
#' @export
get_random_word <- function(known_words, word_length) {
  known_words_subset <- known_words[nchar(known_words$V1) %in% word_length, ]
  random_word <- known_words_subset$V1[sample(1:nrow(known_words_subset), 1)]
  return(random_word)
}
