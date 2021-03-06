## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=F, message=FALSE, warning = FALSE----------------------------------
#  devtools::install_github("amacanovic/KeynessMeasures")

## ---- message=FALSE, warning = FALSE------------------------------------------
library(KeynessMeasures)

## ---- eval=F, echo=T----------------------------------------------------------
#  install.packages("janeaustenr")

## ---- message=FALSE, warning = FALSE------------------------------------------
library(janeaustenr)
novels <- austen_books()

## ---- echo=FALSE, message=FALSE, warning = FALSE------------------------------
display <- novels[10:20,]
library(knitr)
library(kableExtra)
kable(head(display, n=10) ,"html", booktabs = T) %>%
  kable_styling(bootstrap_options="striped", full_width=T)

## ---- eval=F------------------------------------------------------------------
#  frequency_table_creator(
#    df,
#    text_field = NULL,
#    grouping_variable = NULL,
#    grouping_variable_target = NULL,
#    lemmatize = FALSE,
#    remove_punct = FALSE,
#    remove_symbols = FALSE,
#    remove_numbers = FALSE,
#    remove_url = FALSE
#  )

## -----------------------------------------------------------------------------
frequency_table <- frequency_table_creator(novels,
                                           text_field = "text",
                                           grouping_variable = "book",
                                           grouping_variable_target = "Emma",
                                           lemmatize = TRUE,
                                           remove_punct = TRUE,
                                           remove_symbols = TRUE,
                                           remove_numbers = TRUE,
                                           remove_url = TRUE)

## ---- echo=FALSE, message=FALSE-----------------------------------------------
kable(head(frequency_table, n=10) ,"html", booktabs = T) %>%
  kable_styling(bootstrap_options="striped", full_width=T)

## ---- eval=F------------------------------------------------------------------
#  keyness_measure_calculator(
#    df,
#    log_likelihood = TRUE,
#    ell = TRUE,
#    bic = TRUE,
#    perc_diff = TRUE,
#    relative_risk = TRUE,
#    log_ratio = TRUE,
#    odds_ratio = TRUE,
#    sort = c("none", "decreasing", "increasing"),
#    sort_by = c("log_likelihood", "perc_diff", "bic", "ell", "relative_risk",
#      "log_ratio", "odds_ratio")
#  )

## -----------------------------------------------------------------------------
stat_sign_measures <- keyness_measure_calculator(
  frequency_table,
  log_likelihood = TRUE,
  ell = FALSE,
  bic = TRUE,
  perc_diff = FALSE,
  relative_risk = FALSE,
  log_ratio = FALSE,
  odds_ratio = FALSE,
  sort = "decreasing",
  sort_by = "log_likelihood")


## ---- echo=FALSE, message=FALSE-----------------------------------------------
kable(head(stat_sign_measures, n=15, row.names = NA) ,"html", booktabs = T) %>%
  kable_styling(bootstrap_options="striped", full_width=T)

## ---- echo=FALSE, message=FALSE, warning = FALSE------------------------------
library(readr)
ll_table <- read_csv("LLtable.csv")
kable(head(ll_table, n=15) ,"html", booktabs = T) %>%
  kable_styling(bootstrap_options="striped", full_width=F)

## ---- echo=FALSE, message=FALSE, warning = FALSE------------------------------
bf_table <- read_csv("BFtable.csv")
kable(head(bf_table, n=15) ,"html", booktabs = T) %>%
  kable_styling(bootstrap_options="striped", full_width=F)

## -----------------------------------------------------------------------------
effect_size_measures <- keyness_measure_calculator(
  frequency_table,
  log_likelihood = FALSE,
  ell = TRUE,
  bic = FALSE,
  perc_diff = TRUE,
  relative_risk = TRUE,
  log_ratio = TRUE,
  odds_ratio = TRUE,
  sort = "decreasing",
  sort_by = "perc_diff")

## ---- echo=FALSE, message=FALSE-----------------------------------------------
kable(head(effect_size_measures, n=15, row.name=NA) ,"html", booktabs = T) %>%
  kable_styling(bootstrap_options="striped", full_width=T)

## ---- echo=FALSE, message=FALSE, warning=FALSE--------------------------------
library(dplyr)
all_measures <- keyness_measure_calculator(
  frequency_table,
  log_likelihood = TRUE,
  ell = TRUE,
  bic = TRUE,
  perc_diff = TRUE,
  relative_risk = TRUE,
  log_ratio = TRUE,
  odds_ratio = TRUE,
  sort = "decreasing",
  sort_by = "perc_diff")

emma_mr <-filter(all_measures, word == "emma"| word =="mr")



## ---- echo=FALSE, message=FALSE-----------------------------------------------
kable(head(emma_mr, n=15) ,"html", booktabs = T) %>%
  kable_styling(bootstrap_options="striped", full_width=F)

