# Solve Wordtrek

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
possible_words <- list()
for (i in 1:length(word_lengths)) {
  print(paste0("Word number (length): ", i, " (", word_lengths[i], ")"))
  # Subset known words to those with input length and starting letters
  known_words_subset <- subset_known_words(known_words, word_lengths[i], word_letters[i])
  # Subset known
  possible_words[[i]] <- restrict_using_first_2_letters(known_words_subset, mers_tree[[word_lengths[i]]])
  print(paste0("The possible words are: ", paste(possible_words[[i]], collapse = " ")))
}
