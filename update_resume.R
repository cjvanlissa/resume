library(rmarkdown)
rmarkdown::render("resume.Rmd", output_format = "all")
file.copy("resume.html", file.path("docs", "index.html"), overwrite = TRUE)
