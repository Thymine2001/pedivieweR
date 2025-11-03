#' Create Pedigree Viewer Shiny Application
#'
#' This function creates and returns a Shiny application object for
#' the Pedigree Viewer. The app can be run using \code{\link{run_pedivieweR}}
#' or by passing the returned object to \code{\link[shiny]{runApp}}.
#'
#' @return A Shiny application object
#'
#' @importFrom shiny shinyApp runApp tags div h1 p hr h4 strong br sliderInput checkboxInput actionButton fileInput selectInput uiOutput verbatimTextOutput renderPrint renderUI reactive reactiveVal observeEvent showNotification req HTML fluidRow column conditionalPanel
#' @importFrom bslib bs_theme font_google page_fillable
#' @import visNetwork pedigreeTools digest
#' @importFrom shinyjs useShinyjs
#' @importFrom dplyr filter mutate select arrange bind_rows transmute row_number
#' @importFrom DT datatable renderDataTable dataTableOutput
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
  
  attach_if_not_loaded <- function(pkg) {
    pkg_name <- paste0("package:", pkg)
    if (!pkg_name %in% search()) {
      tryCatch({
        attachNamespace(pkg)
      }, error = function(e) {
        invisible(NULL)
      })
    }
  }
  
  packages_to_attach <- c("shiny", "bslib", "shinyjs", "dplyr", "DT", 
                          "pedigreeTools", "visNetwork", "igraph", "digest")
  
  for (pkg in packages_to_attach) {
    if (requireNamespace(pkg, quietly = TRUE)) {
      attach_if_not_loaded(pkg)
    }
  }
  
  use_rcpp <- .load_rcpp_functions()
  
  .pedivieweR_env <- new.env()
  .pedivieweR_env$use_rcpp <- use_rcpp
  
  app_file <- system.file("app", "app.R", package = "pedivieweR")
  if (!file.exists(app_file)) {
    if (file.exists("inst/app/app.R")) {
      app_file <- "inst/app/app.R"
    } else if (file.exists("app.R")) {
      app_file <- "app.R"
    } else {
      stop("Cannot find app.R file. Please ensure the package is properly installed.")
    }
  }
  
  app_env <- new.env(parent = .GlobalEnv)
  
  app_env$shiny <- getNamespace("shiny")
  app_env$bslib <- getNamespace("bslib")
  app_env$shinyjs <- getNamespace("shinyjs")
  app_env$dplyr <- getNamespace("dplyr")
  app_env$DT <- getNamespace("DT")
  app_env$pedigreeTools <- getNamespace("pedigreeTools")
  app_env$visNetwork <- getNamespace("visNetwork")
  app_env$igraph <- getNamespace("igraph")
  app_env$digest <- getNamespace("digest")
  
  if (requireNamespace("Rcpp", quietly = TRUE)) {
    app_env$Rcpp <- getNamespace("Rcpp")
    app_env$sourceCpp <- get("sourceCpp", envir = getNamespace("Rcpp"))
  }
  
  app_env$use_rcpp <- use_rcpp
  
  source(app_file, local = app_env)
  if (!exists("ui", envir = app_env) || !exists("server", envir = app_env)) {
    stop("app.R must define 'ui' and 'server' objects")
  }
  
  ui <- get("ui", envir = app_env)
  server <- get("server", envir = app_env)
  
  shiny::shinyApp(ui = ui, server = server)
}

