library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Law of Large Numbers"),
  
  sidebarPanel(
    
    sliderInput("max.n", 
                "Maximum number of samples:", 
                value = 1000,
                min = 600, 
                max = 10000)
    ),
    
  mainPanel(
    plotOutput("plot", height="900px")
  )
))