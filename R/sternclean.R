#' A cleaner way to clean your data.
#'
#' A cleaner way to clean your data. It's recommended to keep all
#' parameters lined up and on separate lines to produce greater
#' readability and to make debugging easier. The function edits
#' the data frame and automatically assigns the results to the
#' data frames. We have kept the parameters starting with 3
#' separate verbs to make finding the correct parameter easier.
#' after typing either class, remove, or impute. One can simply
#' use tab to fill in the specific action they prefer.
#'
#'
#' @param the_data_frame tbl
#' @param class_to_strng vector of columns to convert to string.
#' @param class_to_numer vector of columns to convert to numeric.
#' @param remove_columns vector of columns to remove from tbl.
#' @param remove_na_rows vector of columns to remove rows by their NAs.
#' @param removeby_regex vector of columns found by regex to remove.
#' @param remove_all_nas TRUE/FALSE to remove all NAs by row. Default: False.
#' @param remove_non_num TRUE/FALSE to remove non-numeric columns. Default: False.
#' @param remove_all_exc vector of columns to keep. Remove all other columns.
#' @param impute_na2mean vector of columns to impute NAs with the column mean.
#' @param impute_na_cols vector of columns to impute with value given by the impute_na_with parameter.
#' @param impute_na_with value to impute in the vector of columnns from the impute_na_cols parameter.
#' @param impute_grpmean vector of columns to replace NAs with a groupmean, grouped by the impute_grpwith parameter.
#' @param impute_grpwith column to use as the group for the vector of columns defined by the impute_grpmean parameter.
#' @param impute_inf_col vector of columns to impute infinite values with the impute_inf_wit parameter value.
#' @param impute_inf_wit value to impute in the vector of columnns from the impute_inf_col parameter.
#' @param impute_cust_cl vector of columns to impute NAs with based on the function defined by the impute_cust_fn parameter.
#' @param impute_cust_fn function to impute the NAs over the columns defined in the impute_cust_cl parameter.
#' @param ... additional parameters for the function from the impute_cust_fn parameter.
#' @examples
#' sternclean("airquality",
#'        impute_na2mean = c("Ozone", "Solar.R"))
#' sternclean("airquality",
#'        impute_na_cols = c("Ozone", "Solar.R"),
#'        impute_na_with = 1738)
#' sternclean("airquality",
#'        remove_columns = "Day"
#'        impute_na_cols = "Solar.R",
#'        impute_na_with = 1738)




