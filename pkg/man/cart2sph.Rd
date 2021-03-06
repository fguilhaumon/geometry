% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cart2sph.R
\name{cart2sph}
\alias{cart2sph}
\title{If called with a single matrix argument then each row of \code{c} 
represents the Cartesian coordinate (\code{x}, \code{y}, \code{z}).}
\usage{
cart2sph(x, y = NULL, z = NULL)
}
\arguments{
\item{x}{x-coordinates or matrix with three columns}

\item{y}{y-coordinates (optional, if \code{x}) is a matrix}

\item{z}{z-coordinates (optional, if \code{x}) is a matrix}
}
\value{
Matrix with columns:
\item{\code{theta}}{the angle relative to the positive x-axis}
\item{\code{phi}}{the angle relative to the xy-plane}
\item{\code{r}}{the distance to the origin \code{(0, 0, 0)}}
}
\description{
Transform Cartesian to spherical coordinates
}
\seealso{
sph2cart, cart2pol, pol2cart
}
\author{
Kai Habel <kai.habel@gmx.de>

David Sterratt <david.c.sterratt@ed.ac.uk>
}
