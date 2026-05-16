library(shiny)
library(dplyr)

students <- data.frame(
  name = c("Alice","Bob","Charlie","David","Emma","Frank","Grace","Harry","Ivy","Jack"),
  score = c(78,85,62,90,55,88,74,60,95,81)
)

region_A <- c(15,18,20,25,22,24)
region_B <- c(12,17,19,22,21,23)

ui <- fluidPage(
  titlePanel("📊 Student & Sales Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("score", "Minimum Score:", min=50, max=100, value=70)
    ),
    
    mainPanel(
      h3("Top Students"),
      tableOutput("topStudents"),
      
      h3("Sales Comparison"),
      plotOutput("salesPlot")
    )
  )
)

server <- function(input, output){
  
  output$topStudents <- renderTable({
    students %>% filter(score >= input$score)
  })
  
  output$salesPlot <- renderPlot({
    total <- region_A + region_B
    barplot(total, col="blue", main="Monthly Sales", ylab="Sales")
  })
}

shinyApp(ui, server)