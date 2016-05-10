library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage( #create the overall page
  
  # Application title
  titlePanel("Rice SNPs by Ancestral Populations"),
  
  # Some helpful information
  helpText("This application allows the user to create a boxplot, historgram, and violin plot
           of Rice SNP data from several ancestral rice populations for several traits."),
  
  # Sidebar with a radio box to input which trait will be plotted
  sidebarLayout(
    sidebarPanel(
      selectInput("popID", "Population:",
                  list("Population 1" = "1", 
                       "Population 2" = "2",
                       "Population 3" = "3",
                       "Population 4" = "4")),
      radioButtons("trait", #the input variable that the value will go into
                   "Choose a trait to display:",
                   c("Alu.Tol",
                     "Amylose.content",
                     "Alkali.spreading.value",
                     "Protein.content")
      )),
    
    # Show a plot of the generated distribution
    mainPanel(plotOutput("boxPlot")
    )
  )
))

