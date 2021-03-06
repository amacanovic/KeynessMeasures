
## KeynessMasures



An R package including multiple measures of word keyness used in computational
linguistics. Introducing both statistical significance and effect size
measures in several simple functions.


This package currently supports the following measures:

1.  **Statistical significance:** Log-likelihood ratio, Bayesian Information Criterion.

2.  **Effect size:** Effect Size of Log Likelihood, %DIFF, The Relative Risk,
The Log Ratio measure, The Odds Ratio.

For more details on using the effect size measures, consult the vignette 
"KeynessMeasures: Introduction to effect size measures". 

## Installing the package

This package can be installed from GitHub, using devtools. 

To download the package from GitHub, use the following command:

```r
devtools::install_github("amacanovic/KeynessMeasures")
```

## Demonstration

Using the `keyness_measure_calculator()` function, one can easily obtain
several measures of word keyness in a target corpus compared to the 
reference corpus.

First, loading the package:

```r
library(KeynessMeasures)
```


Demonstration using the Jane Austen data from the **janeaustenr** package (Silge, 2017).
We will be exploring key words in her novel "Emma" compared to 5 other novels.

```r
jane_austen_data <- janeaustenr::austen_books()
```

First, obtaining the word frequencies in "Emma" (target corpus) and the other
novels (reference corpus) using the `frequency_table()` function:

```r
frequency_table <- frequency_table_creator(jane_austen_data,
                                           text_field = "text",
                                           grouping_variable = "book",
                                           grouping_variable_target = "Emma",
                                           lemmatize = TRUE,
                                           remove_punct = TRUE,
                                           remove_symbols = TRUE,
                                           remove_numbers = TRUE,
                                           remove_url = TRUE)
```

Then, calculating all the keyness measures using the `keyness_measure_calculator()` function,
sorting the entries by highest values of log likelihood:


```r
keyness_measures <- keyness_measure_calculator(
  frequency_table,
  log_likelihood = TRUE,
  ell = TRUE,
  bic = TRUE,
  perc_diff = TRUE,
  relative_risk = TRUE,
  log_ratio = TRUE,
  odds_ratio = TRUE,
  sort = "decreasing",
  sort_by = "log_likelihood")
```

Displaying the first 10 rows of results sorted by log likelihood values:
<table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> freq_target_corpus </th>
   <th style="text-align:right;"> freq_reference_corpus </th>
   <th style="text-align:left;"> word_use </th>
   <th style="text-align:right;"> log_likelihood </th>
   <th style="text-align:right;"> ell </th>
   <th style="text-align:right;"> bic </th>
   <th style="text-align:right;"> perc_diff </th>
   <th style="text-align:right;"> relative_risk </th>
   <th style="text-align:right;"> log_ratio </th>
   <th style="text-align:right;"> odds_ratio </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 7594 </td>
   <td style="text-align:left;"> emma </td>
   <td style="text-align:right;"> 786 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 2350.3189 </td>
   <td style="text-align:right;"> 0.0006281 </td>
   <td style="text-align:right;"> 2336.8255 </td>
   <td style="text-align:right;"> 2.751670e+05 </td>
   <td style="text-align:right;"> 2752.6701 </td>
   <td style="text-align:right;"> 11.426616 </td>
   <td style="text-align:right;"> 2766.17371 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5442 </td>
   <td style="text-align:left;"> harriet </td>
   <td style="text-align:right;"> 415 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 1205.6112 </td>
   <td style="text-align:right;"> 0.0003670 </td>
   <td style="text-align:right;"> 1192.1178 </td>
   <td style="text-align:right;"> 3.623455e+04 </td>
   <td style="text-align:right;"> 363.3455 </td>
   <td style="text-align:right;"> 8.505198 </td>
   <td style="text-align:right;"> 364.28214 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7601 </td>
   <td style="text-align:left;"> weston </td>
   <td style="text-align:right;"> 389 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 1170.5395 </td>
   <td style="text-align:right;"> 0.0003623 </td>
   <td style="text-align:right;"> 1157.0461 </td>
   <td style="text-align:right;"> 2.416870e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 11.411857 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7613 </td>
   <td style="text-align:left;"> knightley </td>
   <td style="text-align:right;"> 356 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 1071.2392 </td>
   <td style="text-align:right;"> 0.0003383 </td>
   <td style="text-align:right;"> 1057.7458 </td>
   <td style="text-align:right;"> 2.211840e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 11.283964 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7622 </td>
   <td style="text-align:left;"> elton </td>
   <td style="text-align:right;"> 320 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 962.9117 </td>
   <td style="text-align:right;"> 0.0003117 </td>
   <td style="text-align:right;"> 949.4183 </td>
   <td style="text-align:right;"> 1.988170e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 11.130159 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7595 </td>
   <td style="text-align:left;"> woodhouse </td>
   <td style="text-align:right;"> 278 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 836.5295 </td>
   <td style="text-align:right;"> 0.0002800 </td>
   <td style="text-align:right;"> 823.0361 </td>
   <td style="text-align:right;"> 1.727223e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 10.927172 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7794 </td>
   <td style="text-align:left;"> fairfax </td>
   <td style="text-align:right;"> 210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 631.9108 </td>
   <td style="text-align:right;"> 0.0002269 </td>
   <td style="text-align:right;"> 618.4174 </td>
   <td style="text-align:right;"> 1.304737e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 10.522476 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7625 </td>
   <td style="text-align:left;"> churchill </td>
   <td style="text-align:right;"> 193 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 580.7561 </td>
   <td style="text-align:right;"> 0.0002133 </td>
   <td style="text-align:right;"> 567.2627 </td>
   <td style="text-align:right;"> 1.199115e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 10.400688 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1727 </td>
   <td style="text-align:left;"> frank </td>
   <td style="text-align:right;"> 200 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 532.1223 </td>
   <td style="text-align:right;"> 0.0001913 </td>
   <td style="text-align:right;"> 518.6289 </td>
   <td style="text-align:right;"> 7.682500e+03 </td>
   <td style="text-align:right;"> 77.8250 </td>
   <td style="text-align:right;"> 6.282162 </td>
   <td style="text-align:right;"> 77.92058 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7605 </td>
   <td style="text-align:left;"> hartfield </td>
   <td style="text-align:right;"> 159 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 478.4467 </td>
   <td style="text-align:right;"> 0.0001852 </td>
   <td style="text-align:right;"> 464.9533 </td>
   <td style="text-align:right;"> 9.878722e+16 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 10.121113 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
