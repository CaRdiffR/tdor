server <- function(input, output) { 
  
  
  #renderWidgetframe
  #renderPlot
  output$map <- renderLeaflet({
    if(input$selectCountry=="All"){
      data=tdor
      names(data)=gsub(" ",".",names(tdor))
      data=subset(data,Date >= input$selectDate[1] & Date <=input$selectDate[2])
      data$photoURL=paste("https://bytebucket.org/annajayne/tdor_data/raw/default/Data/TDoR%20",data$Year,"/photos/",data$Photo,sep="")
      
    }else{
      data=subset(tdor,Country==input$selectCountry)
      names(data)=gsub(" ",".",names(tdor))
      data=subset(data,Date >= input$selectDate[1] & Date <=input$selectDate[2])
      data$photoURL=paste("https://bytebucket.org/annajayne/tdor_data/raw/default/Data/TDoR%20",data$Year,"/photos/",data$Photo,sep="")
    }
    
    # plot <- suppressWarnings(
    #           figure(
    #                 width = 800, height = 450,
    #                 padding_factor = 0) %>%
    #                 ly_map("world", col = "gray") %>%
    #                 ly_points(Longitude, Latitude, data = data, size = 5,
    #                 hover = c(Name, Age,Date,Location,Cause.of.death )))
    # plot
    
    
    
    ## add images 
    ## https://github.com/CaRdiffR/tdor/issues/3
    
    
    p <- leaflet(data =data) %>% 
      addProviderTiles(providers$CartoDB.Positron) %>% 
      addMarkers(~Longitude, ~Latitude,
                 popup=paste(
                   "<a href = ",data$Permalink,">", data$Name,"</a> <br>",
                   "Age ", data$Age, "<br>",
                   data$Date, "<br>",
                   data$Location, "<br>",
                   data$Cause.of.death, "<br>",
                   "<img src = ",
                   data$photoURL,
                   " width=75% ",
                   ">", ## will display an icon if no photo
                   
                   sep="")
      )
    p
    
    
  })
  
  output$overTime <- renderPlot({
    
    ggplot(tdor, aes(Year)) + geom_bar() +
      ggtitle("Deaths by year")
    
  })
  
  output$byAge <- renderPlot({
    tdor %>% 
      filter(Age_min > 0 & Age_max > 0) %>%
      ggplot(aes(x = (Age_min + Age_max)/2)) + 
      geom_bar() +
      ggtitle("Deaths by age") +
      labs(y = "Deaths")
  })
  
  output$byAge2<- renderPlot({
    tdor %>% 
      filter(Age_min > 0 & Age_max > 0) %>%
      ggplot(aes(x = (Age_min + Age_max)/2)) +
      geom_histogram(binwidth = 5) +
      ggtitle("Deaths by age") +
      labs(y = "Deaths")
  })
  
  output$top10 <- renderPlot({
    tdor %>%
      group_by(Country) %>%
      summarise(n = n()) %>%
      arrange(desc(n)) -> by_country
    ggplot(by_country[1:10,],
           aes(x = Country,
               y = n)) +
      theme_bw() +
      labs(y = "Deaths", x = "") +
      geom_bar(stat="identity") +
      theme(axis.text.x = element_text(angle=45, hjust=1)) +
      ggtitle("Ten countries with the most reported deaths")
    
  })
  
  
  
} ## end server
