xy_continuous_relation <- function(
    data,
    x,
    y,
    xlab,
    ylab,
    color = "black",
    fill = "white",
    tag = "a",
    text_size = 12,
    axis_size = 10,
    face = NULL
) {
  # 
  xy_relation <- data |> 
    ggplot2::ggplot() +
    ggplot2::aes(
      x = {{ x }},
      y = {{ y }}
    ) +
    ggplot2::geom_point(
      color = color,
      fill = fill
    )  +
    ggplot2::theme_classic(
      base_size = text_size,
      base_family = "serif"
    ) +
    ggplot2::labs(
      x = xlab,
      y = ylab, 
      tag = tag
    ) +
    ggplot2::theme(
      text = ggplot2::element_text(
        color = "black", 
        face = face
      ),
      axis.text.x = ggplot2::element_text(
        face = "plain",
        size = axis_size
      ), 
      axis.text.y = ggplot2::element_text(
        face = "plain",
        size = axis_size
      )
    )
  
  return(xy_relation)
}

