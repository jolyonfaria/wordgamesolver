[![Build Status](https://travis-ci.com/jolyonfaria/wordgamesolver.svg?branch=master)](https://travis-ci.com/jolyonfaria/wordgamesolver)
<br />

# wordgamesolver

Tools to provide hints for a popular word search game.

## Word list

This package requires a word list. The word list must be added to the directory `inst/extdata` and comprise 2 columns: word and word frequency. I recommed the file `count_1w.txt` from this [resource](https://norvig.com/ngrams/).

## Run

To provide hints for a puzzle:

1. Open RStudio

2. Open `analysis/run_analysis.rmd`

i. Enter puzzle inputs

ii. Run file

## Lint

For continuous integration, link checks do not fail build. However, lint errors are communicated via email by the lint bot.
