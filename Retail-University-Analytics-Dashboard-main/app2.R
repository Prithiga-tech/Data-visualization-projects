library(shiny)
library(ggplot2)

categories <- c("Electronics","Apparel","Groceries","Furniture","Toys")
chennai <- c(200,150,180,220,140)
bengaluru <- c(210,160,170,200,130)
hyderabad <- c(190,140,160,210,120)

sales <- data.frame(
  category = categories,
  Chennai = chennai,
  Bengaluru = bengaluru,
  Hyderabad = hyderabad
)

courses <- data.frame(
  course = c("DS","ML","OS","CN"),
  grade = c("A","B","C","A"),
  credits = c(4,3,3,4)
)

ui <- fluidPage(
  titlePanel("📊 Retail & University Dashboard"),
  
  tabsetPanel(
    
    tabPanel("Retail Analysis",
             plotOutput("salesPlot")
    ),
    
    tabPanel("Student Report",
             tableOutput("report"),
             textOutput("status")
    )
  )
)

server <- function(input, output){
  
  output$salesPlot <- renderPlot({
    totals <- rowSums(sales[,2:4])
    barplot(totals, names.arg = sales$category,
            col="green", main="Total Sales by Category")
  })
  
  output$report <- renderTable({
    courses
  })
  
  output$status <- renderText({
    total_credits <- sum(courses$credits)
    if(total_credits >= 12){
      "Eligible"
    } else {
      "Not Eligible"
    }
  })
}

shinyApp(ui, server)