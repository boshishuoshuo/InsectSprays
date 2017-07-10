
library(shiny)

shinyServer(function(input, output) {
        spray <- c('A', 'B', 'C', 'D', 'E', 'F')
        pvalue <- reactive({
                spray.input <- c(input$A, input$B, input$C, input$D,
                                 input$E, input$F)

                IS.subset <- subset(InsectSprays,
                                    InsectSprays$spray == spray[spray.input])

                if (length(spray[spray.input]) == 2) {
                        count.1 <- InsectSprays[InsectSprays$spray == spray[spray.input][1],
                                                'count']
                        count.2 <- InsectSprays[InsectSprays$spray == spray[spray.input][2],
                                                'count']
                        t.test(count.1, count.2)$p.value
                }
                else if (length(spray[spray.input]) == 1) {
                        "Only one spray."
                }
                else {
                        "More than two sprays."
                }
        })

        result <- reactive({
                spray.input <- c(input$A, input$B, input$C, input$D,
                                 input$E, input$F)

                IS.subset <- subset(InsectSprays,
                                    InsectSprays$spray == spray[spray.input])

                if (length(spray[spray.input]) == 2) {
                        count.1 <- InsectSprays[InsectSprays$spray == spray[spray.input][1],
                                                'count']
                        count.2 <- InsectSprays[InsectSprays$spray == spray[spray.input][2],
                                                'count']
                        p <- t.test(count.1, count.2)$p.value
                }
                else if (length(spray[spray.input]) == 1) {
                        p <- "Only 1 spray selected."
                }
                else {
                        p <- "More than 2 sprays selected."
                }
                if (is.character(p)) {
                        "Please select 2 sprays."
                }
                else if (p <= 0.05) {
                        paste(spray[spray.input][1], 'and', spray[spray.input][2],
                              'are significantly different.')
                }
                else {
                        paste(spray[spray.input][1], 'and', spray[spray.input][2],
                              'are NOT significantly different')
                }
        })

        output$plot1 <- renderPlot({
                library(ggplot2)
                spray.input <- c(input$A, input$B, input$C, input$D,
                                 input$E, input$F)
                IS.subset <- InsectSprays[InsectSprays$spray == spray[spray.input], ]
                g <- ggplot(IS.subset, aes(x = spray, y = count)) +
                        geom_boxplot(aes(color = spray))
                g
        })

        output$pvalue <- renderText({
                pvalue()
        })

        output$result <- renderText({
                result()
        })

})
