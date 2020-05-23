#' Load known words
#'
#' @description Load known words from file.
#'
#' @param known_words_file Known words file path
#' @param n_words Number of words to use
#'
#' @export
load_known_words <- function(known_words_file, n_words) {
  extra_words <- "arctic"
  stopifnot(file.exists(known_words_file))
  known_words <- utils::read.table(known_words_file, stringsAsFactors = FALSE)
  known_words <- known_words[order(known_words$V2, decreasing = TRUE), ][1:n_words,]
  known_words <- rbind(known_words, data.frame(V1 = extra_words, V2 = 1000))
  row.names(known_words) <- NULL
  return(known_words)
}
