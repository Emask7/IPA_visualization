PL23 <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - PL2-3.xls",
                   skip = 1)
PL23 <- data.frame(PL23$Symbol, PL23$`Expr Log Ratio`)
colnames(PL23) <- c("ID", "PL23")
head(PL23)

R848 <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - R848.xls",
                   skip = 1)
R848 <- data.frame(R848$Symbol, R848$`Expr Log Ratio`)
colnames(R848) <- c("ID", "R848")

NP <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - NP.xls",
                 skip = 1)
NP <- data.frame(NP$Symbol, NP$`Expr Log Ratio`)
colnames(NP) <- c("ID", "NP")

MRLlpr <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - AM14 MRLlpr.xls",
                     skip = 1)
MRLlpr <- data.frame(MRLlpr$Symbol, MRLlpr$`Expr Log Ratio`)
colnames(MRLlpr) <- c("ID", "AM14MRLlpr")


merge_df <- full_join(PL23, MRLlpr, by = "ID")
merge_df <- full_join(merge_df, NP, by = "ID")
merge_df <- full_join(merge_df, R848, by = "ID")
rownames(merge_df) <- merge_df$ID
merge_df <- merge_df[, 2:5]
nrow(merge_df)

merge_df_filtered <- filter(merge_df, abs(PL23) > 0.6)
nrow(merge_df_filtered)

merge_df <- as.matrix(merge_df)
merge_df[is.na(merge_df)] <- 0
head(merge_df)



Heatmap(merge_df)

png(filename = "URA_heatmaps/IFNG.png",
    width = 1000, height = 2500, units = "px", pointsize = 8, res = 250,
    bg = "white", family = "", symbolfamily="default")

pheatmap(merge_df, 
         color = colorRamp2(c(5, 0, -10), c("red", "white", "green")),
         cluster_rows = TRUE, show_rownames = TRUE, 
         cluster_cols = FALSE, show_colnames = TRUE,
         heatmap_legend_param = list(title = "LFC"),
         main = "IFNG")

dev.off()


