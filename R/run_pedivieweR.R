#' Launch Pedigree Viewer Shiny Application
#'
#' This function launches the Pedigree Viewer Shiny application,
#' which provides an interactive interface for viewing and analyzing pedigree data.
#'
#' @param host The IPv4 address that the application should listen on.
#'   Defaults to '127.0.0.1'. Use '0.0.0.0' to run on all network interfaces.
#' @param port The TCP port that the application should listen on.
#'   If NULL, a random available port will be used.
#' @param launch.browser If TRUE, the system's default web browser will be
#'   launched automatically after the app is started. Defaults to TRUE.
#' @param ... Additional arguments passed to \code{\link[shiny]{runApp}}.
#'
#' @return This function does not return a value. The Shiny application
#'   will run until interrupted (e.g., by pressing Ctrl+C or Esc).
#'
#' @examples
#' \dontrun{
#' # Launch the application with default settings
#' run_pedivieweR()
#' 
#' # Launch on a specific port
#' run_pedivieweR(port = 3838)
#' 
#' # Launch without opening browser automatically
#' run_pedivieweR(launch.browser = FALSE)
#' }
#'
#' @import shiny
#' @export
run_pedivieweR <- function(host = "127.0.0.1", 
                          port = NULL, 
                          launch.browser = TRUE,
                          ...) {
  # Check if required packages are installed
  required_packages <- c("shiny", "bslib", "shinyjs", "dplyr", "DT", 
                         "pedigreeTools", "visNetwork", "igraph", "digest")
  
  missing_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]
  
  if (length(missing_packages) > 0) {
    stop("The following required packages are not installed: ", 
         paste(missing_packages, collapse = ", "), 
         "\nPlease install them using: install.packages(c('", 
         paste(missing_packages, collapse = "', '"), "'))")
  }
  
  # Load the app
  app <- pedivieweR_app()
  
  # Run the app
  shiny::runApp(app, host = host, port = port, launch.browser = launch.browser, ...)
}

