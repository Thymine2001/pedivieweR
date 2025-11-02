# pedivieweR

A Shiny application package for viewing and analyzing pedigree data with interactive network visualization.

License: GPL-3

## Installation

To use this package, you can install it directly from the source:

```r
# Install required dependencies first
install.packages(c("shiny", "bslib", "shinyjs", "dplyr", "DT", 
                   "pedigreeTools", "visNetwork", "igraph", "digest", "Rcpp"))

# Install this package (if using devtools)
devtools::install("path/to/pedivieweR")
```

Or simply load it in development mode:

```r
# Set working directory to the package root
setwd("path/to/pedivieweR")

# Load the package
devtools::load_all()
```

## Quick Start

Launch the application with a single function call:

```r
library(pedivieweR)
run_pedivieweR()
```

## Usage

### Basic Usage

```r
# Launch with default settings (opens browser automatically)
run_pedivieweR()

# Launch on a specific port
run_pedivieweR(port = 3838)

# Launch without opening browser automatically
run_pedivieweR(launch.browser = FALSE)

# Launch on all network interfaces
run_pedivieweR(host = "0.0.0.0", port = 3838)
```

### Advanced Usage

You can also get the app object and run it manually:

```r
library(pedivieweR)
app <- pedivieweR_app()
shiny::runApp(app, port = 3838)
```

## Package Structure

- `R/` - R source code
  - `run_pedivieweR.R` - Main launch function
  - `pedivieweR_app.R` - App creation function
  - `utils.R` - Internal utility functions
- `src/` - C++ source code (Rcpp)
  - `pedigree_qc.cpp` - Fast pedigree QC functions
- `inst/app/` - Application source
  - `app.R` - Main Shiny application code

## Features

- Interactive pedigree visualization using visNetwork
- Fast pedigree quality control (QC) with optional Rcpp acceleration
- Support for large pedigree datasets with hierarchical clustering
- Multiple visualization levels (individual, family, super-family, mega-family)
- Inbreeding coefficient calculation
- Pedigree data import/export
- Interactive network navigation and search

## Requirements

### Required Packages
- shiny
- bslib
- shinyjs
- dplyr
- DT
- pedigreeTools
- visNetwork
- igraph
- digest

### Optional Packages
- Rcpp (for accelerated QC functions)

## Notes

- The original `app.R` file in the root directory is preserved for backward compatibility
- When installed as a package, the app code is loaded from `inst/app/app.R`
- Rcpp functions are automatically loaded if available, otherwise optimized R functions are used
