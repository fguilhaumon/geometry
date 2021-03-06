##' Compute halfspace intersection about a point
##' 
##' @param p An \code{n}-by-\code{dim+1} matrix. Each row of \code{p}
##'   represents a halfspace by a \code{dim}-dimensional normal to a
##'   hyperplane and the offset of the hyperplane.
##' @param fp A \dQuote{feasible} point that is within the space
##'   contained within all the halfspaces.
##' @param options String containing extra options, separated by
##'   spaces, for the underlying Qhull command; see details below and
##'   Qhull documentation at
##'   \url{http://www.qhull.org/html/qhalf.htm}.
##' 
##' @return A \code{dim}-column matrix containing the intersection
##'   points of the hyperplanes \url{../doc/html/qhalf.html}. These
##'   points 
##' 
##' @author David Sterratt \email{david.c.sterratt@ed.ac.uk}
##' @seealso \code{\link{convhulln}}
##' @references \cite{Barber, C.B., Dobkin, D.P., and Huhdanpaa, H.T.,
##'   \dQuote{The Quickhull algorithm for convex hulls,} \emph{ACM
##'   Trans. on Mathematical Software,} Dec 1996.}
##' 
##' \url{http://www.qhull.org}
##' @examples
##' p <- rbox(0, C=0.5)  # Generate points on a unit cube centered around the origin
##' ch <- convhulln(p, "n") # Generate convex hull, including normals to facets, with "n" option
##' # Intersections of half planes
##' # These points should be the same as the orginal points
##' pn <- halfspacen(ch$normals, c(0, 0, 0)) 
##' 
##' @export
##' @useDynLib geometry
halfspacen <- function (p, fp, options = "Tv") {
  ## Check directory writable
  tmpdir <- tempdir()
  ## R should guarantee the tmpdir is writable, but check in any case
  if (file.access(tmpdir, 2) == -1) {
    stop(paste("Unable to write to R temporary directory", tmpdir, "\n",
               "This is a known issue in the geometry package\n",
               "See https://r-forge.r-project.org/tracker/index.php?func=detail&aid=5738&group_id=1149&atid=4552"))
  }
  
  ## Input sanitisation
  options <- paste(options, collapse=" ")
  
  ## Coerce the input to be matrix
  if (is.data.frame(p)) {
    p <- as.matrix(p)
  }

  ## Make sure we have real-valued input
  storage.mode(p) <- "double"

  ## We need to check for NAs in the input, as these will crash the C
  ## code.
  if (any(is.na(p))) {
    stop("The first argument should not contain any NAs")
  }

  ## Check dimensions
  if (ncol(p) - 1 != length(as.vector(fp))) {
    stop(paste("Dimension of hyperspace is", ncol(p) - 1, "but dimension of fixed point is", length(as.vector(fp))))
  }
  
  ## Put in fixed point
  options <- paste(options, paste0("H",paste(fp, collapse=",")))

  
  .Call("C_halfspacen", p, as.character(options), tmpdir, PACKAGE="geometry")
}
