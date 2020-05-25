# Time benchmark

# Inputs
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
word_lengths <- c(6)
word_letters <- c("b")
known_words <- load_known_words(word_freq_file)

# Analysis
tictoc::tic("Find possible words")
mers_tree <- make_mers_tree(letter_matrix)
possible_words <- find_possible_words(mers_tree, known_words, word_lengths, word_letters)
tictoc::toc()
# Find possible words: 4.787 sec elapsed

