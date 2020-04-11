#'@export
#'
#'
#functions calculating measures

#calculating expected and normalised frequencies for both corpora
parameter_prep <- function(f1, f2, nc1, nc2) {
  e1 <- nc1 * (f1 + f2) / (nc1 + nc2)
  e2 <- nc2 * (f1 + f2)/(nc1 + nc2)
  nf1 <- f1 / nc1
  nf2 <- f2 / nc2
  parameter_output <- list(e1 = e1, e2 = e2, nf1 = nf1, nf2 = nf2)
  return(parameter_output)
}

#calculating the log likelihood value as per the paper:
# Rayson, Paul, and Roger Garside. "Comparing corpora using frequency profiling."
# Proceedings of the workshop on Comparing corpora-Volume 9. Association for
# Computational Linguistics, 2000.
#'@export
#'
log_likelihood_calculator <- function(f1, f2, nc1, nc2) {
  parameters <- parameter_prep(f1, f2, nc1, nc2)
  e1 <- parameters$e1
  e2 <- parameters$e2
  nf1 <- parameters$nf1
  nf2 <- parameters$nf2


  if (f1==0 || e1==0){

    if (f2==0 || e2==0){

      log_lik_calc <- 2*((f1*0)+(f2*0))

    } else {

      log_lik_calc <- 2*((f1*0)+(f2*log(f2/e2)))

    }

  }

  else if (f2==0 || e2==0){

    log_lik_calc <- 2*((f1*log(f1/e1))+(f2*0))

  } else {

    log_lik_calc <- 2*((f1*log(f1/e1))+(f2*log(f2/e2)))

  }


  result <- data.frame(
    log_likelihood = log_lik_calc
  )

  return(result)
}

#calculating the $DIFF value as per the following:
# 1. Gabrielatos, C. and Marchi, A. (2012) Keyness: Appropriate metrics and practical
#    issues. CADS International Conference 2012. Corpus-assisted Discourse Studies:
#     More than the sum of Discourse Analysis and computing?, 13-14 September,
#     University of Bologna, Italy.
# 2. Gabrielatos, C. (2018). Keyness Analysis: nature, metrics and techniques.
#   In: Corpus Approaches to Discourse (pp. 225-258). Routledge.
#'@export
#'
perc_diff_calculator <- function(f1, f2, nc1, nc2){
  parameters <- parameter_prep(f1, f2, nc1, nc2)
  nf1 <- parameters$nf1
  nf2 <- parameters$nf2
  zero_freq_adjustment <- 0.000000000000000001

  if (nf2 == 0){

    perc_diff_calc <- ((nf1 - nf2) * 100) / zero_freq_adjustment

  } else {

    perc_diff_calc <- ((nf1 - nf2) * 100) / nf2

  }

  result <- data.frame(
    perc_diff = perc_diff_calc
  )

  return(result)
}

#Calculating the Bayes Information Criterion as per:
# Wilson, Andrew (2013) Embracing Bayes factors for key item analysis in corpus
# linguistics. In: New approaches to the study of linguistic variability. Language
# Competence and Language Awareness in Europe . Peter Lang, Frankfurt, pp. 3-11.
# ISBN 9783631615041
# #Interpretation and further advice:
# Gabrielatos, C. (2017, October). Clusters of keyness: A principled approach to
# selecting key items. In Corpus Linguistics in the South.
#'@export
#'
bic_calculator <- function(f1, f2, nc1, nc2){

  degrees_freedom <- 1
  log_likelihood_output <- log_likelihood_calculator(f1, f2, nc1, nc2)$log_likelihood

  bic_calc <- log_likelihood_output-(degrees_freedom*log(nc1+nc2))

  result <- data.frame(
    bic = bic_calc
  )

  return(result)
}

#Calculating the Effect Size for Log Likelihood as per the paper:
# Johnston, J. E., Berry, K. J., & Mielke Jr, P. W. (2006). Measures of effect size
# for chi-squared and likelihood-ratio goodness-of-fit tests. Perceptual and motor
# skills, 103(2), 412-414.
# Formula for the calculation as per the calculator by Paul Rayson at:
#http://ucrel.lancs.ac.uk/llwizard.html
#'@export
#'
ell_calculator <-  function(f1, f2, nc1, nc2){
  parameters <- parameter_prep(f1, f2, nc1, nc2)
  e1 <- parameters$e1
  e2 <- parameters$e2
  min_expected_f <- min(e1, e2)
  log_likelihood_output <- log_likelihood_calculator(f1, f2, nc1, nc2)$log_likelihood

  ell_calc <- log_likelihood_output / (sum(nc1 + nc2) * log(min_expected_f))

  result <- data.frame(
    ell = ell_calc
  )

  return(result)
}

#Calculating the relative risk - also known as the risk ratio as per Paul Rayson's
#website: http://ucrel.lancs.ac.uk/llwizard.html
#Used in clinical trials etc. Shows how much more likely a word is to appear in
#one corpus versus another.
#Also discussed in: Kilgarriff, A. 2009. Simple maths for keywords. In:
#Mahlberg, M., González-Díaz, V. & Smith, C. eds. Proceedings of the Corpus
#Linguistics Conference, CL2009. Liverpool
#'@export
#'
relative_risk_calculator <- function(f1, f2, nc1, nc2){
  parameters <- parameter_prep(f1, f2, nc1, nc2)
  nf1 <- parameters$nf1
  nf2 <- parameters$nf2
  relative_risk_calc <- nf1 / nf2

  result <- data.frame(
    relative_risk = relative_risk_calc
  )

  return(result)
}

#Calculating the log ratio (or: binary log of the ratio of relative frequencies),
#an adjustment of the masure above as suggested by Andrew Hardie in his article:
#https://cep932.wikispaces.com/Effect+Size
#This is just the log of the relative risk, which helps interpretability.
#'@export
#'
log_ratio_calculator <- function(f1, f2, nc1, nc2){
  parameters <- parameter_prep(f1, f2, nc1, nc2)
  nf1 <- parameters$nf1
  nf2 <- parameters$nf2
  zero_freq_adjustment <- 0.5

  if (nf1==0){

    if (nf2==0){

      log_ratio_calc = log((zero_freq_adjustment/nc1)/(zero_freq_adjustment/nc2), 2)

    } else {

      log_ratio_calc = log((zero_freq_adjustment/nc1)/nf2, 2)
    }

  } else if (nf2==0) {

    log_ratio_calc = log(nf1/(zero_freq_adjustment/nc2), 2)

  } else{

    log_ratio_calc = log(nf1/nf2, 2)

  }

  result <- data.frame(
    log_ratio = log_ratio_calc
  )

  return(result)
}

#Calculating the occurrence of the word in one group relative to its occurence
#in the other group. When the occurence is equal, the odds ratio is equal to one.
#'@export
#'
odds_ratio_calculator <- function(f1, f2, nc1, nc2){
  odds_ratio_calc = (f1/(nc1-f1))/(f2/(nc2-f2))

  result <- data.frame(
    odds_ratio = odds_ratio_calc
  )

  return(result)
}

