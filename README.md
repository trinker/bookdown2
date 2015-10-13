# Bookdown2

This package is substantially based on Hadley Wickham's [bookdown](https://github.com/hadley/bookdown), with minor additions. The main changes are basic support for scholarly citations and reference lists (using pandoc), and for table and figure captions and cross-references (using the captioner package).

Like bookdown, bookdown2 package is useful for writing Rmarkdown files and converting them into a book. You can render a set of HTML pages with a linked table of contents, or produce a PDF. The key difference is that bookdown2 allows you to have citations and captions. 

To see a small example of how it works, browse to the `tests/testthat` directory and inspect the files. Runnings the tests generates a small PDF book. 

Here are the dependencies external to R:

- [Pandoc](http://johnmacfarlane.net/pandoc/) & pandoc-citeproc
- LaTeX (specifically Xelatex)
- Inconsolata font
- nodejs

