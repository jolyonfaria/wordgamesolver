# Get hints for word search game puzzle

# A program to provide hints for a word search game. The user must provide three inputs:
# (1) Letter matrix
# (2) Word lengths
# (3) Word starting letters (if any)

# To run this process:
# (1) Enter user inputs
# (2) Run file

# User input 1: Input letter matrix
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

# User input 2: Word lengths and starting letters
word_lengths <- c(6)

# User input 3: Word lengths and starting letters
word_letters <- c("b")

# Find k-mers within letter matrix
mers_tree <- make_mers_tree(letter_matrix)

# Load known words
known_words <- load_known_words(word_freq_file)

# Find possible words
possible_words <- find_possible_words(mers_tree, known_words, word_lengths, word_letters)
