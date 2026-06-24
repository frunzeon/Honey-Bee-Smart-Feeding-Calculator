library(shiny)
library(DT)

# Honey Bee Smart Feeding Calculator
# Review-safe terminology:
# - The app estimates target overwintering food reserves and supplemental sugar requirements.
# - The app does not subtract measured honey already present in the hive.
# - Economic outputs are comparisons, not proof of cost savings.

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
      DTOutput("result"),
      
      h4(textOutput("econSummary")),
      DTOutput("economics"),
      
      plotOutput("plot1"),
      plotOutput("plot2")
    )
  )
)

server <- function(input, output, session) {
  
  output$localizedUI <- renderUI({
    lang <- input$language
    
    txt <- switch(lang,
                  "한국어" = list(
                    species = "종 선택:",
                    colonies = "봉군 수:",
                    frames = "한 봉군당 벌이 덮고 있는 프레임 수:",
                    sugar = "설탕 가격 (₩/kg):",
                    honey = "꿀 가격 (₩/kg):",
                    currency = "통화:",
                    run = "계산 실행",
                    info = "계산 정보: 급이 횟수 9–12회 (3–4주)",
                    note1 = "1. <i>Apis mellifera</i>는 Dadant(프레임당 4 kg 저장량) 또는 Langstroth–Ruta(프레임당 3 kg 저장량) 중 선택합니다.",
                    note2 = "2. <i>Apis cerana</i>의 기본 월동 먹이 저장량은 프레임당 2 kg으로 추정됩니다.",
                    note3 = "3. 이 앱은 목표 저장량과 보충 설탕 요구량을 추정하며, 현재 벌통 내 꿀 저장량을 직접 차감하지 않습니다."
                  ),
                  "Русский" = list(
                    species = "Выберите вид:",
                    colonies = "Количество семей:",
                    frames = "Количество рамок, занятых пчёлами, на семью:",
                    sugar = "Цена сахара за кг:",
                    honey = "Цена мёда за кг:",
                    currency = "Валюта:",
                    run = "Выполнить расчёт",
                    info = "Информация по расчётам: 9–12 подкормок (3–4 недели)",
                    note1 = "1. Для <i>Apis mellifera</i> выберите тип рамки: Dadant (4 кг запаса/рамку) или Langstroth–Ruta (3 кг запаса/рамку).",
                    note2 = "2. Для <i>Apis cerana</i> базовый зимний запас корма оценивается как 2 кг на рамку.",
                    note3 = "3. Приложение оценивает целевой запас и потребность в сахаре, но не вычитает фактический запас мёда в улье."
                  ),
                  list(
                    species = "Select species:",
                    colonies = "Number of colonies:",
                    frames = "Number of bee-occupied frames per colony:",
                    sugar = "Sugar price per kg:",
                    honey = "Honey price per kg:",
                    currency = "Currency:",
                    run = "Run Calculation",
                    info = "Notes: feeding frequency 9–12 times (3–4 weeks)",
                    note1 = "1. For <i>Apis mellifera</i>, select frame type: Dadant (4 kg reserve/frame) or Langstroth–Ruta (3 kg reserve/frame).",
                    note2 = "2. For <i>Apis cerana</i>, the default overwintering reserve is estimated at 2 kg per frame.",
                    note3 = "3. This app estimates target reserves and supplemental sugar requirements; it does not directly subtract measured honey already present in the hive."
                  )
    )
    
    tagList(
      radioButtons(
        "species", txt$species,
        choiceNames = list(HTML("<i>Apis mellifera</i>"), HTML("<i>Apis cerana</i>")),
        choiceValues = c("Apis mellifera", "Apis cerana"),
        selected = "Apis mellifera"
      ),
      
      uiOutput("frameTypeUI"),
      
      numericInput("colonies", txt$colonies, 1, min = 1, step = 1),
      numericInput("frames", txt$frames, 5, min = 1, step = 1),
      
      hr(),
      h4(ifelse(lang == "한국어", "경제적 비교",
                ifelse(lang == "Русский", "Экономическое сравнение", "Economic Comparison"))),
      numericInput("sugar_price", txt$sugar, 1.2, step = 0.1),
      numericInput("honey_price", txt$honey, 10, step = 0.5),
      
      selectInput("currency", txt$currency,
                  choices = c("USD ($)", "KRW (₩)", "EUR (€)", "RUB (₽)"),
                  selected = switch(lang,
                                    "한국어" = "KRW (₩)",
                                    "Русский" = "RUB (₽)",
                                    "USD ($)")),
      
      actionButton("calculate", txt$run),
      
      hr(),
      h4(txt$info),
      helpText(HTML(txt$note1)),
      helpText(HTML(txt$note2)),
      helpText(HTML(txt$note3)),
      
      hr(),
      h4(ifelse(lang == "한국어", "계산식",
                ifelse(lang == "Русский", "Расчёты", "Calculations"))),
      helpText(ifelse(lang == "한국어",
                      "1. 총 프레임 수 = 한 봉군당 프레임 수 × 봉군 수.",
                      ifelse(lang == "Русский",
                             "1. Общее число рамок = рамок на семью × число семей.",
                             "1. Total frames = Frames per colony × Number of colonies."))),
      helpText(ifelse(lang == "한국어",
                      "2. 목표 월동 먹이 저장량(kg) = 프레임당 먹이 저장량 × 총 프레임 수.",
                      ifelse(lang == "Русский",
                             "2. Целевой зимний запас корма (кг) = запас корма на рамку × общее число рамок.",
                             "2. Target overwintering food reserve (kg) = Food reserve per frame × Total frames."))),
      helpText(ifelse(lang == "한국어",
                      "3. 추정 보충 설탕 요구량(kg) = 목표 월동 먹이 저장량 × 1.0.",
                      ifelse(lang == "Русский",
                             "3. Оценочная потребность в сахаре для подкормки (кг) = целевой зимний запас корма × 1.0.",
                             "3. Estimated supplemental sugar requirement (kg) = Target overwintering food reserve × 1.0."))),
      helpText(ifelse(lang == "한국어",
                      "4. 꿀 저장량의 시장가치 = 목표 월동 먹이 저장량 × 꿀 가격/kg.",
                      ifelse(lang == "Русский",
                             "4. Рыночная стоимость медового запаса = целевой зимний запас корма × цена мёда за кг.",
                             "4. Honey reserve value = Target overwintering food reserve × Honey price per kg."))),
      helpText(ifelse(lang == "한국어",
                      "5. 보충 설탕 급이 비용 = 추정 보충 설탕 요구량 × 설탕 가격/kg.",
                      ifelse(lang == "Русский",
                             "5. Стоимость сахарной подкормки = оценочная потребность в сахаре × цена сахара за кг.",
                             "5. Supplemental sugar feeding cost = Estimated supplemental sugar requirement × Sugar price per kg."))),
      helpText(ifelse(lang == "한국어",
                      "6. 그래프는 먹이 저장 요구량과 경제적 비교를 보여줍니다.",
                      ifelse(lang == "Русский",
                             "6. Графики показывают требуемый запас корма и экономическое сравнение.",
                             "6. Plots show food reserve requirements and cost comparisons.")))
    )
  })
  
  output$frameTypeUI <- renderUI({
    req(input$species)
    if (input$species == "Apis mellifera") {
      lang <- input$language
      frame_label <- switch(lang,
                            "한국어" = "프레임 유형:",
                            "Русский" = "Тип рамки:",
                            "Frame type:")
      selectInput("frame_type", frame_label,
                  choices = c("Dadant (435×300 mm, 4 kg reserve/frame)" = "Dadant",
                              "Langstroth–Ruta (435×230 mm, 3 kg reserve/frame)" = "Langstroth"),
                  selected = "Langstroth")
    }
  })
  
  observeEvent(input$calculate, {
    req(input$species, input$colonies, input$frames, input$sugar_price, input$honey_price)
    
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
    
    species_html <- if (input$species == "Apis mellifera") {
      "<i>Apis mellifera</i>"
    } else {
      "<i>Apis cerana</i>"
    }
    
    output$result <- renderDT({
      datatable(
        data.frame(
          Species = species_html,
          Frame_Type = ifelse(input$species == "Apis cerana", "Species-specific default", input$frame_type),
          Colonies = input$colonies,
          Bee_Occupied_Frames_per_Colony = input$frames,
          Food_Reserve_per_Frame_kg = honey_per_frame,
          Total_Frames = total_frames,
          Target_Overwintering_Food_Reserve_kg = total_food,
          Estimated_Supplemental_Sugar_kg = sugar_needed,
          check.names = FALSE
        ),
        escape = FALSE,
        rownames = FALSE,
        options = list(dom = "t", paging = FALSE, searching = FALSE)
      )
    })
    
    output$economics <- renderDT({
      datatable(
        data.frame(
          Honey_Reserve_Value = paste0(symbol, format(round(honey_cost, 2), big.mark = ",", scientific = FALSE)),
          Supplemental_Sugar_Feeding_Cost = paste0(symbol, format(round(sugar_cost, 2), big.mark = ",", scientific = FALSE)),
          check.names = FALSE
        ),
        escape = FALSE,
        rownames = FALSE,
        options = list(dom = "t", paging = FALSE, searching = FALSE)
      )
    })
    
    lang <- input$language
    main1_prefix <- switch(lang,
                           "한국어" = "목표 월동 먹이 저장량",
                           "Русский" = "Целевой зимний запас корма",
                           "Target overwintering food reserve")
    main2_prefix <- switch(lang,
                           "한국어" = "경제적 비교",
                           "Русский" = "Экономическое сравнение",
                           "Economic comparison")
    species_plot <- input$species
    main1_expr <- as.expression(bquote(.(main1_prefix) ~ "-" ~ italic(.(species_plot))))
    main2_expr <- as.expression(bquote(.(main2_prefix) ~ "-" ~ italic(.(species_plot))))
    
    output$plot1 <- renderPlot({
      barplot(c(total_food, sugar_needed),
              names.arg = c("Target Reserve (kg)", "Estimated Supplemental Sugar (kg)"),
              main = "", ylab = "kg", col = c("gold", "lightblue"))
      title(main = main1_expr)
    })
    
    output$plot2 <- renderPlot({
      barplot(c(honey_cost, sugar_cost),
              names.arg = c("Honey Reserve Value", "Supplemental Sugar Cost"),
              main = "", ylab = paste("Cost (", symbol, ")", sep = ""),
              col = c("gold", "lightblue"))
      title(main = main2_expr)
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
    if (lang == "한국어") "경제 비교 요약"
    else if (lang == "Русский") "Резюме экономического сравнения"
    else "Economic Comparison Summary"
  })
}

shinyApp(ui, server)
