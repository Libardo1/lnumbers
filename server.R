library(shiny)

mcmc.pi <- function (n, return.locs = FALSE) {
  # Randomly select pairs of (x, y) coordinates between 0 and 1
  a=matrix(nrow=n, ncol=2, runif(n*2))
  b=matrix(nrow=n, ncol=2, runif(n*2))
  r=0.5 # Radius of unit circle
  # Multiply coordinates < 0.5 by -1 and coordinates > 0.5 by 1
  # to sample entire circle area
  b[b < 0.5]=-1; b[b > 0.5]=1; a=a*b
  # Get the points that landed within 1/4 of the circle
  pts.in=rowSums(a*a) < 1
  # Estimate area of unit circle=pi*r^2
  area=4*((sum(pts.in)/n)*r^2)
  if (return.locs) {
    result <- list(est.pi = area/r^2, 
                   in.x=a[pts.in==1, 1], 
                   in.y=a[pts.in==1, 2], 
                   out.x=a[pts.in==0, 1], 
                   out.y=a[pts.in==0, 2],
                   area=area)
  }
  else {
    result <- list(est.pi = area/r^2)
  }
    
  return (result)  
}

shinyServer(function(input, output) {
  data <- reactive({
    return (list(max.n=input$max.n))
  })
  
  output$plot <- renderPlot({
    vals <- data()
    min.n=1
    max.n <- vals$max.n    
    s <- seq(min.n, max.n, by=10)
    # Get estimate of pi for different sample sizes
    x <- sapply(s[1:(length(s)-1)], FUN = function(x) mcmc.pi(x)$est.pi)
    # Get final result
    x.last <- mcmc.pi(s[length(s)], return.locs=TRUE)
    # Append final result
    x=c(x, x.last$est.pi)
                      
    # Plot results
    #par(mfrow=c(2,1), cex=1.5)
    par(mfrow=c(2,1), cex=1.5, mar=c(1, 4, 0, 1), oma=c(2,0,2,0), tck=0.01, mgp=c(1.5, 0.2, 0))
    
    par(pty="s")
    # Plot values outside circle in blue
    plot (x.last$out.x, x.last$out.y, col = "blue", pty = "p", xlab = "", ylab = "", 
          xaxs="i", yaxs="i",
          cex = 0.5, axes = F)
    mtext(text=substitute(paste(pi == pi.val), 
                          list(pi.val=format(x.last$est.pi, dig=4))), 
          side=3, cex=1.5)
    mtext(paste0("Estimate based on ", max.n, " observations:"), side=3, cex=1.5, font=2, line=1)
    # Plot values inside circle in red
    points (x.last$in.x, x.last$in.y, col="red", cex=0.5)
    text(0, 0, paste("Area = ", format(x.last$area, dig=4)), cex=1.5, font=2) 
    box()
    
    par(pty="m")
    plot(s, x, t="l", col="red", lwd=2, xlab="Number of observations in sample (n)", ylab=expression(paste("Estimate of ", pi)), xpd=NA)
    abline(h=pi, col="black", lwd=2, lty=2)
    
  })
})
