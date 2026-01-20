teach <- data.frame(read.csv("teaching.csv", stringsAsFactors = FALSE))
names(teach)[4:12] <- teach[1, 4:12]
teach <- teach[!teach$Onderwijsonderdeel == "", ]
teach[, 4:11] <- teach[, 4:11] == "X"
teach$Years <- ""
years <- gregexpr("\\d{4}", teach$Onderwijsonderdeel)
these_years <- sapply(years, function(x){length(x) == 1 & !x[1] == -1})
teach$Years[these_years] <- gsub("^.+(\\d{4}).+$", "\\1", teach$Onderwijsonderdeel[these_years])

these_years <- sapply(years, function(x){length(x) > 1 & !x[1] == -1})
teach$Years[these_years] <- gsub("^.+(\\d{4}.+\\d{4}).+$", "\\1", teach$Onderwijsonderdeel[these_years])

teach$Onderwijsonderdeel <- gsub("(\\(\\d{4}\\)|; \\d{4}|\\(\\d{4}.+\\d{4}\\))", "", teach$Onderwijsonderdeel)

write.csv(teach, "teaching_cleaned.csv", row.names = FALSE)