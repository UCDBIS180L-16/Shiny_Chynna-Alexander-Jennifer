library(shiny)

# Define UI
shinyUI(fluidPage( #create the overall page
  
  # Application title
  titlePanel("Rice SNP Data by Population"),
  
  helpText("This application creates boxplots, violin plots, and histograms to illustrate the variation in certain traits for",
           "rice populations. Populations are divided based on ancestral population. Please use the dropdown menu to choose a trait",
           "for plotting."),
  
  # Creates sidebar
  sidebarLayout(
    sidebarPanel(
      #Creates a dropdown menu for use to choose plot type
      selectInput("plot",
                  label = "Choose the type of plot:",
                  choices =  c("Violin Plot",
                               "Boxplot",
                               "Histogram")
                  
      ),
      #Creates dropdown menu for user to choose trait to plot
      selectInput("trait",  #the input variable that the value will go into
                  label = "Choose a trait to display:",
                  choices = c("Amylose.content",
                              "Alu.Tol",
                              "Protein.content",
                              "Panicle.number.per.plant",
                              "Seed.number.per.panicle")
      )),
    
    # Shows plot with desired parameters
    mainPanel(plotOutput("plot"), textOutput("text1")
    )
  )
))