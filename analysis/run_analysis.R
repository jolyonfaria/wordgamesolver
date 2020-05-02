# Solve Wordtrek

# A program to solve Wordtrek puzzles. The inputs are word lengths and the wordtrek letters and the output are a
# a set of possible words.

# Load known words
extra_words <- "arctic"
word_freq_file <- file.path("inst", "extdata", "count_1w.txt")
stopifnot(file.exists(word_freq_file))
known_words <- read.table(word_freq_file, stringsAsFactors = FALSE)
known_words <- known_words[order(known_words$V2, decreasing = TRUE), ][1:10000,]
known_words <- rbind(known_words, data.frame(V1 = extra_words, V2 = 1000))
row.names(known_words) <- NULL

# Input

# letter_matrix <- matrix(
#   c("k", "y", "n",
#     "a", "u", "m",
#     "s", "t", "u"),
#   nrow = 3,
#   byrow = TRUE
# )
# word_lengths <- c(4,5)
#
# letter_matrix <- matrix(
#   c("e", "t", "a", "e",
#     "v", "i", "r", "h",
#     "e", "i", "b", "g",
#     "m", "h", "c", "u"),
#   nrow = 4,
#   byrow = TRUE
# )
# word_lengths <- c(8)

# letter_matrix <- matrix(
#   c("w", "r", "i", "d", "l",
#     "i", "f", "e", "c", "o",
#     "o", "z", "t", "r", "c",
#     "e", "n", "i", "t", "e",
#     "n", "c", "a", "r", "c"),
#   nrow = 5,
#   byrow = TRUE
# )
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

# Comment what does this do?
mers_tree <- make_mers_tree(letter_matrix)
possible_words <- list()
for (i in 1:length(word_lengths)) {
  print(paste0("Word number (length): ", i, " (", word_lengths[i], ")"))
  # Comment what does this do?
  known_words_subset <- subset_known_words(known_words, word_lengths[i], word_letters[i])
  # Comment what does this do?
  possible_words[[i]] <- restrict_using_first_2_letters(known_words_subset, mers_tree[[word_lengths[i]]])
  print(possible_words[[i]])
}
