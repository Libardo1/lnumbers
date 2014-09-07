library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Law of Large Numbers"),
  
  sidebarPanel(
    tags$head( tags$script(src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML-full", type = 'text/javascript'),
               tags$script( "MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});", type='text/x-mathjax-config')
    ),
    p("The goal of this simulation is to demonstrate the Law of Large Numbers, or how increasing the size of a sample improves the precision and potentially the accuracy of an estimate. In this case, we are trying to estimate $\\pi$, the ratio between the circumference and the diameter $2r$ of any circle."),
    p("To produce our estimate, we randomly sample x- and y-coordinates repeatedly. Each time the randomly selected point is within the unit circle, we plot it in red. Conversely, when the point lies outside the unit circle, we plot it in blue."),
p("We then approximate the area $A=\\pi \\cdot r^2$ as the proportion of randomly selected points that landed within the unit circle. Since we have an estimate of area $A$ and $r=\\frac{1}{2}$ for the unit circle, we can estimate $\\pi$ by plugging these values into the following formula: $\\pi = \\frac{A}{r^2}$."),
p("Changing the maximum number of observations in the sample via the controls below will allow you to see how the precision of the estimate varies with sample size. Note that if the sampling protocol is unbiased, increasing sample size will increase both the precision and the accuracy of the estimate."),
    h4("Simulation parameters:"),
    sliderInput("max.n", 
                "Maximum number of observations in sample:", 
                value = 1000,
                min = 600, 
                max = 10000),
  br(),
  helpText(a(href="https://github.com/tgouhier/lnumbers", target="_blank", "View code"))),
        
  mainPanel(
    plotOutput("plot", height="900px")
  )
))