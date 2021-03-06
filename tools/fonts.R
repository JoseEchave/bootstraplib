library(stringr)

if (Sys.getenv("RSTUDIO") == "1") {
  stop("Please run this script from the command line: `Rscript tools/fonts.R`")
}

download_and_copy_fonts <-  function(theme) {
  theme_scss <- readLines(file.path(theme, "_bootswatch.scss"))
  web_font_url <- grep("^\\$web-font-path: .*", theme_scss, value = TRUE)
  if (length(web_font_url)) {
    families <- sub("family=", "", str_extract(web_font_url, 'family=[^".]*'))
    # some themes (sketchy) require multiple families
    families <- unlist(strsplit(families, "|", fixed = TRUE))
    families <- gsub("+", " ", families, fixed = TRUE)
    families <- strsplit(families, ":")
    families <- unlist(lapply(families, function(x) {
      if (length(x) == 1) return(x)
      paste0(x[[1]], ":", strsplit(x[[2]], ",")[[1]])
    }))
    # Assumes this repo is in the same directory, the shell script is executable,
    # and the script's system dependencies are met
    # https://github.com/neverpanic/google-font-download
    # TODO: consider using this instead https://www.npmjs.com/package/grunt-google-fonts
    cmd <- sprintf(
      "../google-font-download/google-font-download -f ttf '%s'",
      paste(families, collapse = "' '")
    )
    system(cmd)

    # The css file generated by this tool assumes the font file resides in the
    # same directory as the HTML file that this will eventually reside in,
    # but it will make more sense to mount fonts in a fonts/ directory
    font_css <- readLines("font.css")
    font_css <- str_replace(font_css, "url\\('(.*\\.ttf)'\\)", "url('fonts/\\1')")
    writeLines(font_css, "font.css")

    file.rename("font.css", file.path(theme, "font.css"))
    ttf_files <- Sys.glob("*.ttf")
    dir.create(file.path("inst", "fonts"), showWarnings = FALSE)
    file.rename(ttf_files, file.path("inst", "fonts", ttf_files))
  }
}

themes <- list.dirs(
  "inst/node_modules/bootswatch/dist",
  recursive = FALSE,
  full.names = TRUE
)
themes3 <- list.dirs(
  "inst/node_modules/bootswatch3",
  recursive = FALSE,
  full.names = TRUE
)

lapply(themes, download_and_copy_fonts)
lapply(themes3, download_and_copy_fonts)
