# PL23 <- read.delim("../cohorts_and_treatments_separated_pval0.05_lfc0.6/PL23_2DG_vs_PL23.txt", 
#                    sep = "\t", header = FALSE, blank.lines.skip = TRUE)

PL23 <- readLines("../cohorts_and_treatments_separated_pval0.05_lfc0.6/PL23_2DG_vs_PL23.txt")


head(PL23, 30)
tail(PL23)

PL23 <- data.frame(PL23$Symbol, c(rep("PL2-3 2DG vs PL2-3", nrow(PL23))), -1*log10(PL23$`Expr p-value`), PL23$`Expr Log Ratio`)
colnames(PL23) <- c("ID", "comparison", "p.value", "LFC")
PL23 <- filter(PL23, p.value > 1.3 & abs(LFC) > 1)
head(PL23)
ID_list <- PL23$ID
head(ID_list)

R848 <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/R848_2DG_vs_R848.xls",
                   skip = 1)
R848 <- data.frame(R848$Symbol, c(rep("R848 2DG vs R848", nrow(R848))), -1*log10(R848$`Expr p-value`), R848$`Expr Log Ratio`)
colnames(R848) <- c("ID", "comparison", "p.value", "LFC")
R848 <- filter(R848, ID %in% ID_list)
head(R848)

NP <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/NP_2DG_vs_NP.xls",
                 skip = 1)
NP <- data.frame(NP$Symbol, c(rep("NP 2DG vs NP", nrow(NP))), -1*log10(NP$`Expr p-value`), NP$`Expr Log Ratio`)
colnames(NP) <- c("ID", "comparison", "p.value", "LFC")
NP <- filter(NP, ID %in% ID_list)
head(NP)

MRLlpr <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/AM14_MRLlpr_2DG_vs_Control.xls",
                     skip = 1)
MRLlpr <- data.frame(MRLlpr$Symbol, c(rep("AM14 MRLlpr 2DG vs Control", nrow(MRLlpr))), -1*log10(MRLlpr$`Expr p-value`), MRLlpr$`Expr Log Ratio`)
colnames(MRLlpr) <- c("ID", "comparison", "p.value", "LFC")
MRLlpr <- filter(MRLlpr, ID %in% ID_list)
head(MRLlpr)
