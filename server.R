# server.R
library(shiny)
# API key: fdCICsf5eHW9iLexJnxuGUR71QuikQ31ou7nLpJE
# https://open.fda.gov/food/enforcement/
# https://open.fda.gov/food/enforcement/reference/

# https://api.fda.gov/food/enforcement.json?search=state:%22MA%22&count=report_date

library(ggplot2)
library(lubridate)
library(data.table)
totalData <- fread("data/totalData.csv")

shinyServer(function(input, output) {

  # Reactive expression for API calls for data, based on input$country.
  data <- reactive({
    stateID <- input$state
    classes <- input$class


    d <- totalData[class %in% classes & state == stateID]
    return(d)
  })

  state <- reactive({
    input$state
  })

  # Plotting.
  output$plot <- renderPlot({
    d <- data()
    # format for nice time series plot.
    d$monthlyTime <- as.Date(d$monthlyTime)

    #plotData <- d
    ggplot(
      aes(x = monthlyTime, y = monthlyCount, colour = class, group = class),
      data = d
    ) +
      geom_point(size=3) +
      geom_line() +
      labs(
        x = "Month",
        y = "Count"
      ) +
      ggtitle(paste(c("Monthly food recall data in ", state()), collapse = ""))
  })

  output$summaryTable <- renderDataTable(
    {
      d <- data()[,
        .("Total Count" = sum(monthlyCount)),
        by = .("Class" = class)
      ]
    },
    options = list(
      paging = FALSE,
      searching = FALSE,
      searchable = FALSE
    )

  )

})
