xy_categoric_relation <- function(
    data,
    x,
    y,
    fill,
    xlab,
    ylab,
    angle = NULL,
    hjust = NULL,
    vjust = NULL
) {
  # 
  xy_relation <- data |> 
    ggplot2::ggplot() +
    ggplot2::aes(
      x = {{ x }},
      y = {{ y }},
      fill = {{ fill }}
    ) +
    ggplot2::geom_col(
      position = "dodge",
      width = 0.5
    )  +
    ggplot2::facet_wrap(
      ggplot2::vars(buffer),
      scales = "free_y"
    ) +
    ggplot2::scale_discrete_manual(
      "Status",
      aesthetics = "fill",
      values = c("blue", "red")
    ) + 
    ggplot2::theme_classic(
      base_size = 14,
      base_family = "serif"
    ) +
    ggplot2::labs(
      x = xlab,
      y = ylab
    ) +
    ggplot2::theme(
      text = ggplot2::element_text(
        color = "black", 
        face = "bold"
      ),
      axis.text.x = ggplot2::element_text(
        angle = angle,
        face = "plain",
        size = 12,
        hjust = hjust,
        vjust = vjust
      ), 
      axis.text.y = ggplot2::element_text(
        face = "plain",
        size = 12
      ),
      legend.text = ggplot2::element_text(
        size = 12,
        face = "plain"
      ),
      strip.background = ggplot2::element_rect(
        color = "white"
      ), 
      strip.text = ggplot2::element_text(
        color = "black"
      )
    )
  
  return(xy_relation)
}

