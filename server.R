library(shiny)
library(plotly)
library(RColorBrewer)
data(mtcars)
mtcars$am <- ifelse(mtcars$am == 0, "automatic", "manual")
xyChoices <- c("Miles per gallon" = "mpg",
               "Displacement (cu.in.)" = "disp",
               "Gross horsepower" = "hp",
               "Rear axle ratio" = "drat",
               "Weight (1000 lbs)" = "wt",
               "1/4 mile time" = "qsec")

shinyServer(function(input, output, session) {
  
  output$plot <- renderPlotly({
    
    # Draw an interctive scatter plot with the specified variables
    plot_ly(x = mtcars[, input$x],
            y = mtcars[, input$y],
            type = 'scatter', mode = "markers",
            color = factor(mtcars[, input$color]),
            colors = brewer.pal(6, "Set2"),
            text = rownames(mtcars)) %>%
      layout(xaxis = list(title = names(xyChoices[xyChoices == input$x])),
             yaxis = list(title = names(xyChoices[xyChoices == input$y])))
  })
  
  # Adjust choices to ensure selection of different columns for x and y
  observe({
    updateSelectInput(session, "x",
                      choices = xyChoices[xyChoices != input$y],
                      selected = input$x)
    updateSelectInput(session, "y",
                      choices = xyChoices[xyChoices != input$x],
                      selected = input$y)
  })
})
