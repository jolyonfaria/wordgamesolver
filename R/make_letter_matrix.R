#' Make letter matrix
#'
#' @description Make a letter matrix from input words.
#'
#' @param word_vector Input words
#' @param v_size Number of columns in output matrix
#'
#' @return Output matrix comprising input words
#' @export
make_letter_matrix <- function(word_vector, v_size = 3) {
  char_vector <- strsplit(paste0(word_vector, collapse = ""), split = "")[[1]]
  stopifnot(length(char_vector) %in% v_size ^ 2)
  return(
    matrix(
      char_vector,
      byrow = TRUE,
      ncol = v_size
    )
  )
}
