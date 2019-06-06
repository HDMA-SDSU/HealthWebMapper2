library(shiny)
library(stats)
library(dplyr)
library(leaflet)
library(ggplot2)
library(spdep)
library(tmap)
library(sf)
library(readr)
library(shinydashboard)
tmap_mode("view")

# import shpfiles once
SD_SRA_raw <- st_read("polygon/polygon.shp")
freeways<- st_read("polygon/freeways_WGS84.shp")
hospitals <- st_read("polygon/hospitals_WGS84.shp")

sd_sra <- data.frame(
  SRAID = as.numeric(SD_SRA_raw$SRA),
  geometry = SD_SRA_raw$geometry
)

#Ui
header <- dashboardHeader(
  title = "HealthWebMapper",
  titleWidth = 300,
  tags$li(class="dropdown", tags$a(href="http://humandynamics.sdsu.edu/", tags$img(src="logo_HDMA.png", heigh='250', width='300'), target ="_blank")),
  tags$li(class="dropdown", tags$a(href="https://humandynamics.sdsu.edu/demo-data.html", icon("table", "fa-3x"),"Demo Data", target ="_blank")),
  tags$li(class="dropdown", tags$a(href="https://github.com/HDMA-SDSU/HealthWebMapper2", icon("github", "fa-3x"), "Tutorial", target ="_blank"))
)

body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
    tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}")
  ),
  fluidRow(
    column(width = 2,
           box(width = NULL, status = "warning",
               fileInput("file1",
                         label = "Step 1: Upload cancer data",
                         accept = c("text/csv","text/comma-separated-values, text/plain",".csv")),
               fileInput("file2",
                         label = "Step 2: Upload socioeconomic data",
                         accept = c("text/csv","text/comma-separated-values, text/plain",".csv"))
               ),
           box(width = NULL,status = "warning",
               selectInput("VARL",label = "Step 3: Choose a case or rate", choices = c()),
               selectInput("VARR",label = "Step 4: Choose a socioeconomic factor", choices = c()),
               radioButtons('tool', label = "Step 5: Choose a tool", c('summary','correlation', 'autocorrelation(cancer)')),
               actionButton("add", label = "Add Analysis", icon = icon("refresh"))
               ),
           box(width = NULL,status = "warning", title = "Disclaimer",
               uiOutput("disclaimer")
              )
           ),
    column(width = 10,
           box(title="Maps", status = "primary", height = "480px", width=NULL,
               uiOutput(outputId = "map")
              ),
           tabBox(title="Data View", id= "tabset", height = "1000px", width= NULL,
                  tabPanel(title = "Analysis", icon = icon("bar-chart-o"),div(id = "placeholder")),
                  tabPanel(title = "Cancer Data Table",icon = icon("table"),DT::dataTableOutput(outputId = "table1") ),
                  tabPanel(title ="Socioeconomic Data Table",icon = icon("table"),DT::dataTableOutput(outputId = "table2"))
                  )          
           )
          )
)

ui <- dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
  #skin = "red"
)

