% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{marathon_berlin}
\alias{marathon_berlin}
\title{The 50% sample of male/female runners for all years of the Berlin marathon that recorded gender.}
\format{
A data frame with columns:
\describe{
 \item{age}{The variable is numeric. The age of the runner}
 \item{gender}{The variable is character. The gender of the runner (M/F)}
 \item{chiptime}{The variable is numeric. The time in minutes for the runner}
 \item{year}{The variable is numeric. The year of the marathon}
 \item{marathon}{The variable is character. The name of the marathon}
 \item{country}{The variable is character. The country where the marathon was held}
 \item{finishers}{The variable is numeric. The number of finishers at the marathon}
}
}
\source{
\url{http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm}
}
\usage{
marathon_berlin
}
\description{
This data set has ~200k observations.  Marathon website - https://www.bmw-berlin-marathon.com/en/
}
\examples{
\dontrun{
marathon_berlin
}
}
\keyword{datasets}