sternclean <- function(the_data_frame = "the_data_frame",
                   #type change
                   class_to_strng = "",
                   class_to_numer = "",
                   #remove
                   remove_columns = "",
                   remove_na_rows = "",
                   removeby_regex = "",
                   remove_all_nas = FALSE,
                   remove_non_num = FALSE,
                   remove_all_exc = "",
                   #impute
                   impute_na2mean = "",
                   impute_na_cols = "",
                   impute_na_with = "",
                   impute_grpmean = "",
                   impute_grpwith = "",
                   impute_inf_col = "",
                   impute_inf_wit = "",
                   impute_cust_cl = "",
                   impute_cust_fn = "",
                   ...){
  #string to name
  the_data_frame_eval <- eval(as.name(the_data_frame))
  the_data_frame_eval <- data.frame(the_data_frame_eval)

  assign(the_data_frame,
         the_data_frame_eval[ , !names(the_data_frame_eval) %in% remove_columns], envir = .GlobalEnv)
  the_data_frame_eval <- eval(as.name(the_data_frame))


  if(class_to_numer[1] != ""){
    the_data_frame_eval[, class_to_numer] <- as.numeric(the_data_frame_eval[, class_to_numer])
    assign(the_data_frame, the_data_frame_eval, envir = .GlobalEnv)
    the_data_frame_eval <- eval(as.name(the_data_frame))

  }



  if(class_to_strng[1] != ""){
    the_data_frame_eval[, class_to_strng] <- as.character(the_data_frame_eval[, class_to_strng])
    assign(the_data_frame, the_data_frame_eval, envir = .GlobalEnv)
    the_data_frame_eval <- eval(as.name(the_data_frame))

  }


  if(remove_all_exc[1] != ""){
    the_data_frame_eval <- the_data_frame_eval[, remove_all_exc]
    assign(the_data_frame, the_data_frame_eval, envir = .GlobalEnv)
  }

  if(removeby_regex != ""){
    the_data_frame_eval[grepl(removeby_regex, names(the_data_frame_eval))] <- NULL
    #set to global envirnment
    assign(the_data_frame, the_data_frame_eval, envir = .GlobalEnv)
  }

  if(remove_all_nas == TRUE){
    assign(the_data_frame,
           the_data_frame_eval[!rowSums(is.na(the_data_frame_eval)) > 0, ],
           envir = .GlobalEnv)
    the_data_frame_eval <- eval(as.name(the_data_frame))

  }


  if(remove_non_num == TRUE){
    assign(the_data_frame,
           the_data_frame_eval[, sapply(the_data_frame_eval, is.numeric)],
           envir = .GlobalEnv)
    the_data_frame_eval <- eval(as.name(the_data_frame))
  }

  #replacement version
  if(impute_na_cols[1] != ""){
    for (i in 1:length(impute_na_cols)){

      the_data_frame_eval[is.na(the_data_frame_eval[, impute_na_cols[i]]), impute_na_cols[i]]  <- impute_na_with


    }
    assign(the_data_frame, the_data_frame_eval,  envir = .GlobalEnv)
    the_data_frame_eval  <-  eval(as.name(the_data_frame))

  }


  #replace infinite columns
  if(impute_inf_col[1] != ""){
    for (i in 1:length(impute_inf_col)){

      the_data_frame_eval[is.infinite(the_data_frame_eval[, impute_inf_col[i]]), impute_inf_col[i]]  <- impute_inf_wit


    }
    assign(the_data_frame, the_data_frame_eval,  envir = .GlobalEnv)
    the_data_frame_eval  <-  eval(as.name(the_data_frame))

  }


  if(remove_na_rows[1] != ""){
    for (i in 1:length(remove_na_rows)){
      assign(the_data_frame,
             the_data_frame_eval[!is.na(the_data_frame_eval[, remove_na_rows[i]]), ], envir = .GlobalEnv)
      the_data_frame_eval <-eval(as.name(the_data_frame))
    }
  }


  if(impute_na2mean[1] != ""){
    #loop through columns to impute with mean
    for (i in 1:length(impute_na2mean)){
      the_data_frame_eval[, impute_na2mean[i]][is.na(the_data_frame_eval[, impute_na2mean[i]])] <- mean(the_data_frame_eval[, impute_na2mean[i]], na.rm=TRUE)

      assign(the_data_frame, the_data_frame_eval, envir = .GlobalEnv)
      the_data_frame_eval <-eval(as.name(the_data_frame))
    }
  }

  if(impute_cust_cl[1] != ""){
    #loop through columns to impute with custom
    for (i in 1:length(impute_cust_cl)){
      # the_data_frame_eval[, impute_cust_cl[i]][is.na(the_data_frame_eval[, impute_cust_cl[i]])] <- custom_function(the_data_frame_eval[, impute_cust_cl[i]], ...)
      the_data_frame_eval[is.na(the_data_frame_eval[, impute_cust_cl[i]]), impute_cust_cl[i]] <- impute_cust_fn(the_data_frame_eval[, impute_cust_cl[i]], ...)
      assign(the_data_frame, the_data_frame_eval, envir = .GlobalEnv)
    }
  }

  if(impute_grpmean[1] != ""){
    #loop through columns to impute with mean
    for (i in 1:length(impute_grpmean)){
      mutate_call1 <- lazyeval::interp(~ mean(a, na.rm = TRUE), a = as.name(impute_grpmean[i]))
      mutate_call2 <- lazyeval::interp(~ ifelse(is.na(b)==TRUE, a, b), a = as.name("avg"), b = as.name(impute_grpmean[i]))
      the_col_name1 <- "avg"
      the_col_name2 <- impute_grpmean[i]
      the_data_frame_eval <- the_data_frame_eval %>%
        dplyr::group_by_(.dots = list(impute_grpwith)) %>%
        dplyr::mutate_(.dots = setNames(list(mutate_call1), the_col_name1)) %>%
        dplyr::summarise_(.dots = setNames(list(mutate_call1), the_col_name1)) %>%
        merge(the_data_frame_eval, ., all.x=TRUE) %>%
        dplyr::ungroup() %>%
        dplyr::mutate_(.dots = setNames(list(mutate_call2), the_col_name2)) %>%
        dplyr::select(-avg)

      assign(the_data_frame, the_data_frame_eval, envir = .GlobalEnv)
      the_data_frame_eval <- eval(as.name(the_data_frame))
    }
  }

}
