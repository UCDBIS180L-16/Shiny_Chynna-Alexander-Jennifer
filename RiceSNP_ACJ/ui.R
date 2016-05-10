library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage( #create the overall page
  
  # Application title
  titlePanel("Rice SNP Data by Population"),
  
  # Some helpful information
  helpText("This application creates a boxplot to show difference between",
           "iris species.  Please use the radio box below to choose a trait",
           "for plotting"),
  
  # Sidebar with a radio box to input which trait will be plotted
  sidebarLayout(
    sidebarPanel(
      selectInput("trait", #the input variable that the value will go into
                  label = "Choose a trait to display:",
                  choices = c("Amylose.content",
                              "Alu.Tol",
                              "Protein.content",
                              "Panicle.number.per.plant",
                              "Seed.number.per.panicle")
      )),
    
    # Show a plot of the generated distribution
    mainPanel(plotOutput("boxPlot")
    )
  )
))