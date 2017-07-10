library(shiny)

shinyUI(fluidPage(

  titlePanel("Effect of various sprays"),

  sidebarLayout(
    sidebarPanel(
       checkboxInput("A", "Spray A"),
       checkboxInput("B", "Spray B"),
       checkboxInput("C", "Spray C"),
       checkboxInput("D", "Spray D"),
       checkboxInput("E", "Spray E"),
       checkboxInput("F", "Spray F")
    ),


    mainPanel(
            tabsetPanel(type = "tabs",
                tabPanel("Document",
                         h4("InsectSprays Dataset"),
                         h5("The dataset measured the number of insects after
                            sprayed by 6 insecticides: A - F."),
                         h5("This App can do 2 things:"),
                         h5("1. after selecting any number of sprays, it will make a boxplot;"),
                         h5("2. if 2 sprays are selected, it will run a t test and give
                            p value, and conclude whether the 2 sprays are
                            significantly different.")
                         ),
                tabPanel("Boxplot", br(), plotOutput("plot1")),
                tabPanel("t test", h3("t test results"), br(),
                         h4("p value is "),
                         textOutput("pvalue"),
                         br(), textOutput("result")
                )
    )
  )
)
))
