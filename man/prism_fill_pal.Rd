% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prism_fill_pal.R
\name{prism_fill_pal}
\alias{prism_fill_pal}
\title{Prism fill palettes}
\usage{
prism_fill_pal(palette = "colors")
}
\arguments{
\item{palette}{\code{string}. Palette name, see
\code{lengths(ggprism_data$fill_palettes)}
for valid palette names.}
}
\description{
A collection of fill palettes which mirror the
colour schemes available in GraphPad Prism.
}
\examples{
library(ggplot2)

## list all available fill palettes and their lengths
lengths(ggprism_data$fill_palettes)

## select some colours from a palette
prism_fill_pal(palette = "summer")(4)

## see all the colours in a specific palette
# define a function for convenience
library(scales)

show_palette <- function(palette) {
  scales::show_col(
    prism_fill_pal(palette = palette)(
      attr(prism_fill_pal(palette = palette), "max_n")
    )
  )
}

# show the colours in the palette "pearl"
show_palette("floral")
}
