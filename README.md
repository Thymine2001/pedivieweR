# pedivieweR

A Shiny application package for viewing and analyzing pedigree data with interactive network visualization.

License: GPL-3

## Installation

### Install from GitHub (Recommended)

Install the package directly from GitHub using `devtools` or `remotes`:

```r
# Install required dependencies first
install.packages(c("shiny", "bslib", "shinyjs", "dplyr", "DT", 
                   "pedigreeTools", "visNetwork", "igraph", "digest", "Rcpp"))

# Install devtools if not already installed
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

# Install pedivieweR from GitHub
devtools::install_github("Thymine2001/pedivieweR")
```

Or using `remotes`:

```r
# Install remotes if not already installed
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

# Install pedivieweR from GitHub
remotes::install_github("Thymine2001/pedivieweR")
```

### Development Installation

If you want to contribute or modify the code, you can clone the repository and install it locally:

```r
# Clone the repository first
# git clone git@github.com:Thymine2001/pedivieweR.git

# Then install from local source
setwd("path/to/pedivieweR")
devtools::install()

# Or load it in development mode
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