# Server
server <- function(input, output, session) {

  # two reactive objects of inputfiles
  fileinputs1 <- reactive(
    {
      req(input$file1)
      read.csv(input$file1$datapath,
               header = TRUE)
    }
  )
  
  fileinputs2 <- reactive(
    {
      req(input$file2)      
      read.csv(input$file2$datapath,
               header = TRUE)
    }
  )
  
  # join two input tables by SRAID 
  data_sf <- reactive({
    st_as_sf(left_join(left_join(sd_sra, fileinputs1(), by = 'SRAID'),left_join(sd_sra, fileinputs2(), by = 'SRAID'), by = 'SRAID'))
  }
  )
    
  
  # update SelectInput with reactive objects
  observe({
    #update left selection
    updateSelectInput(session, "VARL", choices = names(fileinputs1()), selected = "SRAID")
    #update right selection
    updateSelectInput(session, "VARR", choices = names(fileinputs2()), selected = "SRAID")
  })


  #Output side-by-side choropleth maps
  
  output$map <- renderUI({  
    
	tm <- tm_basemap(c("Stamen.TonerLite","OpenStreetMap", "Esri.WorldImagery"))+
          tm_shape(data_sf()) + tm_polygons(c(input$VARL, input$VARR), alpha = 0.7) + tm_facets(sync = TRUE, ncol = 2) +
          tm_tiles(leaflet::providers$Stamen.TonerLabels) +
          tm_shape(freeways)+tm_lines("grey", lwd = 3)+
          tm_shape(hospitals)+tm_dots(col = "red", shape = 3)
    
	tmap_leaflet(tm)
    
      
   })
  
  
  observeEvent(input$add, {
    id <- paste0(input$tool, input$add)
    
    insertUI(selector = "#placeholder",
             where = "afterEnd",
             ui = switch(input$tool,
                'summary' = verbatimTextOutput(id),
                'correlation' = plotOutput(id),
                'autocorrelation(cancer)' = plotOutput(id)
                )
             )

    dataset <- as.data.frame(data_sf())
    # preprocess data for correlation computation
    subset <- dataset[, c(input$VARL, input$VARR)]
    new_data <- subset[complete.cases(subset),]
    # preprocess data for autocorrelation computation
    subset1 <- dataset[, c(input$VARL, "geometry.x", "geometry.y")]
    new_data1 <- st_as_sf(na.omit(subset1))
    new_data2 <- as.data.frame(new_data1)
    
    output[[id]] <-
      if (input$tool == 'correlation') renderPlot({
        tryCatch(
          {
            cor <- cor.test(new_data[,1], new_data[,2], method = "pearson", conf.level = 0.95)
          },
          error = function(e){
            stop(safeError("Check if the values of your selected variables are both numeric"))
          }
        )
        ggplot(isolate(new_data), aes_string(x=names(new_data)[1], y=names(new_data)[2])) + geom_point() + geom_smooth(method="lm")+ ggtitle(paste0("The correlation(Pearson's r) between ",isolate(input$VARL)," and ",isolate(input$VARR)," is ",isolate(cor[4])))

      })
      else if (input$tool == 'summary') renderPrint({summary(dataset)})
      else if (input$tool == 'autocorrelation(cancer)') renderPlot({
        # autocorrelation
        tryCatch(
          {
            isolate(new_data1)
            isolate(new_data2)
            nb <- poly2nb(new_data1, queen=TRUE)
          #assign weights to each neighboring polygon. In our case, each neighboring polygon will be assigned equal weight (style="W"). 
            lw <- nb2listw(nb, style="W", zero.policy=F)
          },
          error = function(e) {
            # return a safeErrorif too many missing data cause empty neighbor found
            stop(safeError("Unable to perform spatial autocorrelation analysis when there are too many missing data in the input cancer dataset because empty neighbour sets found"))
          }
        )
 
        #compute the average neighbor varibale value for each polygon. These values are often referred to as spatially lagged values.
        Inc.lag <- lag.listw(lw, new_data2[,1])
        # Create a regression model
        M <- lm(Inc.lag ~ new_data2[,1])
        MC<- moran.mc(new_data2[,1], lw, nsim=599)
        # Plot the data
        attach(mtcars)
        par(mfrow=c(1,2))
        plot(Inc.lag~ new_data2[,1], pch=20, asp=1, las=1, xlab= names(new_data2[1]), ylab= paste0("neighboring (mean) ",names(new_data2[1])), main= paste0("Moran's I coefficient for ", dataset$CONDITION[1]," ", dataset$OUTCOME[1], " ",names(new_data2[1]), " = ", coef(M)[2]), sub="")
        abline(lm(Inc.lag ~ new_data2[,1]), col="red")
        plot(MC, main= "Monte-Carlo simulation of Moran I", las=1,xlab= names(new_data2[1]))

        })
})

  # render table1
  output$table1 <- DT::renderDataTable(DT::datatable({
    fileinputs1()
  }))
  
  # render table1  
  output$table2 <- DT::renderDataTable(DT::datatable({
    fileinputs2()
  }))
  
  # Disclaimer
  output$disclaimer <- renderUI(
    {
      div(      
      p("*Rates per 100,000 population"),
      p("*County age-adjusted rates per 100,000 (2000 US standard population)"),
      p("*Pearson's r ranges from -1 to 1. The higher the absolute value of Pearson's r is, the stronger the correlation between two variables. However,correlation is not the same as causation."),
      p("*Please interpret with these results with caution - correlation, is not the same as causation. This tool visualizes patterns that can be used for exploratory analysis and hypothesis testing in order to form more complex and realistic models of cancer mortality, but should not alone be interpreted as a valid tool for prediction of cancer outcomes."),
      p("*Moran's I ranges from -1 to 1. -1 is perfect clustering of dissimilar values (perfect dispersion). 0 is perfect randomness. 1 indicates perfect clustering of similar values."),
      p("*In this tool, we accepct any contiguous polygon that shares at least on vertex and assign equal weight to each neighboring polygon and compute the average neighboring value"),
      p("*In a Monte Carlo test, the attribute values are randomly assigned to polygons in the dataset and for each permutation of the attribute values, a Moran's I value is computed. The ouput is a sampling distribution of Moran's I values under the null hypothesis that attribute values are randomly distributed across the study area.")
      )

      
    }
  )
}

# Run the application 
shinyApp(ui = ui, server = server)

