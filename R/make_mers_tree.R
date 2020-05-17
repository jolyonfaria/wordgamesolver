#' Make mers tree
#'
#' @description Find k-mers within the letter matrix from k = 1 to 5.
#'
#' @param letter_matrix Matrix comprising letters.
#'
#' @return A list with one element comprising all k-mers of equal length. For instance, one element for 1-mers, and
#' second for 2-mers.
#' @export
make_mers_tree <- function(letter_matrix) {
  # Make submatrix
  sub_matrix <- letter_matrix
  sub_matrix_dim <- dim(letter_matrix)
  sub_matrix <- paste0(sub_matrix, 1:(sub_matrix_dim[1] * sub_matrix_dim[2]))
  dim(sub_matrix) <- sub_matrix_dim
  m1ers <- as.character(letter_matrix)
  m1ers <- m1ers[!is.na(m1ers)]
  m2ers <- list()
  m3ers <- list()
  m4ers <- list()
  m5ers <- list()
  for (a in 1:nrow(sub_matrix)) {
    for (b in 1:ncol(sub_matrix)) {
      # Add 2nd character
      first_char <- sub_matrix[a, b]
      first_char_pos <- which(sub_matrix == first_char, arr.ind = TRUE)
      second_char <- get_next_chars(first_char, first_char_pos, first_char, letter_matrix = sub_matrix)
      m2ers[[length(m2ers) + 1]] <- get_path(path_char = first_char, next_char = second_char)
      second_char_pos <- t(sapply(second_char, function(x) which(sub_matrix == x, arr.ind = TRUE)))
      for (d in 1:nrow(second_char_pos)) {
        # Add 3rd character
        current_path <- c(first_char, second_char[d])
        third_char <- get_next_chars(second_char[d], second_char_pos[d, ], current_path, letter_matrix = sub_matrix)
        m3ers[[length(m3ers) + 1]] <- get_path(path_char = m2ers[[length(m2ers)]][d], next_char = third_char)
        third_char_pos <- t(sapply(third_char, function(x) which(sub_matrix == x, arr.ind = TRUE)))
        for (f in 1:nrow(third_char_pos)) {
          # Add 4th character
          current_path <- c(first_char, second_char[d], third_char[f])
          fourth_char <- get_next_chars(third_char[f], third_char_pos[f, ], current_path, letter_matrix = sub_matrix)
          m4ers[[length(m4ers) + 1]] <- get_path(path_char = m3ers[[length(m3ers)]][f], next_char = fourth_char)
          fourth_char_pos <- t(sapply(fourth_char, function(x) which(sub_matrix == x, arr.ind = TRUE)))
          for (g in 1:nrow(fourth_char_pos)) {
            # Add 5th character
            current_path <- c(first_char, second_char[d], third_char[f], fourth_char[g])
            fifth_char <- get_next_chars(fourth_char[g], fourth_char_pos[g, ], current_path, letter_matrix = sub_matrix)
            m5ers[[length(m5ers) + 1]] <- get_path(path_char = m4ers[[length(m4ers)]][g], next_char = fifth_char)
            fifth_char_pos <- t(sapply(fifth_char, function(x) which(sub_matrix == x, arr.ind = TRUE)))
          }
        }
      }
    }
  }

  m3ers <- unique(unlist(sapply(m3ers, function(x) as.character(gsub("[[:digit:]]", "", x)))))
  print(paste0("3-mers: ", length(m3ers)))
  m4ers <- unique(unlist(sapply(m4ers, function(x) as.character(gsub("[[:digit:]]", "", x)))))
  print(paste0("4-mers: ", length(m4ers)))
  m5ers <- unique(unlist(sapply(m5ers, function(x) as.character(gsub("[[:digit:]]", "", x)))))
  print(paste0("5-mers: ", length(m5ers)))

  # Build mers
  mers_trees <- list()
  mers_trees[[1]] <- m1ers
  mers_trees[[2]] <- m2ers
  mers_trees[[3]] <- m3ers
  mers_trees[[4]] <- m4ers
  mers_trees[[5]] <- m5ers
  mers_trees[[6]] <- m5ers
  mers_trees[[7]] <- m5ers
  mers_trees[[8]] <- m5ers
  mers_trees[[9]] <- m5ers
  mers_trees[[10]] <- m5ers
  mers_trees[[11]] <- m5ers
  mers_trees[[12]] <- m5ers
  mers_trees[[13]] <- m5ers
  mers_trees[[14]] <- m5ers

  return(mers_trees)
}

