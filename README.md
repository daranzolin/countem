# countem

<!-- badges: start -->
![](https://camo.githubusercontent.com/ea6e0ff99602c3563e3dd684abf60b30edceaeef/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c6966656379636c652d6578706572696d656e74616c2d6f72616e67652e737667)
![CRAN log](http://www.r-pkg.org/badges/version/countem)
<!-- badges: end -->

Sit back, relax, and enjoy the bar charts.

## Installation

You can install the released version of countem from GitHub:

``` r
remotes::install_github("daranzolin/countem")
```

## Count 'em!

countem cycles through categorical variables in a data frame and creates bar charts for each one. The diamonds dataset, for example, includes three categorical variables: clarity, color, and cut.

``` r
library(countem)
countem(ggplot2::diamonds)
```
![](inst/countemgif1.gif)

Adjust transition speed, fill colors, and more. 
