# library(pdftools)
# 
# txt <- pdftools::pdf_text("C:/tmp/CasparvanLissa_Web_of_Science_Researcher_CV_20250212 (1).pdf")

# copy-paste rows with reviews
txt <- readClipboard()
tmp <- strsplit(txt, "(", fixed = TRUE)[[1]]
tmp <- tmp[!tmp == ""]

tmp <- do.call(rbind, strsplit(tmp, ")", fixed = TRUE))
tmp <- data.frame(tmp)
tmp$X1 <- as.integer(tmp$X1)
tmp$X2 <- trimws(tmp$X2)
tmp$X2 <- gsub("\\\\n", "", tmp$X2)
names(tmp) <- c("N", "Name")
tmp$Category <- "Journal"
tmp <- tmp[, c("Name", "N", "Category")]
# tmp2 <- read.csv("publons.csv", stringsAsFactors = F)
all(tmp$Name %in% tmp2$Name)
tmp2$Name[!tmp2$Name %in% tmp$Name]
write.csv(tmp, "publons.csv", row.names = FALSE)