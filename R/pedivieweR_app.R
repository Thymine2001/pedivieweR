#' Create Pedigree Viewer Shiny Application
#'
#' This function creates and returns a Shiny application object for
#' the Pedigree Viewer. The app can be run using \code{\link{run_pedivieweR}}
#' or by passing the returned object to \code{\link[shiny]{runApp}}.
#'
#' @return A Shiny application object
#'
#' @import shiny bslib shinyjs pedigreeTools visNetwork digest
#' @importFrom DT datatable renderDataTable dataTableOutput
#' @importFrom dplyr filter mutate select arrange bind_rows transmute row_number
#' @importFrom igraph graph_from_data_frame components V cluster_louvain
#' @export
pedivieweR_app <- function() {
  
  # Load required packages
  if (!requireNamespace("shiny", quietly = TRUE)) stop("shiny package is required")
  if (!requireNamespace("bslib", quietly = TRUE)) stop("bslib package is required")
  if (!requireNamespace("shinyjs", quietly = TRUE)) stop("shinyjs package is required")
  if (!requireNamespace("dplyr", quietly = TRUE)) stop("dplyr package is required")
  if (!requireNamespace("DT", quietly = TRUE)) stop("DT package is required")
  if (!requireNamespace("pedigreeTools", quietly = TRUE)) stop("pedigreeTools package is required")
  if (!requireNamespace("visNetwork", quietly = TRUE)) stop("visNetwork package is required")
  if (!requireNamespace("igraph", quietly = TRUE)) stop("igraph package is required")
  if (!requireNamespace("digest", quietly = TRUE)) stop("digest package is required")
  
  # Load libraries (required for Shiny apps)
  # Note: We need to actually load these packages for Shiny apps to work
  # They are already declared in DESCRIPTION as Depends, so they should be auto-attached
  # But we use a safe wrapper to avoid errors if they're already attached
  attach_if_not_loaded <- function(pkg) {
    # Check if package is already in the search path
    pkg_name <- paste0("package:", pkg)
    if (!pkg_name %in% search()) {
      # Try to attach, suppress error if it fails
      tryCatch({
        attachNamespace(pkg)
      }, error = function(e) {
        # If attach fails, it might already be loaded, just continue
        invisible(NULL)
      })
    }
  }
  
  # Since these are in Depends, they should be auto-attached when package loads
  # But we ensure they're available for the sourced app.R
  packages_to_attach <- c("shiny", "bslib", "shinyjs", "dplyr", "DT", 
                          "pedigreeTools", "visNetwork", "igraph", "digest")
  
  for (pkg in packages_to_attach) {
    if (requireNamespace(pkg, quietly = TRUE)) {
      attach_if_not_loaded(pkg)
    }
  }
  
  # Try to load Rcpp QC function
  use_rcpp <- .load_rcpp_functions()
  
  # Store use_rcpp in a way accessible to server
  .pedivieweR_env <- new.env()
  .pedivieweR_env$use_rcpp <- use_rcpp
  
  # Source the app code from inst/app/app.R
  app_file <- system.file("app", "app.R", package = "pedivieweR")
  if (!file.exists(app_file)) {
    # Fallback for development: try inst/app/app.R or app.R
    if (file.exists("inst/app/app.R")) {
      app_file <- "inst/app/app.R"
    } else if (file.exists("app.R")) {
      app_file <- "app.R"
    } else {
      stop("Cannot find app.R file. Please ensure the package is properly installed.")
    }
  }
  
  # Create a temporary environment to source the app into
  app_env <- new.env(parent = .GlobalEnv)
  
  # Make packages available in the sourced environment
  # Use getFromNamespace to avoid global variable warnings
  app_env$shiny <- getNamespace("shiny")
  app_env$bslib <- getNamespace("bslib")
  app_env$shinyjs <- getNamespace("shinyjs")
  app_env$dplyr <- getNamespace("dplyr")
  app_env$DT <- getNamespace("DT")
  app_env$pedigreeTools <- getNamespace("pedigreeTools")
  app_env$visNetwork <- getNamespace("visNetwork")
  app_env$igraph <- getNamespace("igraph")
  app_env$digest <- getNamespace("digest")
  
  # Make Rcpp available if needed
  if (requireNamespace("Rcpp", quietly = TRUE)) {
    app_env$Rcpp <- getNamespace("Rcpp")
    app_env$sourceCpp <- get("sourceCpp", envir = getNamespace("Rcpp"))
  }
  
  # Pre-set use_rcpp in the environment (app.R will override if needed)
  app_env$use_rcpp <- use_rcpp
  
  # Source the app code (which defines ui and server)
  source(app_file, local = app_env)
  
  # Extract ui and server from the sourced environment
  if (!exists("ui", envir = app_env) || !exists("server", envir = app_env)) {
    stop("app.R must define 'ui' and 'server' objects")
  }
  
  ui <- get("ui", envir = app_env)
  server <- get("server", envir = app_env)
  
  # Create and return the Shiny app
  shiny::shinyApp(ui = ui, server = server)
}

