# Time benchmark

# 1. Examine 6x6 matrix
# 2. Examine matrices of different sizes

# Packages
library(ggplot2)

# Setup
known_words <- load_known_words(word_freq_file)

# 1. Examine 6x6 matrix

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

# Analysis
tictoc::tic("Find possible words")
mers_tree <- make_mers_tree(letter_matrix)
possible_words <- find_possible_words(mers_tree, known_words, word_lengths, word_letters)
tictoc::toc()
# Find possible words: 4.787 sec elapsed

# 2. Examine matrices of different sizes
time_to_solve <- expand.grid(
  matrix_size = c(3, 4, 5, 6),
  rep = 1:3
)
time_to_solve$time <- NA
for (i in seq(1, nrow(time_to_solve))) {
  tictoc::tic(paste0("Solving random matrix with size ", time_to_solve$matrix_size[i]))
  run_solve_random_letter_matrix(known_words, time_to_solve$matrix_size[i])
  time_taken <- tictoc::toc()
  time_to_solve$time[i] <- time_taken$toc - time_taken$tic
}

ggplot2::ggplot(time_to_solve, aes(matrix_size, time)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "lm", formula = "(y ~ exp(x))") +
  ylab("Time (s)") +
  xlab("Matrix size (# rows)") +
  theme_bw()
