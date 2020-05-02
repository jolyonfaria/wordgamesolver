# Solve Wordtrek

# A program to solve Wordtrek puzzles. The inputs are word lengths and the wordtrek letters and the output are a
# a set of possible words.

# Configuration

# Method overview

# 1. Convert letter matrix to network
# 2. Find all possible paths
# 3. Convert paths to words
# 4. Filter words to those of required length
# 5. Filter words to known words

# Issues
# 1. Only works for 1st word
# 2. Only works for 4 by 4 matrix
# 3. Can't find plurals

# Ideas
# 2. Make package
# 3. Remove need for numbers in letters
# 4. Time it
# 5. Monitor memory use
# 6. Extend to non-square inputs
# 7. Split into 15 letters chunks and run (15 is big enough to be interesting but doesn't take too long)
# 8. Plot time ggainst number of letters
# 9. Plot n edges against time
# 10. Plot network
# 11. Print edges removed
# 12. Parallelise!
# 13. Faster without loops?
# 14. Add s to all words in word list for plurals (but what about e.g dwarves)
# 15. Break down combined 'words' into composite words
# 16. Shiny app that let's you rule out words
# 17. See combinations of top frequency words together
# 18 Be able to remove words (or check if possible and then remove if not)

# Done
# 1. Move functions to own file

# Get known words
# config_file <- "/media/jol/DATA/Me/projects/wordtrek/config_v5.R"
# source(config_file)

extra_words <- "arctic"
word_freq_file <- file.path("inst", "extdata", "count_1w.txt")
stopifnot(file.exists(word_freq_file))

# Load known words
# known_words <- read.table(known_words_file, stringsAsFactors = FALSE)
# stopifnot(file.exists(known_words_file))
# known_words <- known_words[!grepl("-", known_words$V1),, drop = FALSE]
# known_words <- known_words[nchar(known_words$V1) > 2, , drop = FALSE]
# known_words <- rbind(known_words, data.frame(V1 = extra_words))
# row.names(known_words) <- NULL

# Load word freqency
known_words <- read.table(word_freq_file, stringsAsFactors = FALSE)
known_words <- known_words[order(known_words$V2, decreasing = TRUE), ][1:10000,]
known_words <- rbind(known_words, data.frame(V1 = extra_words, V2 = 1000))
row.names(known_words) <- NULL

# Get known word letter pairs
# load("n_all_pairs_df.RData")

# Load functions

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
# letter_matrix <- letter_matrix[3:5,]
# word_lengths <- c(8,4)
#
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
# Get all possible word pairs given th first letter of each word
word_lengths <- c(8,7,6)
word_letters <- c(NA,NA,NA,NA,NA)
# letter_matrix <- letter_matrix[,3:6]
# word_lengths <- c(8,4)



# Remove numbers
letter_matrix_str <- as.character(letter_matrix)
letter_matrix_str <- gsub('[0-9]+', '', letter_matrix_str)
letter_matrix_str <- letter_matrix_str[!is.na(letter_matrix_str)]

# word_length_1 <- 6
# word_letter_1 <- NA
# word_length_2 <- 4
# word_letter_2 <- NA
# word_length_3 <- 5
# word_letter_3 <- NA
# Word 1
# known_words_subset <- subset_known_words(known_words, word_lengths[1], word_letters[1])
# possible_words_1 <- find_possible_words(known_words_subset, letter_matrix_str)
# length(possible_words_1)
#
# # Word 2
# known_words_subset <- subset_known_words(known_words, word_lengths[2], word_letters[2])
# possible_words_2 <- find_possible_words(known_words_subset, letter_matrix_str)
# length(possible_words_2)
#
# # Combine words 1 and 2
# possible_words <- combine_words(possible_words_1, possible_words_2)
# possible_words <- find_possible_words(possible_words, letter_matrix_str)
# tail(unique_words(possible_words, 1, word_lengths[1]), 50)
# tail(unique_words(possible_words, word_lengths[1] + 1, word_lengths[1] + word_lengths[2]), 50)
# # zz <- unique_word_combos(possible_words, 1, word_length_1, word_length_1 + 1,word_length_1 + word_length_2)
#
# #
# #
# # # Word 3
# known_words_subset <- subset_known_words(known_words, word_length_3, word_letter_3)
# possible_words_3 <- find_possible_words(known_words_subset, letter_matrix_str)
# # possible_words_3 <- words_as_pairs_in_matrix(possible_words_3, letter_matrix)
# #
# # # Combine words 1, 2 and 3
# print(length(possible_words) * length(possible_words_3))
# possible_words <- combine_words(possible_words, possible_words_3)
# possible_words <- find_possible_words(possible_words, letter_matrix_str)
# unique_words(possible_words, 1, word_length_1)
# unique_words(possible_words, word_length_1 + 1, word_length_1 + word_length_2)
# unique_words(possible_words, word_length_1 + word_length_2 + 1, word_length_1 + word_length_2 + word_length_3)
# #
# # # Word 4
# # known_words_subset <- subset_known_words(known_words, word_length_4, word_letter_4)
# # possible_words_4 <- find_possible_words(known_words_subset, letter_matrix_str)
# #
# # # Combine words 1, 2, 3 and 4
# # possible_words <- combine_words(possible_words, possible_words_4)
# # possible_words <- find_possible_words(possible_words, letter_matrix_str)
# # unique_words(possible_words, 1, word_length_1)
# # unique_words(possible_words, word_length_1 + 1, word_length_1 + word_length_2)
# # unique_words(possible_words, word_length_1 + word_length_2 +1, word_length_1 + word_length_2 + word_length_3)
# # unique_words(possible_words, word_length_1 + word_length_2 + word_length_3 + 1, word_length_1 + word_length_2 + word_length_3 + word_length_4)
#
# # Word 5
# # known_words_subset <- subset_known_words(known_words, word_length_5, word_letter_5)
# # possible_words_5 <- find_possible_words(known_words_subset, letter_matrix_str)
# #
# # # Combine words 1, 2, 3 and 4
# # possible_words <- combine_words(possible_words, possible_words_4)
# # possible_words <- find_possible_words(possible_words, letter_matr1ix_str)
# # unique_words(possible_words, 1, word_length_1)
# # unique_words(possible_words, word_length_1 + 1, word_length_1 + word_length_2)
# # unique_words(possible_words, word_length_1 + word_length_2 +1, word_length_1 + word_length_2 + word_length_3)
# # unique_words(possible_words, word_length_1 + word_length_2 + word_length_3 + 1, word_length_1 + word_length_2 + word_length_3 + word_length_4)


print(sum(word_lengths))

# First word
mers_tree <- make_mers_tree(letter_matrix)
possible_words <- list()
for (i in 1:length(word_lengths)) {
  print(paste0("Word number (length): ", i, " (", word_lengths[i], ")"))
  known_words_subset <- subset_known_words(known_words, word_lengths[i], word_letters[i])
  possible_words[[i]] <- restrict_using_first_2_letters(known_words_subset, mers_tree[[word_lengths[i]]])
  print(possible_words[[i]])
}

# Combine words 1 and 2
# possible_words <- combine_words(possible_words[[1]], possible_words[[2]])
# possible_words <- find_possible_words(possible_words, letter_matrix_str)
# tail(unique_words(possible_words, 1, word_lengths[i]), 50)
# tail(unique_words(possible_words, word_lengths[i] + 1, word_length_1 + word_length_2), 50)
