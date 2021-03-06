#Lemmatizer helper function

lemmatizing_function <- function(df,
                                 text_field = NULL){

  index <- 0
  index <- match(text_field, names(df))

  text_variable <- unlist(df[, index])
  text_lemmatized <- textstem::lemmatize_strings(text_variable)

  df <- cbind.data.frame(df, text_lemmatized, stringsAsFactors=FALSE)

  return(df)


}
