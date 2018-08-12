library(shiny)
library(collapsibleTree)

L1 <- c("mi","mi","mi","stroke","stroke","death")
L2 <- c("stroke","mi","hf","hf","stroke","")
L3 <- c("","","","mi","hf","")
N <- c(45,10,23,5,7,61)

myData <- data.frame(L1,L2,L3,N)

# Define UI for application that draws a collapsible tree
ui <- fluidPage(

  # Application title
  titlePanel("Collapsible Tree Example 2: Shiny Interaction"),

  # Sidebar with a select input for the root node
  sidebarLayout(
    sidebarPanel(
      selectInput("root", "Root node", c("wool", "tension")),
      tags$p("The node you most recently clicked:"),
      verbatimTextOutput("str")
    ),

    # Show a tree diagram with the selected root node
    mainPanel(
      collapsibleTreeOutput("plot")
    )
  )
)

# Define server logic required to draw a collapsible tree diagram
server <- function(input, output) {

  output$plot <- renderCollapsibleTree({
    # if(input$root=="wool") {
    #   hierarchy <- c("wool","tension","breaks")
    # } else {
      hierarchy <- c("L1","L2","L3")
    # }
    collapsibleTree(
      myData, hierarchy, "CVD",
      inputId = "node", linkLength = 100, nodeSize = "N", zoomable = FALSE
    )
  })
  output$str <- renderPrint(str(input$node))
}

# Run the application
shinyApp(ui = ui, server = server)
