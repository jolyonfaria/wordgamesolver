Benchmark for Word game solver
================

# Runtime for one matrix

Time take to run for a 6 x 6 matrix: 4.713 s.

# Runtime for different matrix sizes

``` r
ggplot2::ggplot(time_to_solve, aes(matrix_size, time)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "lm", formula = "(y ~ exp(x))") +
  ylab("Time (s)") +
  xlab("Matrix size (# rows)") +
  theme_bw()
```

![](run_analysis_time_benchmark_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

# Appendix

Git hash: f19b5a96496476f3befaa1fed523ce2d0a156bab

Git commit date: Sun Jun 7 15:02:26 2020 +0100

Repository: wordgamesolver
