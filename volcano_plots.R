PL23 <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - PL2-3.xls",
                   skip = 1)
PL23 <- data.frame(PL23$Symbol, PL23$`Expr p-value`, PL23$`Expr Log Ratio`)
colnames(PL23) <- c("ID", "p.value", "LFC")
# PL23 <- filter(PL23, p.value > 1.3 & abs(LFC) > 1)
head(PL23)
# ID_list <- PL23$ID
# head(ID_list)

R848 <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - R848.xls",
                   skip = 1)
R848 <- data.frame(R848$Symbol, R848$`Expr p-value`, R848$`Expr Log Ratio`)
colnames(R848) <- c("ID", "p.value", "LFC")
# R848 <- filter(R848, ID %in% ID_list)
head(R848)

NP <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - NP.xls",
                 skip = 1)
NP <- data.frame(NP$Symbol, NP$`Expr p-value`, NP$`Expr Log Ratio`)
colnames(NP) <- c("ID", "p.value", "LFC")
# NP <- filter(NP, ID %in% ID_list)
head(NP)

MRLlpr <- read_excel("../cohorts_and_treatments_separated_pval0.05_lfc0.6/Upstream_Regulators/IFNG network - AM14 MRLlpr.xls",
                     skip = 1)
MRLlpr <- data.frame(MRLlpr$Symbol, MRLlpr$`Expr p-value`, MRLlpr$`Expr Log Ratio`)
colnames(MRLlpr) <- c("ID", "p.value", "LFC")
# MRLlpr <- filter(MRLlpr, ID %in% ID_list)
head(MRLlpr)


volcano_wrapper <- function(dat, plot_title, sub_title, x_limits, y_limits, cap, file_name, h, w){
  if(missing(plot_title)) plot_title <- "Plot Title"
  if(missing(sub_title)) sub_title <- ""
  if(missing(cap)) cap <- " "
  if(missing(file_name)) file_name <- NULL
  if(missing(h)) h <- 2500
  if(missing(w)) w <- 2500
  
  if(missing(x_limits)){
    x_min <- min(dat$LFC)
    x_max <- max(dat$LFC)
    x_limits <- c(floor(x_min), ceiling(x_max))
    # print(stri_join("x_min = ", x_min))
    # print(stri_join("x_max = ", x_max))
  }
  
  if(missing(y_limits)){
    y_max <- -log10(min(dat$p.value))
    y_limits <- c(0, ceiling(y_max))
    # print(stri_join("y_max = ", y_max))
  }

  vp <- EnhancedVolcano(dat, lab = dat$ID,
                        FCcutoff = 0.6, pCutoff = 0.05,
                        x = 'LFC', y = 'p.value',
                        xlim = x_limits, ylim = y_limits,
                        title = plot_title, subtitle = sub_title,
                        caption = cap,
                        # col = wes_palette("Zissou1", type = "continuous"),
                        drawConnectors = TRUE, min.segment.length = 1,
                        max.overlaps = 12, labSize = 4)
  
  if(!is.null(file_name)){
      if(!file.exists("Output/")) dir.create("Output/")
      if(!file.exists("Output/Volcano_plots/")) dir.create("Output/Volcano_plots/")

      ggsave(stri_join("Output/Volcano_plots/", file_name, ".png"),
             units = "px", width = w, height = h, dpi = 300)
  }
  vp
}

volcano_wrapper(PL23, "Genes Downstream of IFNG", "PL2-3 + 2DG vs PL2-3", x_limits = c(-10, 5))
volcano_wrapper(MRLlpr, "Genes Downstream of IFNG", "AM14 MRL/lpr: 2DG vs Control", x_limits = c(-2, 2))
volcano_wrapper(R848, "Genes Downstream of IFNG", "R848 + 2DG vs R848")
volcano_wrapper(NP, "Genes Downstream of IFNG", "NP + 2DG vs NP")

  
