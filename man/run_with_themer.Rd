% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/theme-preview.R
\name{run_with_themer}
\alias{run_with_themer}
\alias{bs_themer}
\title{Theme customization UI}
\usage{
run_with_themer(appDir = getwd(), ...)

bs_themer()
}
\arguments{
\item{appDir}{The application to run. This can be a file or directory path,
or a \code{\link[shiny:shinyApp]{shiny::shinyApp()}} object. See \code{\link[shiny:runApp]{shiny::runApp()}} for details.}

\item{...}{Additional parameters to pass through to \code{\link[shiny:runApp]{shiny::runApp()}}.}
}
\description{
bootstraplib includes a handy realtime theme customization UI that you can use to
easily make common tweaks to Bootstrap variables and immediately see how they
would affect your app's appearance. There are two ways you can launch the
theming UI. For most Shiny apps, just use \code{run_with_themer()} in place
of \code{\link[shiny:runApp]{shiny::runApp()}}; they should take the same arguments and work the same
way. Alternatively, you can call the \code{bs_themer()} function from inside your
server function (or in an R Markdown app that is using \code{runtime: shiny}, you
can call this from any code chunk).
}
\details{
To help you permanently apply the changes you see in the preview, this
utility prints \code{\link[=bs_theme_add_variables]{bs_theme_add_variables()}} code to the R console. Copy this
code and paste it into your Shiny app; see \code{\link[=bs_theme_add_variables]{bs_theme_add_variables()}} for
more details on where that code should go.
}
\section{Limitations}{


Currently, this utility only works with Bootstrap 4. We hope to add
Bootstrap 3 compatibility in the future.

It also only works with Shiny apps and R Markdown apps that use the Shiny
runtime. It's not possible to perform realtime preview for static R Markdown
documents.

Note that currently, only the CSS generated from \code{\link[=bootstrap]{bootstrap()}}
will be instantly reflected in theme preview. CSS that is generated from
third parties or \code{\link[=bootstrap_sass]{bootstrap_sass()}} may not be reflected in
realtime, even if setting the theme variables would have an effect if the app
is restarted. Since \code{bootstrap_sass()} is the mechanism by
which third-party HTML widgets are supposed to compile bootstraplib-aware CSS,
unfortunately it's not likely that the themer's realtime preview will work
with such components.
}

\examples{
library(shiny)

# Initialize Bootstrap 4, with Bootstrap 3 compatibility shim
bs_theme_new("4-3")

# Customize variables. These must always come between the
# call to bs_theme_new() and the UI definition!
bs_theme_add_variables(primary = "#008BA2")

ui <- fluidPage(
  bootstrap(),
  h1("Heading 1"),
  h2("Heading 2"),
  p(
    "Paragraph text;",
    tags$a(href = "https://www.rstudio.com", "a link")
  ),
  p(
    actionButton("cancel", "Cancel"),
    actionButton("continue", "Continue", class = "btn-primary")
  ),
  tabsetPanel(
    tabPanel("First tab",
      "The contents of the first tab"
    ),
    tabPanel("Second tab",
      "The contents of the second tab"
    )
  )
)

server <- function(input, output, session) {

}

if (interactive()) {
  run_with_themer(shinyApp(ui, server))
}

}
