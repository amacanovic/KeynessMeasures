#' Calculate the keyness measures
#'
#' This function takes a dataframe with word frequencies in two corpora (target
#' and reference). Used on the output of the  \code{\link{frequency_table_creator}}.
#' Supports Log Likelihood and Bayes Information Criterion as statistical
#' significance measures and \%DIFF, Relative Risk, Log Ratio and Odds Ratio as
#' effect size measures of Keyness. Calculates the keyness in the target corpus
#' versus the reference corpus. The user can specify which measures are calculated.
#' The output data.frame table can be sorted by decreasing or increasing value
#' of any calculated measure.
#'
#' @param df a \code{data.frame}
#' @param log_likelihood logical; if \code{TRUE}, the log likelihood measure is
#' calculated for each word
#' @param ell logical; if \code{TRUE}, the effect size of the log likelihood
#' measure is calculated for each word
#' @param bic logical; if \code{TRUE}, the Bayes Information Criterion is calculated
#' for each word
#' @param perc_diff logical; if \code{TRUE}, the \%DIFF measure is calculated for
#' each word
#' @param relative_risk logical; if \code{TRUE}, the Relative Risk measure is
#' calculated for each word
#' @param log_ratio logical; if \code{TRUE}, the Log Ratio measure is calculated
#' for each word
#' @param odds_ratio logical; if \code{TRUE}, the Odds Ratio measure is
#' calculated for each word
#' @param sort if \code{"none"}, the resulting table of measures will not be
#' sorted; if \code{"decreasing"}, the table will be sorted starting with the
#' highest value of the measure chosen as the reference for sorting; if
#' \code{"increasing"}, the table will be sorted starting with the lowest value
#' of the measures chosen as the reference for sorting.
#' @param sort_by specifies which measure should be used as a reference for table
#' sorting. If parameter sort is set to \code{"decreasing"} or
#' \code{"increasing"} and nothing is specified in this parameter, it will
#' default to \code{"log_likelihood"}.
#'
#'@return A dataframe with word frequencies in the target and reference corpora
#'and the chosen keyness measures calculated for the target corpus against the
#'reference corpus.
#'
#'@details \itemize{
#'  \item Log Likelihood is calculated as specified in Rayson and Garside (2000).
#'  \item ELL - the Effect Size of Log Likelihood is calculated as per Johnston
#'  et al. (2006). This implementation is based on Paul Rayson's
#'  formula as per his \href{http://ucrel.lancs.ac.uk/llwizard.html}{website}.
#'  \item The Bayes Information Criterion is calculated as proposed in Wilson (2013),
#'  the interpretation is available in Gabrielator (2017). This implementation is
#'  based on Paul Rayson's formula as per his
#'  \href{http://ucrel.lancs.ac.uk/llwizard.html}{website}.
#'  \item The \%DIFF measure is calculated as per Gabrielatos and Marchi (2012)
#'  and Gabrielatos (2018).
#'  \item The Relative Risk (also known as the Risk Ratio) is disscussed in
#'  Kilgarriff (2009). This implementation is based on Paul Rayson's
#'  formula as per his \href{http://ucrel.lancs.ac.uk/llwizard.html}{website}.
#'  \item The Log Ratio measure is related to the Relative Risk measure (also
#'  known as the binary log of the ratio of relative frequencies). Implemented as
#'  proposed by Hardie as per this
#'  \href{http://cass.lancs.ac.uk/log-ratio-an-informal-introduction/}{blog article}.
#'  \item The Odds Ratio calculates the occurence of the word in one corpus
#'  relative to its occurence in another corpus. This implementation is based on
#'  Paul Rayson's formula as per his
#'  \href{http://ucrel.lancs.ac.uk/llwizard.html}{website}.}
#'
#'@references \itemize{
#'  \item Gabrielatos, C. (2017) Clusters of keyness: A principled approach to
#'   selecting key items. In: Corpus Linguistics in the South.
#'  \item Gabrielatos, C. (2018) Keyness Analysis: nature, metrics and techniques.
#'   In: Corpus Approaches to Discourse (pp. 225-258). Routledge.
#'  \item Gabrielatos, C. and Marchi, A. (2012) Keyness: Appropriate metrics
#'    and practical issues. CADS International Conference 2012. Corpus-assisted
#'    Discourse Studies: More than the sum of Discourse Analysis and computing?,
#'     13-14 September, University of Bologna, Italy.
#'  \item Hardie, A (2014) 4. Log ratio – an informal introduction. Post on the
#'  website of the ESRC Centre for Corpus Approaches to Social Science CASS.
#'  Retrieved from: http://cass.lancs.ac.uk/?p=1133.
#'  \item Johnston, J.E., Berry, K.J. and Mielke, P.W. (2006) Measures of effect
#'   size for chi-squared and likelihood-ratio goodness-of-fit tests. Perceptual
#'    and Motor Skills: Volume 103, Issue , pp. 412-414.
#'  \item Kilgarriff, A. 2009. Simple maths for keywords. In: Mahlberg, M.,
#'  González-Díaz, V. & Smith, C. eds. Proceedings of the Corpus Linguistics
#'  Conference, CL2009. Liverpool
#'  \item Rayson, P. and Garside, R. (2000) Comparing corpora using frequency
#'  profiling. In proceedings of the workshop on Comparing Corpora,
#'  held in conjunction with the 38th annual meeting of the Association for
#'  Computational Linguistics (ACL 2000), pp. 1 - 6.
#'  \item Rayson, P. (2019) Log-likelihood and effect size calculator. Website.
#'  Retrieved from: http://ucrel.lancs.ac.uk/llwizard.html.
#'  }
#'
#'@export
#'




