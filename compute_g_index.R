# Copy-paste Google scholar profile to notepad, then copy again and run syntax
tmp <- readClipboard()

tmp <- data.frame(Title = tmp[seq.int(1, length(tmp), by = 3)],
                  Authors = tmp[seq.int(2, length(tmp), by = 3)],
                  Journal = tmp[seq.int(3, length(tmp), by = 3)],
                  stringsAsFactors = FALSE
                  )

add_cols <- strsplit(tmp$Journal, "\t")
add_cols <- t(sapply(add_cols, function(x){
  c(rep(NA, 3-(length(x))), x)
}))
tmp$Journal <- add_cols[,1]
tmp$Citations <- add_cols[,2]
tmp$Year <- add_cols[,3]
tmp$Citations[tmp$Citations == ""] <- 0
write.csv(tmp, "g_index.csv", row.names = FALSE)


# Calculate G -------------------------------------------------------------

tmp <- read.csv("g_index.csv", stringsAsFactors = FALSE)
tmp <- tmp[order(tmp$Citations, decreasing = TRUE), ]
tmp$G <- 1:nrow(tmp)
tmp$G2 <- tmp$G^2
tmp$cumulative_citations <- cumsum(tmp$Citations)
tmp$cumulative_citations > tmp$G2
cat("G-index is", which(diff(tmp$cumulative_citations > tmp$G2) == -1))