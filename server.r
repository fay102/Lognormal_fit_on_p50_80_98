
server <- function(input, output){
   
    dataInput <- reactive({est_function(1e3*input$p50, 1e3*input$p80, 1e3*input$p98)})
   
    trunc_cdf <- function(x, mu, sigma){
      (plnorm(x,mu,sigma)-plnorm(1e6, mu, sigma))/(1-plnorm(1e6, mu, sigma))}
       
    output$plot <- renderPlot({   
        xmin <- 1e6
        xmax <- 3 * dataInput()[5]
        logX <- seq(log(xmin), log(xmax),0.1)
        X <- exp(logX)
        Y <- trunc_cdf(X, dataInput()[1], dataInput()[2])
        ggplot(data.frame(logX,Y),aes(x=logX,y=Y)) + geom_line(col='blue') +
        geom_point(aes(x=log(1e3*input$p50), y=0.5), col='red', shape=4,size=3) +
        geom_point(aes(x=log(1e3*input$p80), y=0.8), col='red', shape=4,size=3) +
        geom_point(aes(x=log(1e3*input$p98), y=0.98), col='red', shape=4,size=3) +
        labs(title="CDF plot",  y='Conditional CDF') + theme(plot.title = element_text(size=10))
      
        #hist(rlnorm(1e5,dataInput()[1],dataInput()[2]), breaks=200, main="Histogram for Lognormal distribution",
      #      xlab="x")          
    })

   output$results <- renderTable({     
     data.frame(dataInput())
   })
   
}
