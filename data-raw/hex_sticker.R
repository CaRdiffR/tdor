# install.packages("hexSticker")
library(hexSticker)
library(tidyverse)
library(showtext)

## Loading Google fonts (http://www.google.com/fonts)
font_add_google("oswald")

# create the hex
sticker("inst/figures/trans_flag.jpg", package="TDOR", p_size=16,
        s_x=1, s_y=1,
        s_width=1, s_height=1, p_family = "oswald",p_y = 1,
        filename="inst/figures/tdor_hex.png",
        white_around_sticker=T, url="https://tdor.translivesmatter.info/",u_color = "white")
