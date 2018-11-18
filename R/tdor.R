#' Transgender Day of Remembrance Data
#'
#' This data set contains information on killings and suicides of transgender
#' people corresponding to TDoR 2007-2018 (2016-10-01 to 2018-09-30).
#'
#' @format A data frame with 2705 records and 21 variables:
#' \describe{
#'     \item{Name}{Name (character).}
#'     \item{Age}{Age (character), typically age in years, but may also be
#'     a range (if reports are inconsistent), or an approximation (e.g.
#'     "Approx. 30" or "Under 35").}
#'     \item{Age_min}{Minium age (numeric) if this can be defined from Age.}
#'     \item{Age_max}{Maxium age (numeric) if this can be defined from Age.}
#'     \item{Photo}{Name of photo file in data source (not in package yet).}
#'     \item{Photo source}{URL where photo obtained from.}
#'     \item{Date}{Date of death.}
#'     \item{Source ref}{Original news source.}
#'     \item{Location}{Location of death.}
#'     \item{Country}{Country where death occurred.}
#'     \item{Latitude}{Latitude of location.}
#'     \item{Longitude}{Longitude of location.}
#'     \item{Cause of death}{Category of cause of death.}
#'     \item{Description}{Short description of what happened plus
#'     links of further news sources.}
#'     \item{Permalink}{Link to individual page on tdor.translivesmatter.info}
#'     \item{TGEU ref}{TGEU ref}
#'     \item{Source}{??}
#'     \item{Date_1}{Should not be here!}
#'     \item{Month}{Month of death.}
#'     \item{Year}{Year of death.}
#'     \item{TDoR}{TDoR period.}
#' }
#' @references
#' \url{https://bitbucket.org/annajayne/tdor_data}.
"tdor"
