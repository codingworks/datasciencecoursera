library(shiny)
library(plotly)

shinyUI(fluidPage(
  titlePanel("Explore Motor Trend"),
  sidebarLayout(
    sidebarPanel(
      p("This application enables users to draw interactive plots for the mtcars dataset.  
        The plots are in three dimensions x, y and color. Select columns for x, y and color 
        from three drop-down lists to see an interactive scatter plot."),
      
      # Initialize x. More choices will be added by server
      selectInput("x", "x:", c("Gross horsepower" = "hp"), selected = "hp"),
      
      # Initialize y. More choices will be added by server
      selectInput("y", "y:", c("Miles per gallon" = "mpg"), selected = "mpg"),
      
      selectInput("color", "color:",
                  c("Number of cylinders" = "cyl",
                    "V/S" = "vs",
                    "Transmission" = "am",
                    "Number of forward gears" = "gear",
                    "Number of carburetors" = "carb"),
                  selected = "am")
    ),
    
    mainPanel(
      plotlyOutput("plot")
    )
  )
))
