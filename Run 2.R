library(shiny)

ui <- fluidPage(
  titlePanel("Honey Bee Smart Feeding Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("language", "Select Language:",
                  choices = c("English", "한국어", "Русский"),
                  selected = "English"),
      hr(),
      uiOutput("localizedUI")
    ),
    
    mainPanel(
      h4(textOutput("calcResults")),
      tableOutput("result"),
      
      h4(textOutput("econSummary")),
      tableOutput("economics"),
      
      plotOutput("plot1"),
      plotOutput("plot2")
    )
  )
)

server <- function(input, output, session) {
  
  output$localizedUI <- renderUI({
    lang <- input$language
    
    txt <- switch(lang,
                  "한국어" = list(species = "종 선택:",
                               colonies = "봉군 수:",
                               frames = "한 봉군당 완전밀봉된 벌통 수:",
                               sugar = "설탕 가격 (₩/kg):",
                               honey = "꿀 가격 (₩/kg):",
                               currency = "통화:",
                               run = "계산 실행",
                               info = "계산 정보: 급이 횟수 9–12회 (3–4주)",
                               note1 = "1. Apis mellifera는 Dadant(4kg) 또는 Langstroth-Ruta(3kg) 중 선택.",
                               note2 = "2. Apis cerana = 2kg/프레임."),
                  "Русский" = list(species = "Выберите вид:",
                                   colonies = "Количество семей:",
                                   frames = "Количество полномёдных рамок на семью:",
                                   sugar = "Цена сахара за кг:",
                                   honey = "Цена мёда за кг:",
                                   currency = "Валюта:",
                                   run = "Выполнить расчёт",
                                   info = "Информация по расчётам: 9–12 подкормок (3–4 недели)",
                                   note1 = "1. Apis mellifera: выберите тип рамки Dadant (4 кг) или Langstroth-Ruta (3 кг).",
                                   note2 = "2. Apis cerana = 2 кг на рамку."),
                  list(species = "Select species:",
                       colonies = "Number of colonies:",
                       frames = "Number of frames per colony:",
                       sugar = "Sugar price per kg:",
                       honey = "Honey price per kg:",
                       currency = "Currency:",
                       run = "Run Calculation",
                       info = "Notes: Feeding Frequency 9–12 times (3–4 weeks)",
                       note1 = "1. For Apis mellifera, select frame type: Dadant (4 kg) or Langstroth–Ruta (3 kg).",
                       note2 = "2. For Apis cerana, fixed at 2 kg per frame.")
    )
    
    tagList(
      selectInput("species", txt$species,
                  choices = c("Apis mellifera", "Apis cerana")),
      
      uiOutput("frameTypeUI"),
      
      numericInput("colonies", txt$colonies, 1, min = 1, step = 1),
      numericInput("frames", txt$frames, 5, min = 1, step = 1),
      
      hr(),
      h4(ifelse(lang == "한국어", "경제 평가",
                ifelse(lang == "Русский", "Экономическая оценка", "Economic Evaluation"))),
      numericInput("sugar_price", txt$sugar, 1.2, step = 0.1),
      numericInput("honey_price", txt$honey, 10, step = 0.5),
      
      selectInput("currency", txt$currency,
                  choices = c("USD ($)", "KRW (₩)", "EUR (€)", "RUB (₽)"),
                  selected = switch(lang,
                                    "한국어"="KRW (₩)",
                                    "Русский"="RUB (₽)",
                                    "USD ($)")),
      
      actionButton("calculate", txt$run),
      
      hr(),
      h4(txt$info),
      helpText(txt$note1),
      helpText(txt$note2),
      
      # --- new start ---
      hr(),
      h4("Calculations"),
      helpText("1.Total frames = Frames per colony × Number of colonies."),
      helpText("2. Total food (honey) = Honey per frame × Total frames."),
      helpText("3. Sugar needed = Total food × 1.0"),
      helpText("4. Honey cost = Total food × Honey price per kg."),
      helpText("5. Sugar cost = Sugar needed × Sugar price per kg."),
      helpText("6. Plots show food vs sugar requirement and cost comparison.
       ")
      # --- new end ---
    )
  })
  
  output$frameTypeUI <- renderUI({
    if (input$species == "Apis mellifera") {
      selectInput("frame_type", "Frame type:",
                  choices = c("Dadant (435×300 mm, 4 kg honey)" = "Dadant",
                              "Langstroth–Ruta (435×230 mm, 3 kg honey)" = "Langstroth"),
                  selected = "Langstroth")
    }
  })
  
  observeEvent(input$calculate, {
    honey_per_frame <- if (input$species == "Apis mellifera") {
      if (!is.null(input$frame_type) && input$frame_type == "Dadant") 4 else 3
    } else {
      2
    }
    
    total_frames <- input$frames * input$colonies
    total_food <- honey_per_frame * total_frames
    sugar_needed <- total_food * 1.0
    honey_cost <- total_food * input$honey_price
    sugar_cost <- sugar_needed * input$sugar_price
    
    symbol <- switch(input$currency,
                     "KRW (₩)" = "₩",
                     "USD ($)" = "$",
                     "EUR (€)" = "€",
                     "RUB (₽)" = "₽",
                     "$")
    
    output$result <- renderTable({
      data.frame(
        Species = input$species,
        Frame_Type = ifelse(is.null(input$frame_type), "Fixed", input$frame_type),
        Colonies = input$colonies,
        Frames_per_Colony = input$frames,
        Honey_per_Frame_kg = honey_per_frame,
        Total_Frames = total_frames,
        Total_Food_kg = total_food,
        Sugar_Needed_kg = sugar_needed
      )
    }, align = "c", digits = 2)
    
    output$economics <- renderTable({
      data.frame(
        Honey_Cost = paste0(symbol, format(round(honey_cost, 2), big.mark = ",", scientific = FALSE)),
        Sugar_Cost = paste0(symbol, format(round(sugar_cost, 2), big.mark = ",", scientific = FALSE))
      )
    }, align = "c")
    
    lang <- input$language
    main1 <- switch(lang,
                    "한국어"=paste("월동 먹이 필요량 -", input$species),
                    "Русский"=paste("Потребность в корме -", input$species),
                    paste("Overwintering Food Requirement -", input$species))
    main2 <- switch(lang,
                    "한국어"=paste("경제 비교 -", input$species),
                    "Русский"=paste("Экономическое сравнение -", input$species),
                    paste("Economic Comparison -", input$species))
    
    output$plot1 <- renderPlot({
      barplot(c(total_food, sugar_needed),
              names.arg = c("Total Food (kg)", "Sugar Needed (kg)"),
              main = main1, ylab = "kg", col = c("gold", "lightblue"))
    })
    
    output$plot2 <- renderPlot({
      barplot(c(honey_cost, sugar_cost),
              names.arg = c("Honey Cost", "Sugar Cost"),
              main = main2, ylab = paste("Cost (", symbol, ")", sep=""),
              col = c("gold", "lightblue"))
    })
  })
  
  output$calcResults <- renderText({
    lang <- input$language
    if (lang == "한국어") "계산 결과"
    else if (lang == "Русский") "Результаты расчёта"
    else "Calculation Results"
  })
  
  output$econSummary <- renderText({
    lang <- input$language
    if (lang == "한국어") "경제 요약"
    else if (lang == "Русский") "Экономическое резюме"
    else "Economic Summary"
  })
}

shinyApp(ui, server)

    