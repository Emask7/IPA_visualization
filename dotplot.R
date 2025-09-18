
PL23 <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - PL2-3.xls",
                   skip = 1)
PL23 <- data.frame(PL23$Symbol, c(rep("PL2-3 2DG vs PL2-3", nrow(PL23))), -1*log10(PL23$`Expr p-value`), PL23$`Expr Log Ratio`)
colnames(PL23) <- c("ID", "comparison", "p.value", "LFC")
PL23 <- filter(PL23, p.value > 1.3 & abs(LFC) > 1)
head(PL23)
ID_list <- PL23$ID
head(ID_list)

R848 <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - R848.xls",
                   skip = 1)
R848 <- data.frame(R848$Symbol, c(rep("R848 2DG vs R848", nrow(R848))), -1*log10(R848$`Expr p-value`), R848$`Expr Log Ratio`)
colnames(R848) <- c("ID", "comparison", "p.value", "LFC")
R848 <- filter(R848, ID %in% ID_list)
head(R848)

NP <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - NP.xls",
                   skip = 1)
NP <- data.frame(NP$Symbol, c(rep("NP 2DG vs NP", nrow(NP))), -1*log10(NP$`Expr p-value`), NP$`Expr Log Ratio`)
colnames(NP) <- c("ID", "comparison", "p.value", "LFC")
NP <- filter(NP, ID %in% ID_list)
head(NP)

MRLlpr <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - AM14 MRLlpr.xls",
                   skip = 1)
MRLlpr <- data.frame(MRLlpr$Symbol, c(rep("AM14 MRLlpr 2DG vs Control", nrow(MRLlpr))), -1*log10(MRLlpr$`Expr p-value`), MRLlpr$`Expr Log Ratio`)
colnames(MRLlpr) <- c("ID", "comparison", "p.value", "LFC")
MRLlpr <- filter(MRLlpr, ID %in% ID_list)
head(MRLlpr)


merge_df <- full_join(PL23, R848)
merge_df <- full_join(merge_df, NP)
merge_df <- full_join(merge_df, MRLlpr)
# colnames(merge_df) <- c("ID", "comparison", "-log(p-value)", "LFC")
head(merge_df)



dot_plot <- ggplot(data = merge_df, 
                   aes(x = factor(ID), y = factor(comparison))) + 
  geom_point(aes(size = p.value, color = LFC)) + 
  theme_bw() +
  theme( panel.grid.major=element_blank(),
         panel.grid.minor=element_blank(),
         # axis.text = element_text(size = 12, color = "black"),
         axis.title = element_text(size = 12),
         legend.text = element_text(size = 12)) +
  scale_colour_gradient2(low = "green", high = "red") +
  ylab("") + 
  xlab("") + 
  coord_flip() + 
  scale_y_discrete(position = "right") +
  labs(title = "title") 

dot_plot