#' Get next chars
#'
#' @description Greet a person and appropriately capitalize their name.
#'
#' @param focus_char Your name (character string; e.g. "john doe").
#' @param focus_char_pos Your name (character string; e.g. "john doe").
#' @param prev_chars Your name (character string; e.g. "john doe").
#' @param letter_matrix Your name (character string; e.g. "john doe").
#'
#' @return A character string, capitalized to title case.
#' @export
get_next_chars <- function(focus_char, focus_char_pos, prev_chars, letter_matrix) {
  x1 <- ifelse(focus_char_pos[1] - 1 < 1, 1, focus_char_pos[1] - 1)
  x2 <- ifelse(focus_char_pos[1] + 1 > nrow(letter_matrix), nrow(letter_matrix), focus_char_pos[1] + 1)
  y1 <- ifelse(focus_char_pos[2] - 1 < 1, 1, focus_char_pos[2] - 1)
  y2 <- ifelse(focus_char_pos[2] + 1 > ncol(letter_matrix), ncol(letter_matrix), focus_char_pos[2] + 1)
  focus_mat <- letter_matrix[x1:x2, y1:y2]
  cells_to_na <- c(focus_char, prev_chars)
  for (i in 1:length(cells_to_na)) {
    focus_mat[focus_mat == cells_to_na[i]] <- NA
  }
  next_char <- as.character(focus_mat)
  next_char <- next_char[!is.na(next_char)]
  return(next_char)
}

#' Get path
#'
#' @description Greet a person and appropriately capitalize their name.
#'
#' @param path_char Your name (character string; e.g. "john doe").
#' @param next_char Your name (character string; e.g. "john doe").
#'
#' @return A character string, capitalized to title case.
#' @export
get_path <- function(path_char, next_char) {
  mers <- apply(expand.grid(path_char, as.character(next_char)), 1, function(x) paste0(x[1], x[2]))
  return(mers)
}

#' subset_known_words
#'
#' @description Greet a person and appropriately capitalize their name.
#'
#' @param x Your name (character string; e.g. "john doe").
#' @param word_length Your name (character string; e.g. "john doe").
#' @param first_letters Your name (character string; e.g. "john doe").
#'
#' @return A character string, capitalized to title case.
#' @export
subset_known_words <- function(x, word_length, first_letters=NA) {
  known_words_subset <- x$V1[nchar(x$V1) == word_length]
  if (!is.na(first_letters)) {
    known_words_subset <- known_words_subset[grep(paste0("^", first_letters), known_words_subset)]
  }
  return(known_words_subset)
}

#' restrict_using_first_2_letters
#'
#' @description Greet a person and appropriately capitalize their name.
#'
#' @param x Your name (character string; e.g. "john doe").
#' @param possible_strings Your name (character string; e.g. "john doe").
#' @param n_letter_match Your name (character string; e.g. "john doe").
#'
#' @return A character string, capitalized to title case.
#' @export
restrict_using_first_2_letters <- function(x, possible_strings, n_letter_match = 5) {

  print(paste0("Starting n possible words: ", length(x)))
  string_length <- n_letter_match
  n_letters <- nchar(x[1])
  n_loops <- n_letters - string_length + 1
  final_possible_words <- x

  for (h in 1:n_loops) {
    x_sub <- substr(final_possible_words, h, h + string_length - 1)
    possible_words <- list()
    n_loop <- ceiling(length(possible_strings) / 1000)
    for (i in 1:n_loop) {
      if (i == n_loop) {
        last_pos <- length(possible_strings) %% 1000
      } else {
        last_pos <- 999
      }
      first_index <- ((i - 1) * 1000) + 1
      last_index <- first_index + last_pos
      possible_word_index <- unique(grep(paste(possible_strings[first_index:last_index], collapse = "|"), x_sub))
      possible_words[[i]] <- final_possible_words[possible_word_index]
    }
    possible_words <- unique(unlist(possible_words))

    final_possible_words <- intersect(final_possible_words, possible_words)
    print(paste0("Possible words filter first and last chars: ", length(final_possible_words)))
  }

  print(paste0("Possible words filter first and last chars: ", length(final_possible_words)))
  return(sort(final_possible_words))
}