keyness_measure_calculator <- function(df,
                                       log_likelihood = TRUE,
                                       ell = TRUE,
                                       bic = TRUE,
                                       perc_diff = TRUE,
                                       relative_risk = TRUE,
                                       log_ratio = TRUE,
                                       odds_ratio = TRUE,
                                       sort = c("none", "decreasing","increasing"),
                                       sort_by = c("log_likelihood", "perc_diff","bic", "ell", "relative_risk","log_ratio", "odds_ratio")){

  one <- FALSE
  two <- FALSE
  three <- FALSE
  four <- FALSE
  five <- FALSE
  six <- FALSE
  seven <- FALSE

  if (log_likelihood) {

    one <-  TRUE
    log_likelihood <- numeric(nrow(df))

  }

  if (ell) {

    two <- TRUE
    ell <- numeric(nrow(df))

  }

  if (bic) {

    three <- TRUE
    bic <- numeric(nrow(df))

  }

  if (perc_diff) {

    four <- TRUE
    perc_diff <- numeric(nrow(df))

  }

  if (relative_risk) {

    five <- TRUE
    relative_risk <- numeric(nrow(df))

  }

  if (log_ratio) {

    six <- TRUE
    log_ratio <- numeric(nrow(df))


  }

  if (odds_ratio) {

    seven <- TRUE
    odds_ratio <- numeric(nrow(df))

  }

  word <- character(nrow(df))
  freq_target_corpus <- numeric(nrow(df))
  freq_reference_corpus <- numeric(nrow(df))

  i <- 1
  nc1 <- sum(df[,2])
  nc2 <- sum(df[,3])

  for (i in 1:nrow(df)){
    word[i] <- df[i,1]
    f1 <- df[i,2]
    f2 <- df[i,3]
    freq_target_corpus[i]<- f1
    freq_reference_corpus[i] <- f2


    if (one) {

      log_likelihood[i] <- log_likelihood_calculator(f1, f2, nc1, nc2)
    }

    if (two) {

      ell[i]<- ell_calculator(f1, f2, nc1, nc2)


    }

    if (three) {

      bic[i] <- bic_calculator(f1, f2, nc1, nc2)

    }

    if (four) {

      perc_diff[i] <- perc_diff_calculator(f1, f2, nc1, nc2)

    }

    if (five) {

      relative_risk[i] <- relative_risk_calculator(f1, f2, nc1, nc2)
    }

    if (six) {

      log_ratio[i] <- log_ratio_calculator(f1, f2, nc1, nc2)

    }

    if (seven) {

      odds_ratio[i]<- odds_ratio_calculator(f1, f2, nc1, nc2)
    }

  }

  word <- as.character(unlist(word))
  freq_target_corpus <- as.numeric(unlist(freq_target_corpus))
  freq_reference_corpus <- as.numeric(unlist(freq_reference_corpus))

  log_likelihood <- unlist(log_likelihood)
  ell <- unlist(ell)
  bic <- unlist(bic)
  perc_diff <- unlist(perc_diff)
  relative_risk <- unlist(relative_risk)
  log_ratio <- unlist(log_ratio)
  odds_ratio <- unlist(odds_ratio)

  measures <- cbind.data.frame(word,freq_target_corpus,freq_reference_corpus, stringsAsFactors=FALSE)

  if (one) {

    measures <- cbind.data.frame(measures,log_likelihood, stringsAsFactors = FALSE)
  }

  if (two) {

    measures <- cbind.data.frame(measures,ell, stringsAsFactors = FALSE)

  }

  if (three) {

    measures <- cbind.data.frame(measures,bic, stringsAsFactors = FALSE)

  }

  if (four) {

    measures <- cbind.data.frame(measures,perc_diff, stringsAsFactors = FALSE)

  }

  if (five) {

    measures <- cbind.data.frame(measures,relative_risk, stringsAsFactors = FALSE)
  }

  if (six) {

    measures <- cbind.data.frame(measures,log_ratio, stringsAsFactors = FALSE)

  }

  if (seven) {

    measures <- cbind.data.frame(measures,odds_ratio, stringsAsFactors = FALSE)
  }


  sorted_measures <- sorting_function(measures,
                                      sort=sort,
                                      sort_by=sort_by)



  return(sorted_measures)

}
