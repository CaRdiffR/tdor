#' @export
runDashboard <- function() {
  appDir <- system.file("shiny-examples", "dashboard_example", package = "tdor")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `tdor`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}