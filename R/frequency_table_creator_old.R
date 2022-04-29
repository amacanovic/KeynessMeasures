#' Create the word frequency table of corpora
#'
#' This function takes a dataframe with needed documents as an input and
#' outputs a table with frequencies of each word in each of the two corpora.
#' The output contains the list of all words in two corpora and the frequencies
#' in the target and the reference corpus. The target corpus is defined by
#' specifying the grouping variable (denoting belonging of documents to corpora)
#' and the target value of the grouping variable (where the documents with the
#' matching value of the grouping variable are sorted into the target corpus,
#' while all the remaining documents are sorted into the refeence corpus).
#'
#' This code is compatible with quanteda package version below 3.
#'
#' @param df a \code{data.frame}
#' @param text_field a string; the name of the variable storing text
#' @param grouping_variable a string; the name of the variable to be
#' be used in the creation of the target and reference corpora. It's values are
#' used to group the documents into corpora and calculate appropriate
#' frequencies.
#' @param grouping_variable_target a string; the value of the variable
#' to use to create the target corpus. All the other values of this variable will
#' be grouped into a reference corpus.
#' @param lemmatize logical; if \code{TRUE}, the text will be lemmatized before
#' frequency calculation.
#' @param remove_punct logical; if \code{TRUE}, punctuation will be
#' removed when calculating the word frequency table.
#' @param remove_symbols logical; if \code{TRUE}, symbols will be
#' removed when calculating the word frequency table.
#' @param remove_numbers logical; if \code{TRUE}, numbers will be
#' removed when calculating the word frequency table.
#' @param remove_url logical; if \code{TRUE}, urls will be
#' removed when calculating the word frequency table.
#'
#'@return A dataframe with word frequencies in the target and reference corpora.
#'
#'@details Relies on textstem package for lemmatization and
#'quanteda package for frequency calculation
#'
#'@export
#'

frequency_table_creator_old <-  function(df,
                                     text_field = NULL,
                                     grouping_variable = NULL,
                                     grouping_variable_target = NULL,
                                     lemmatize = FALSE,
                                     remove_punct = FALSE,
                                     remove_symbols = FALSE,
                                     remove_numbers = FALSE,
                                     remove_url = FALSE) {



  if (is.null(text_field)) {
    stop("You have not specified the variable where the text is stored.")
  }

  if (is.null(grouping_variable)) {
    stop("You have not specified a grouping variable.")
  }

  if (is.null(grouping_variable_target)) {
    stop("You have not specified the value of the grouping variable denoting the
  target corpus.")
  }

  if (lemmatize) {

   df <- lemmatizing_function(df, text_field = text_field)
   text_field <- "text_lemmatized"

  }


  if (remove_punct) {

    remove_punct <-  TRUE

  }

  if (remove_symbols) {

    remove_symbols <- TRUE

  }

  if (remove_numbers) {

    remove_numbers <- TRUE

  }

  if (remove_url) {

    remove_url <- TRUE

  }

  corpus <- quanteda::corpus(df,
                             text_field = text_field)


  tokens <- quanteda::tokens(corpus,
                             remove_punct = remove_punct,
                             remove_symbols = remove_symbols,
                             remove_numbers  = remove_numbers,
                             remove_url = remove_url)

  dfm <- quanteda::dfm(tokens,
                       groups = grouping_variable)

  grouping_variable_target <- quanteda::docnames(dfm) == grouping_variable_target

  grouping_variable_factor <- factor(grouping_variable_target,
                                     levels = c(TRUE, FALSE),
                                     labels = c("target", "reference"))

  dfm_grouped <- quanteda::dfm_group(dfm,
                           groups=grouping_variable_factor)

  frequency_table <- quanteda::convert(dfm_grouped,
                             to="data.frame")

  rownames(frequency_table) <- frequency_table[, 1]

  frequency_table <- data.frame(t(frequency_table))[-1, ]

  frequency_table <- tibble::rownames_to_column(frequency_table, "word")

  frequency_table[, 2] <- as.numeric(as.character(frequency_table[, 2]))

  frequency_table[, 3] <- as.numeric(as.character(frequency_table[, 3]))


  return(frequency_table)

}
