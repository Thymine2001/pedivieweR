# Utility function to load Rcpp functions if available (internal use only)
.load_rcpp_functions <- function() {
  use_rcpp <- FALSE
  
  if (requireNamespace("Rcpp", quietly = TRUE)) {
    tryCatch({
      # Load Rcpp package
      if (!"Rcpp" %in% loadedNamespaces()) {
        loadNamespace("Rcpp")
      }
      
      # Try to load compiled function first (if package is installed)
      if (!exists("fast_pedigree_qc", envir = .GlobalEnv)) {
        # Try to source from package src directory
        cpp_file <- system.file("src", "pedigree_qc.cpp", package = "pedivieweR")
        if (file.exists(cpp_file)) {
          Rcpp::sourceCpp(cpp_file)
          use_rcpp <- TRUE
          cat("[OK] Rcpp QC functions loaded successfully\n")
        } else {
          # Fallback: try current directory (for development)
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

