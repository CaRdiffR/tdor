#' Launch Shiny Dashboard
#' 
#' \code{runDashboard} launches the Shiny Dashboard displaying the data contained in this package
#' @export
runDashboard <- function() {
  appDir <- system.file("shiny-examples", "dashboard_example", package = "tdor")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `tdor`.", call. = FALSE)
  }
  #https://deanattali.com/2015/04/21/r-package-shiny-app/
  shiny::runApp(appDir, display.mode = "normal")
}