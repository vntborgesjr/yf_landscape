#' Documentação da função box_dot_histplot1()
#' 
#' @description
#' A short description...
#' 
#' @usage box_dot_histplot1(arg1, arg2 = default, ...)
#'
#' @param data 
#' @param var 
#' @param xy_labs 
#' @param ylim 
#' @param bin_width 
#' @param font_size 
#' @param font_family 
#' @param legend_label 
#' @param legend_size 
#' @param legend_face 
#'
#' @return
#' @export
#'
#' @examples
box_dot_histplot1 <- function(
    data,
    var,
    title = NULL,
    x_lab,
    y_lab,
    ylim = c(-0.2, 0.2),
    bin_width,
    font_size = 12,
    font_family = "serif",
    legend_label = c("a", "b", "c"),
    legend_size = 12,
    legend_face = "bold",
    min_x = 0,
    max_x = length(data$var),
    angle = 0
) {
  
  #
  dotplot <- ggplot2::ggplot(
    data = data, 
    mapping = ggplot2::aes(
      x = sort({{ var }}),
      y = 1:length({{ var }})
    )
  ) +
    ggplot2::geom_point(
      color = "#bdd005"
    ) + 
    ggplot2::scale_x_continuous(
      breaks = seq(
        min_x, 
        max_x,
        bin_width
      )
    ) +
    ggplot2::labs(
      title = title,
      x = "    ",
      y = NULL
    ) +
    ggplot2::theme_classic(
      base_size = font_size,
      base_family = font_family
    ) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(size = 10), 
      axis.text.y = ggplot2::element_text(colour = "white"),
      axis.ticks.y = ggplot2::element_line(colour = "white"),
      axis.line.y = ggplot2::element_line(colour = "white")
    )
  
  boxplot <- ggplot2::ggplot(
    data = data, 
    mapping = ggplot2::aes(x = {{ var }})
  ) +
    ggplot2::geom_boxplot(
      width = 0.1, 
      fill = "#bdd005",
      na.rm = TRUE
    ) + 
    ggplot2::labs(
      x = "    ",
      y = NULL
    ) +
    ggplot2::ylim(ylim) +
    ggplot2::scale_x_continuous(
      breaks = seq(
        min_x, 
        max_x,
        bin_width
      )
    ) +
    ggplot2::theme_classic(
      base_size = font_size,
      base_family = font_family
    ) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(size = 10), 
      axis.text.y = ggplot2::element_text(colour = "white"), 
      axis.ticks.y = ggplot2::element_line(colour = "white"),
      axis.line.y = ggplot2::element_line(colour = "white")
    )
  
  hist <- data |>
    ggplot2::ggplot() +
    ggplot2::aes(x = {{ var }}) +
    ggplot2::geom_histogram(
      binwidth = bin_width,
      fill = "#bdd005",
      color = "black",
      center = bin_width/2
    ) +
    ggplot2::labs(
      x = x_lab,
      y = y_lab
    ) +
    ggplot2::scale_x_continuous(
      breaks = seq(
        min_x, 
        max_x,
        bin_width
      )
    ) +
    ggplot2::theme_classic(
      base_size = font_size,
      base_family = font_family
    ) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        size = 10,
        angle = angle
      ),
      axis.text.y = ggplot2::element_text(size = 10)
      # axis.ticks.x = ggplot2::element_blank()
    )
  
  ggpubr::ggarrange(
    dotplot,
    boxplot,
    hist,
    nrow = 3,
    labels = legend_label, 
    font.label = list(
      size = legend_size,
      family = font_family,
      face = legend_face
    )
  )
  
}

# globalVariables(
#   c(
#     
#   )
# )