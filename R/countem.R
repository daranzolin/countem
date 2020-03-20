#' Cycle through bar charts of your data frame
#'
#' @param data A table of data
#' @param chart_interval How quickly to switch charts, in milliseconds
#' @param bar_interval How quickly the bars transition, in milliseconds
#' @param sort_bars Whether to sort the bars of the bar chart
#' @param include_ordinal Whether to include ordinal variables
#' @param fill Fill color of bars
#'
#' @import htmlwidgets
#'
#' @export
#' @examples
#' \dontrun{
#' countem(ggplot2::diamonds)
#' }
countem <- function(data,
                    chart_interval = 3500,
                    bar_interval = 2500,
                    sort_bars = TRUE,
                    include_ordinal = TRUE,
                    fill = "steelblue") {

  if (include_ordinal) data <- dplyr::mutate_if(data, is.ordered, as.character)

  to_count <- data %>%
    dplyr::select_if(is.character) %>%
    purrr::map_dfr(~as.data.frame(table(.x), stringsAsFactors = FALSE), .id = "var") %>%
    purrr::set_names(c("var", "x", "n"))

  vars <- unique(to_count[["var"]])

  x = list(
    data = to_count,
    vars = vars,
    chart_interval = chart_interval,
    bar_interval = bar_interval,
    sort_bars = sort_bars,
    fill = fill
  )

  htmlwidgets::createWidget(
    name = 'countem',
    x,
    package = 'countem'
  )
}

#' Shiny bindings for countem
#'
#' Output and render functions for using countem within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a countem
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name countem-shiny
#'
#' @export
countemOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'countem', width, height, package = 'countem')
}

#' @rdname countem-shiny
#' @export
renderCountem <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, countemOutput, env, quoted = TRUE)
}
