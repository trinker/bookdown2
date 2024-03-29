#' @export
html_chapter <- function(raw = FALSE, toc = NULL, bib = "references.bib") {
  library(bookdown2)

  base <- rmarkdown::html_document(
    self_contained = FALSE,
    lib_dir = "www",
    template = if (raw) system.file("raw-html.html", package = "bookdown2") else system.file("chapter-html.html", package = "bookdown2"),,
    mathjax =  "default",
    pandoc_args = c("--chapters",
                    "--bibliography", bib,
                    #"--csl", csl,
                    "")
  )
  # Remove --section-divs option
  base$pandoc$args <- setdiff(base$pandoc$args, "--section-divs")
  base$pandoc$from <- markdown_style

  if (!is.null(toc)) {
    base$pre_processor <- function(yaml_front_matter, utf8_input, runtime,
                                  knit_meta, files_dir, output_dir) {
      update_links(utf8_input, toc)
    }
  }

  base$knitr <- knitr_opts("html")
  base
}

#' @export
pdf_chapter <- function(toc = FALSE, book = FALSE) {
  library(bookdown2)

  base <- rmarkdown::pdf_document(
    template = system.file("book-template.tex", package = "bookdown"),
    latex_engine = "xelatex",
    pandoc_args = c("--chapters")
  )
  base$pandoc$from <- markdown_style
  base$knitr <- knitr_opts("tex")
  base
}

#' @export
tex_chapter <- function(toc = FALSE, book = FALSE, bib) {
  library(bookdown2)
  options(digits = 3)
  set.seed(1014)

  base <- rmarkdown::pdf_document(
    template = NULL,
    latex_engine = "xelatex",
    pandoc_args = c("--chapters",
                    "--bibliography", bib,
                    #"--csl", csl,
                    "")
  )
  base$pandoc$from <- markdown_style
  base$pandoc$ext <- ".tex"
  base$knitr <- knitr_opts("tex")

  base
}

markdown_style <- "markdown+autolink_bare_uris-auto_identifiers+tex_math_single_backslash-implicit_figures"

knitr_opts <- function(type = c("html", "tex")) {
  type <- match.arg(type)

  pkg <- list()
  chunk <- list(
    comment = "#>",
    collapse = TRUE,
    error = FALSE,
    cache.path = "_cache/",
    fig.path = "figures/",
    fig.width = 4,
    fig.height = 4,
    dev.args = list(pointsize = 10)
  )


  if (type == "html") {
    chunk$dev <- "png"
    chunk$dpi <- 96
    chunk$fig.retina <- 2
  } else {
    pkg$width <- 65 - 3

    chunk$dev <- "pdf"
  }

  hooks <- list(
    small_mar = function(before, options, envir) {
      if (before) par(mar = c(4.1, 4.1, 0.5, 0.5))
    }
  )

  rmarkdown::knitr_options(pkg, chunk, hooks)
}
