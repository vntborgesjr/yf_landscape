my_hist <- function(
    data,
    x,
    binwidth,
    xlab,
    ylab,
    fill = "#bdd005",
    xfrom,
    xto,
    xby,
    yfrom,
    yto,
    yby,
    text_size = 18,
    axis_size = 14,
    face = NULL
) {
  
  #
  data |> 
    ggplot2::ggplot() +
    ggplot2::aes(x = {{ x }}) +
    ggplot2::geom_histogram(
      fill = fill,
      color = "black",
      binwidth = binwidth,
      center = binwidth/2
    ) +
    ggplot2::labs(
      x = xlab,
      y = ylab
    ) +
    ggplot2::scale_x_continuous(breaks = seq(xfrom, xto, xby)) +
    ggplot2::scale_y_continuous(breaks = seq(yfrom, yto, yby)) +
    ggplot2::theme_classic(
      base_size = text_size,
      base_family = "serif"
    ) +
    ggplot2::theme(
      text = ggplot2::element_text(
        color = "black", 
        face = face
      ),
      axis.text.x = ggplot2::element_text(
        size = axis_size
      ),
      axis.text.y = ggplot2::element_text(size = axis_size),
      # axis.ticks.x = ggplot2::element_blank(),
      strip.background = ggplot2::element_rect(
        color = "white"
      ), 
      strip.text = ggplot2::element_text(
        color = "black"
      )
    )
  
}