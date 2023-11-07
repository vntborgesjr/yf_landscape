my_hist <- function(
    data,
    x,
    binwidth,
    xlab,
    ylab
) {
  
  #
  data |> 
    ggplot2::ggplot() +
    ggplot2::aes(x = {{ x }}) +
    ggplot2::geom_histogram(
      fill = "#bdd005",
      color = "black",
      binwidth = binwidth,
      center = binwidth/2
    ) +
    ggplot2::labs(
      x = xlab,
      y = ylab
    ) +
    ggplot2::theme_classic(
      base_size = 14,
      base_family = "serif"
    ) +
    ggplot2::theme(
      text = ggplot2::element_text(
        color = "black", 
        face = "bold"
      ),
      axis.text.x = ggplot2::element_text(
        size = 12
      ),
      axis.text.y = ggplot2::element_text(size = 12),
      # axis.ticks.x = ggplot2::element_blank(),
      strip.background = ggplot2::element_rect(
        color = "white"
      ), 
      strip.text = ggplot2::element_text(
        color = "black"
      )
    )
  
}