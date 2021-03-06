if (Sys.which("yarn") == "") {
  stop("The yarn CLI must be installed and in your PATH")
}

withr::with_dir("inst", system("yarn install"))

# I don't think we'll need these special builds of popper (at least for now)
unlink("inst/node_modules/popper.js/dist/umd", recursive = TRUE)
unlink("inst/node_modules/popper.js/dist/esm", recursive = TRUE)

# Avoiding bootstrap's distributed CSS saves us another 1.5 Mb
unlink("inst/node_modules/bootstrap/dist/css", recursive = TRUE)

# For now we're just using the main JS bundle
unlink("inst/node_modules/bootstrap/js", recursive = TRUE)
file.remove(file.path(
  "inst/node_modules/bootstrap/dist/js",
  c("bootstrap.js", "bootstrap.js.map", "bootstrap.min.js", "bootstrap.min.js.map")
))

# Each Bootswatch theme bundles Bootstrap
file.remove(c(
  Sys.glob("inst/node_modules/bootswatch/dist/*/bootstrap.css"),
  Sys.glob("inst/node_modules/bootswatch/dist/*/bootstrap.min.css")
))

# To fully support Bootstrap+Bootswatch 3 and 4, we need to bundle
# multiple versions of Bootswatch...this downloads Bootswatch 3
tmp_dir <- tempdir()
withr::with_dir(tmp_dir, system("yarn add bootswatch@3.4.1"))
source <- file.path(tmp_dir, "node_modules", "bootswatch")
target <- "inst/node_modules/bootswatch3"
if (!file.exists(target)) dir.create(target)
file.rename(source, target)

# Again, Bootswatch loves to bundle Bootstrap with each theme
file.remove(c(
  Sys.glob("inst/node_modules/bootswatch3/*/bootstrap.css"),
  Sys.glob("inst/node_modules/bootswatch3/*/bootstrap.min.css"),
  Sys.glob("inst/node_modules/bootswatch3/*/thumbnail.png"),
  # I don't think we'll need less files
  Sys.glob("inst/node_modules/bootswatch3/*/*.less")
))

# :eye_roll:
unlink("inst/node_modules/bootswatch3/docs", recursive = TRUE)
unlink("inst/node_modules/bootswatch3/.github", recursive = TRUE)
# we already got fonts via tools/download_fonts.R
unlink("inst/node_modules/bootswatch3/fonts", recursive = TRUE)


# TODO: Avoid the stupiest CRAN note ever
# https://www.r-bloggers.com/the-most-annoying-warning-for-cran-submission/
