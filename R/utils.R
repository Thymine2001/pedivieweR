.load_rcpp_functions <- function() {
  use_rcpp <- FALSE
  
  if (requireNamespace("Rcpp", quietly = TRUE)) {
    tryCatch({
      if (!"Rcpp" %in% loadedNamespaces()) {
        loadNamespace("Rcpp")
      }
      
      if (!exists("fast_pedigree_qc", envir = .GlobalEnv)) {
        cpp_file <- system.file("src", "pedigree_qc.cpp", package = "pedivieweR")
        if (file.exists(cpp_file)) {
          Rcpp::sourceCpp(cpp_file)
          use_rcpp <- TRUE
          cat("[OK] Rcpp QC functions loaded successfully\n")
        } else {
          cpp_file <- "src/pedigree_qc.cpp"
          if (file.exists(cpp_file)) {
            Rcpp::sourceCpp(cpp_file)
            use_rcpp <- TRUE
            cat("[OK] Rcpp QC functions loaded successfully (from src/)\n")
          }
        }
      } else {
        use_rcpp <- TRUE
        cat("[OK] Rcpp QC functions already loaded\n")
      }
    }, error = function(e) {
      cat("Note: Rcpp not available or compilation failed, using optimized R functions\n")
      use_rcpp <- FALSE
    })
  } else {
    cat("Note: Rcpp package not available, using optimized R functions\n")
    use_rcpp <- FALSE
  }
  
  return(use_rcpp)
}

