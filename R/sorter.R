#A helper function that takes sorts the output of a measure calculator
#'@export
#'
sorting_function <- function(measures,
                             sort = c("none", "decreasing","increasing"),
                             sort_by = c("log_likelihood", "perc_diff","bic", "ell", "relative_risk","log_ratio", "odds_ratio")){


  sort <- ifelse(is.null(match.arg(sort)), "none", match.arg(sort))
  sort_by <- ifelse(is.null(match.arg(sort_by)), "log_likelihood", match.arg(sort_by))


  if (sort == "none"){

    sorted_measures <- measures

  } else {

    if (sort_by == "log_likelihood"){

      if (sort == "decreasing") {

        sorted_measures <- measures[order(-measures$log_likelihood),]

      }

      if (sort == "increasing") {

        sorted_measures <- measures[order(measures$log_likelihood),]

      }}

    if (sort_by == "perc_diff"){

      if (sort == "decreasing") {

        sorted_measures <- measures[order(-measures$perc_diff),]

      }

      if (sort == "increasing") {

        sorted_measures <- measures[order(measures$perc_diff),]

      }
    }

    if (sort_by == "bic"){

      if (sort == "decreasing") {

        sorted_measures <- measures[order(-measures$bic),]

      }

      if (sort == "increasing") {

        sorted_measures <- measures[order(measures$bic),]

      }
    }

    if (sort_by == "ell"){

      if (sort == "decreasing") {

        sorted_measures <- measures[order(-measures$ell),]

      }

      if (sort == "increasing") {

        sorted_measures <- measures[order(measures$ell),]

      }
    }

    if (sort_by == "relative_risk"){

      if (sort == "decreasing") {

        sorted_measures <- measures[order(-measures$relative_risk),]

      }

      if (sort == "increasing") {

        sorted_measures <- measures[order(measures$relative_risk),]

      }
    }

    if (sort_by == "log_ratio"){

      if (sort == "decreasing") {

        sorted_measures <- measures[order(-measures$log_ratio),]

      }

      if (sort == "increasing") {

        sorted_measures <- measures[order(measures$log_ratio),]

      }
    }

    if (sort_by == "odds_ratio"){

      if (sort == "decreasing") {

        sorted_measures <- measures[order(-measures$log_ratio),]

      }

      if (sort == "increasing") {

        sorted_measures <- measures[order(measures$log_ratio),]

      }
    }
  }

  return(sorted_measures)

}
