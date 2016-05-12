
library(shiny)
library(ggplot2)

load("Rice_Data2")

# Define server logic required to draw a boxplot
shinyServer(function(input, output) {
  
  #output will be a plot of the following format
  output$plot <- renderPlot({
    
    
    pl <- ggplot(data = rice2,
                 #Use aes_string below so that input$trait is interpreted
                 #correctly.  The other variables need to be quoted
                 aes_string(x="popID",
                            y=input$trait,
                            fill="Region"
                 )
    )
    
    # if boxplot option chosen, draw the boxplot for the specified trait
    if (input$plot == "Boxplot"){
      pl + geom_boxplot()
    }
    #if histopgram option is chosen, draw histogram for chose trait
    #facet_wrap makes an individual histogram for each popID
    if (input$plot == "Histogram"){
      ggplot(data = rice2, aes_string(x = input$trait, fill = "popID")) + geom_histogram() + facet_wrap(facets = ~popID, ncol=2)
    }
    #otherwise make violin plot with drawn quartiles
    else {
      pl + geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))
    }
  })
})