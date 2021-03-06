#### Setup ---------------------------------------------------------------------

## load libraries
library(ggplot2)

p <- ggplot(msleep, aes(bodywt, brainwt)) + geom_point(na.rm = TRUE)

#### Tests ---------------------------------------------------------------------

# test that the function with default arguments works
g <- p + annotation_ticks()

expect_silent(ggplotGrob(g))

# test that the function recognises the sides argument
g <- p + annotation_ticks(sides = "trbl")

expect_silent(ggplotGrob(g))
expect_equal(length(layer_grob(g, 2L)[[1]]$children), 4)

expect_error(p + annotation_ticks(sides = "banana"))

# test that the type argument works
g1 <- p + annotation_ticks(type = "both")
g2 <- p + annotation_ticks(type = "major")
g3 <- p + annotation_ticks(type = "minor")

expect_silent(ggplotGrob(g1))
expect_silent(ggplotGrob(g2))
expect_silent(ggplotGrob(g3))

expect_equal(length(layer_grob(g1, 2L)[[1]]$children[[1]]$x0), 8)
expect_equal(length(layer_grob(g2, 2L)[[1]]$children[[1]]$x0), 5)
expect_equal(length(layer_grob(g3, 2L)[[1]]$children[[1]]$x0), 3)

expect_error(p + annotation_ticks(type = "banana"))

# test that ticks can go outside
g <- p + annotation_ticks(outside = TRUE) +
  coord_cartesian(clip = "off")

expect_silent(ggplotGrob(g))

ticks <- layer_grob(g, 2L)[[1]]$children[[1]]$y1
lapply(
  ticks,
  function(x) expect_true(as.numeric(x) < 0)
)

# test that tick lengths can be set
g <- p + annotation_ticks(
  type = "both",
  tick.length = unit(20, "pt"),
  minor.length = unit(10, "pt")
)

expect_silent(ggplotGrob(g))
expect_identical(g$layers[[2]]$geom_params$tick.length, unit(20, "pt"))
expect_identical(g$layers[[2]]$geom_params$minor.length, unit(10, "pt"))

#### Sanity checks -------------------------------------------------------------
# test that warning occurs if both colour and color are set
expect_warning(p + annotation_ticks(colour = "red", color = "blue"))
