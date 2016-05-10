
library(shiny)
library(ggplot2)
library(reshape2)

data.geno <- read.csv("~/Rice_44K_genotypes.csv.gz", row.names = 1, na.strings=c("NA", "00"))
data.pheno <- read.csv("~/RiceDiversity.44K.MSU6.Phenotypes.csv", row.names = 1, na.strings=c("NA", "00"))
data.geno.2500 <- data.geno[ , sample(ncol(data.geno), 2500)]
geno.numeric <- data.matrix(data.geno.2500)
genDist <- as.matrix(dist(geno.numeric))
geno.mds <- as.data.frame(cmdscale(genDist))
data.merged <- merge(geno.mds,data.pheno, by.x = "row.names", by.y = 1)
data.geno.pheno <- merge(geno.mds, data.pheno, by= "row.names")
data.geno.2500.c <- apply(data.geno.2500, 2, as.character)
data.geno.2500.ps <- matrix("", nrow=nrow(data.geno.2500.c)* 2, ncol = ncol(data.geno.2500.c))
for (i in 1:nrow(data.geno.2500.c)) {
  data.geno.2500.ps[(i - 1) * 2 + 1,] <- substr(data.geno.2500.c[i, ], 1, 1)
  data.geno.2500.ps[(i - 1) * 2 + 2,] <- substr(data.geno.2500.c[i, ], 2, 2)
}
load("~/ps4.2500.RData")

round(head(ps4$AmPr), 3)
table(ps4$AmId)
ps4.df <- as.data.frame(cbind(round(ps4$AmPr, 3), ps4$AmId))
colnames(ps4.df) <- c(paste("pop", 1: (ncol(ps4.df) - 1), sep = ""), "popID")
maxGenome <- apply(ps4$AmPr, 1, max)
ps4.df <- ps4.df[order(ps4.df$popID, -maxGenome), ]
ps4.df$sampleID <- factor(1:413)
ps4.df.melt <- melt(ps4.df,id.vars=c("popID","sampleID"))
geno.mds$popID <- factor(ps4$AmId)
colnames(ps4$AmPr) <- paste("pr", 1:4, sep = "")
geno.mds <- cbind(geno.mds, ps4$AmPr)
data.pheno.mds <- merge(geno.mds,data.pheno,by.x = "row.names", by.y = 1,all=T)


# Define server logic required to draw a boxplot
shinyServer(function(input, output) {
  
  # Expression that generates a boxplot. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$boxPlot <- renderPlot({
    
    # set up the plot
    
    
    
    
    pl <- ggplot(data = data.pheno.mds,
                 #Use aes_string below so that input$trait is interpreted
                 #correctly.  The other variables need to be quoted
                 aes_string(x=input$popID,
                            y=input$trait,
                            fill=input$popID
                 )
    )
    
    # draw the boxplot for the specified trait
    if (input$plot == "Boxplot")
      pl + geom_boxplot()
    else 
      pl + geom_violin()
  })
})


