
<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/rstudio/bootstraplib.svg?branch=master)](https://travis-ci.org/rstudio/bootstraplib)
<!-- badges: end -->

# bootstraplib

The **bootstraplib** R package provides a foundation for other packages
(e.g., **shiny**, **rmarkdown**, etc) or other projects to:

  - Use [Bootstrap](https://sass-lang.com/) 4, as well as any major
    version of Bootstrap built on [Sass](https://sass-lang.com/).
    
      - Packages like **shiny**, **rmarkdown**, and many of their
        downstream dependencies have long depended on static Bootstrap 3
        CSS, and may continue to do so by default. This package provides
        a means for upgrading to Bootstrap 4 (as well as compiling
        [Bootstrap 3 SASS](https://github.com/twbs/bootstrap-sass), and
        potentially, [future major
        versions](https://github.com/twbs/release) of Bootstrap).

  - Easily use pre-packaged [Bootswatch](https://bootswatch.com/)
    themes.

  - Create [custom Bootstrap
    themes](https://getbootstrap.com/docs/4.0/getting-started/theming)
    through compilation of user supplied [Sass](https://Sass-lang.com)
    code from R.

To learn more, see the article on using **bootstraplib** with
[**shiny**](articles/shiny.html) and
[**rmarkdown**](articles/rmarkdown.html), as well as creating [custom
Bootstrap themes](articles/custom.html).

## Installation

**bootstraplib** isn’t yet available from CRAN, but you can install
with:

``` r
remotes::install_github("rstudio/bootstraplib")
library(bootstraplib)
```
