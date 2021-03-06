% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_solve_random_letter_marix.R
\name{run_solve_random_letter_matrix}
\alias{run_solve_random_letter_matrix}
\title{run_random_letter_matrix}
\usage{
run_solve_random_letter_matrix(
  letter_matrix,
  known_words,
  word_length,
  word_letters = NA
)
}
\arguments{
\item{letter_matrix}{Table of known words}

\item{known_words}{Table of known words}

\item{word_length}{Table of known words}

\item{word_letters}{Table of known words}
}
\value{
A character vector of known words that are in the letter matrix
}
\description{
Find possible words in letter matrix.
}
