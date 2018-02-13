
library(shiny)
library(ggplot2)
ui <- fluidPage(               
  titlePanel( "Fit a Lognormal distrbution"),
  sidebarLayout(   
      sidebarPanel(
       
        numericInput("p50", "P50 (K):", 2e3),
        numericInput("p80", "P80 (K):", 5e3),
        numericInput("p98", "P98 (K):", 10e3),
        submitButton("Run")
      ),
  
           
      mainPanel(
        tableOutput("results"),     
        plotOutput("plot", width="50%", height="400px")
               
      )
        
  )
  
)
