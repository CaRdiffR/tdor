#' Transgender Day of Remembrance Data
#'
#' This data set contains information on killings and suicides of transgender
#' people, collected for the Transgender Day of Remembrance. It includes
#' records from 1970 to 2019.
#'
#' The Transgender Day of Remembrance (TDoR) is held annually on November 20.
#' On this day, people memorialise those who have been murdered or lost to
#' suicide as a result of transphobia in the previous year.
#'
#' The `TDoR` variable notes the particular TDoR that a record relates to. The
#' first TDoR was held in 1999, so `TDoR` is missing before 1998-11-19. Until
#' TDoR 2010, each TDoR memorialised deaths that had occurred since the last
#' TDoR. From 2009, the Trans Murder Monitoring project from
#' Transgender Europe (TGEU) began to release annual updates of relevant deaths.
#' During the years #' 2011 to 2013 the period these updates covered shifted
#' earlier in the year, to allow time for records to be checked and for
#' the reports to be made in time for the day of remembrance itself.
#' In these years the periods were
#' \describe{
#'     \item{2011}{November 20 2010 to November 14 2011.}
#'     \item{2012}{November 15 2011 to November 14 2012.}
#'     \item{2013}{November 20 2012 to November 1 2013.}
#' }
#' From 2014 onwards the period has been from October 1 to September 30. To
#' avoid ambiguity and allow newly discovered records to be added, the `TDoR`
#' variable closes the gap between 2012 and 2013, setting the end date to
#' November 19, and assign deaths from October 1 2013 to November 1 2013 to
#' TDoR 2014.
#'
#' @format A data frame with 3513 records and 19 variables:
#' \describe{
#'     \item{Name}{Name (character).}
#'     \item{Age}{Age (character), typically age in years, but may also be
#'     a range (if reports are inconsistent), or an approximation (e.g.
#'     "Approx. 30" or "Under 35").}
#'     \item{Age min}{Minium age (numeric) if this can be defined from Age.}
#'     \item{Age max}{Maxium age (numeric) if this can be defined from Age.}
#'     \item{Photo source}{URL where photo was obtained from for
#'     tdor.translivesmatter.info website.}
#'     \item{Date}{Date of death.}
#'     \item{Month}{Month of death.}
#'     \item{Year}{Year of death.}
#'     \item{TDoR}{TDoR period, see Details.}
#'     \item{Source ref}{Original news source.}
#'     \item{Location}{Location of death.}
#'     \item{State/Province}{The state or province. If `NA`, the state/province
#'     is part of `Location`.}
#'     \item{Country}{Country where death occurred.}
#'     \item{Country code}{ISO-3 country code (three letter code).}
#'     \item{Latitude}{Latitude of location.}
#'     \item{Longitude}{Longitude of location.}
#'     \item{Cause of death}{Category of cause of death.}
#'     \item{Description}{The (markdown) description of the report. The first
#'     line is designed for use on memorial cards.}
#'     \item{Tweet}{The text of a tweet summarising the report, with hashtags
#'     but without a permalink to tdor.translivesmatter.info.}
#'     \item{Permalink}{Link to individual page on tdor.translivesmatter.info.}
#' }
#' @references
#' \url{https://bitbucket.org/annajayne/tdor_data}.
"tdor"
