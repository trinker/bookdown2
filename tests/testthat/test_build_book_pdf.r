context("Building the PDF of the book")

source("book/build-book.r")

test_that("can we can build the PDF?", {

  expect_true(file.exists("book/test_book.pdf"))
})

test_that("do we have plots for the PDF?", {

  expect_true(grep("old_faithful", dir("book/tex/figures/")) == 1)
})

test_that("do we have well-formatted citations in the intermediate tex files?", {

  expect_true(grep("\\{Advanced R\\}. CRC Press.", readLines("book/tex/test_chapter_one.tex")) != 0)
})

test_that("do we have captions and cross-references in the intermediate tex files?", {

  expect_true(readLines("book/tex/test_chapter_two.tex")[13] == "Figure 2.1: Eruptions of Old Faithful")
  expect_true(grep("Figure 2.1", readLines("book/tex/test_chapter_two.tex")[15] ) == 1)
})


# clean up
unlink(c("figures", "book/tex"), recursive = TRUE)




