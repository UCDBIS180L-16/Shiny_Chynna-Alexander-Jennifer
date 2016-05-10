library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage( #create the overall page
  
  # Application title
  titlePanel("Iris Data"),
  
  # Some helpful information
  helpText("This application creates a boxplot to show difference between",
           "iris species.  Please use the radio box below to choose a trait",
           "for plotting"),
  
  # Sidebar with a radio box to input which trait will be plotted
  sidebarLayout(
    sidebarPanel(
      radioButtons("Plot",
                   "Choose a plot to display:",
                   c("Violin Plot",
                     "Boxplot")),
      
      
      radioButtons("trait", #the input variable that the value will go into
                   "Choose a trait to display:",
                   c("Alu.Tol",
                     "Plant.height",
                     "Panicle.length",
                     "Seed.length",
                     "Seed.width")
      )),
    radioButtons("popID",
                 "Choose popID",
                 c("1", "2", "3", "4")),
    
    # Show a plot of the generated distribution
    mainPanel(plotOutput(input$plot)
    )
  )
))

