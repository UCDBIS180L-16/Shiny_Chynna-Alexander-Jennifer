
library(shiny)
library(ggplot2)

load("Rice_Data2")

# Define server logic required to draw a boxplot
shinyServer(function(input, output) {
  
  #output will be a sentence summary describing the graph made.   
  output$text1 <- renderText({paste("Congratulations! You made a",input$plot,"based upon", input$trait, ".")})
  
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
    #otherwise make violin plot with drawn quartiles
    else if (input$plot == "Violin Plot"){
      pl + geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))
    }
    #if histogram option is chosen, draw histogram for chose trait
    #facet_wrap makes an individual histogram for each popID
    else{
      ggplot(data = rice2, aes_string(x = input$trait, fill = "popID")) + geom_histogram() + facet_wrap(facets = ~popID, ncol=2)
    }
  })
})