</tbody>
</table>
Instead, sorting the words by %DIFF measure:

<table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> freq_target_corpus </th>
   <th style="text-align:right;"> freq_reference_corpus </th>
   <th style="text-align:left;"> word_use </th>
   <th style="text-align:right;"> log_likelihood </th>
   <th style="text-align:right;"> ell </th>
   <th style="text-align:right;"> bic </th>
   <th style="text-align:right;"> perc_diff </th>
   <th style="text-align:right;"> relative_risk </th>
   <th style="text-align:right;"> log_ratio </th>
   <th style="text-align:right;"> odds_ratio </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 7601 </td>
   <td style="text-align:left;"> weston </td>
   <td style="text-align:right;"> 389 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 1170.5395 </td>
   <td style="text-align:right;"> 0.0003623 </td>
   <td style="text-align:right;"> 1157.0461 </td>
   <td style="text-align:right;"> 2.416870e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 11.411857 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7613 </td>
   <td style="text-align:left;"> knightley </td>
   <td style="text-align:right;"> 356 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 1071.2392 </td>
   <td style="text-align:right;"> 0.0003383 </td>
   <td style="text-align:right;"> 1057.7458 </td>
   <td style="text-align:right;"> 2.211840e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 11.283964 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7622 </td>
   <td style="text-align:left;"> elton </td>
   <td style="text-align:right;"> 320 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 962.9117 </td>
   <td style="text-align:right;"> 0.0003117 </td>
   <td style="text-align:right;"> 949.4183 </td>
   <td style="text-align:right;"> 1.988170e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 11.130159 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7595 </td>
   <td style="text-align:left;"> woodhouse </td>
   <td style="text-align:right;"> 278 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 836.5295 </td>
   <td style="text-align:right;"> 0.0002800 </td>
   <td style="text-align:right;"> 823.0361 </td>
   <td style="text-align:right;"> 1.727223e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 10.927172 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7794 </td>
   <td style="text-align:left;"> fairfax </td>
   <td style="text-align:right;"> 210 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 631.9108 </td>
   <td style="text-align:right;"> 0.0002269 </td>
   <td style="text-align:right;"> 618.4174 </td>
   <td style="text-align:right;"> 1.304737e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 10.522476 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7625 </td>
   <td style="text-align:left;"> churchill </td>
   <td style="text-align:right;"> 193 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 580.7561 </td>
   <td style="text-align:right;"> 0.0002133 </td>
   <td style="text-align:right;"> 567.2627 </td>
   <td style="text-align:right;"> 1.199115e+17 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 10.400688 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7605 </td>
   <td style="text-align:left;"> hartfield </td>
   <td style="text-align:right;"> 159 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 478.4467 </td>
   <td style="text-align:right;"> 0.0001852 </td>
   <td style="text-align:right;"> 464.9533 </td>
   <td style="text-align:right;"> 9.878722e+16 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 10.121113 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7635 </td>
   <td style="text-align:left;"> bate </td>
   <td style="text-align:right;"> 126 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 379.1465 </td>
   <td style="text-align:right;"> 0.0001570 </td>
   <td style="text-align:right;"> 365.6531 </td>
   <td style="text-align:right;"> 7.828421e+16 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 9.785510 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7607 </td>
   <td style="text-align:left;"> highbury </td>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 376.1374 </td>
   <td style="text-align:right;"> 0.0001562 </td>
   <td style="text-align:right;"> 362.6440 </td>
   <td style="text-align:right;"> 7.766291e+16 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 9.774015 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7684 </td>
   <td style="text-align:left;"> harriet's </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> overuse </td>
   <td style="text-align:right;"> 273.8280 </td>
   <td style="text-align:right;"> 0.0001257 </td>
   <td style="text-align:right;"> 260.3346 </td>
   <td style="text-align:right;"> 5.653860e+16 </td>
   <td style="text-align:right;"> Inf </td>
   <td style="text-align:right;"> 9.316025 </td>
   <td style="text-align:right;"> Inf </td>
  </tr>
</tbody>
</table>


