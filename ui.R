# ui.R
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("united"),
  tags$head(
    tags$link(
      rel = "stylesheet",
      type = "text/css",
      href = "custom.css"
    ),
    tags$title(
        "openFDA Enforcement Data"
    )

  ),

  titlePanel("openFDA Enforcement Data"),

  sidebarLayout(position = "right",
    sidebarPanel(
      h3("Explore food recall trends"),
      p("
        The openFDA enforcement endpoint provides data for all food product recalls monitored by the FDA from 2012 to October 2015. Recalls are the most effective method for remedying a public health hazard posed, and are classified as follows:
      "),
      withTags(
        dl(
          dt("Class I"),
          dd("Possibility of serious adverse health consequences."),
          dt("Class II"),
          dd("Temporary or reversible health consequences."),
          dt("Class III"),
          dd("Not likely to cause adverse health consequences.")
        )
      ),
      p("
        Here we explore time series data for the total number of recalls monitored per month since 2012."),

      p("You may view data for one state at a time, or for the entire United States, via the drop-down. You may toggle display for each class of recall separately, as well as their sum data, via the checkboxes.
      "),

      p("
        Cumulative (2012-Oct. 2015) results for the region of choice are displayed below the graph.
      ")
    ),
    mainPanel(
      fluidRow(
        plotOutput("plot")
      ),

      fluidRow(
        column(3,
          selectInput("state", label = h3("State"),
            choices = list(
              "--All states--" = "the United States",
              "Alabama" = "AL",
              "Alaska" = "AK",
              "Arizona" = "AZ",
              "Arkansas" = "AR",
              "California" = "CA",
              "Colorado" = "CO",
              "Connecticut" = "CT",
              "District of Columbia" = "DC",
              "Delaware" = "DE",
              "Florida" = "FL",
              "Georgia" = "GA",
              "Hawaii" = "HI",
              "Idaho" = "ID",
              "Illinois" = "IL",
              "Indiana" = "IN",
              "Iowa" = "IA",
              "Kansas" = "KS",
              "Kentucky" = "KT",
              "Louisiana" = "LA",
              "Maine" = "ME",
              "Maryland" = "MD",
              "Massachusetts" = "MA",
              "Michigan" = "MI",
              "Minnesota" = "MN",
              "Mississippi" = "MS",
              "Missouri" = "MO",
              "Montana" = "MT",
              "Nebraska" = "NE",
              "Nevada" = "NV",
              "New Hampshire" = "NH",
              "New Jersey" = "NJ",
              "New Mexico" = "NM",
              "New York" = "NY",
              "North Carolina" = "NC",
              "North Dakota" = "ND",
              "Ohio" = "OH",
              "Oklahoma" = "OK",
              "Oregon" = "OR",
              "Pennsylvania" = "PA",
              "Rhode Island" = "RI",
              "South Carolina" = "SC",
              "South Dakota" = "SD",
              "Tennessee" = "TN",
              "Texas" = "TX",
              "Utah" = "UT",
              "Vermont" = "VT",
              "Virginia" = "VA",
              "Washington" = "WA",
              "West Virginia" = "WV",
              "Wisconsin" = "WI",
              "Wyoming" = "WY"
            ),
            selected = "NULL"
          )
        ),

        column(3,
          checkboxGroupInput("class",
            label = h3("Classification"),
            choices = list(
              # Must match factor levels of data.
              "Class I" = "Class I",
              "Class II" = "Class II",
              "Class III" = "Class III",
              "Total" = "Total"
            ),
            selected = "Total"
          )
        ),

        column(3,
          h3("Results"),
          dataTableOutput("summaryTable")
        ) # end column
      ) #end fluidRow
    )
  )

))
