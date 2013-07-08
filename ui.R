library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Law of Large Numbers"),
  
  sidebarPanel(
    
    sliderInput("max.n", 
                "Maximum number of samples:", 
                value = 1000,
                min = 600, 
                max = 10000),
  br(),
  helpText(a(href="https://github.com/tgouhier/lnumbers", target="_blank", "View code"))),
        
  mainPanel(
    plotOutput("plot", height="900px")
  )
))