#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define server logic required to draw a histogram
function(input, output, session) {
  output$salutation <- renderText({
    paste0("Bienvenue ",input$prenom," ", input$nom," ","sur l'application du Nile")
  })
  filtered_data <-reactive({
    # Utilisation du jeu de données Nile (par défaut dans R)
    Nile <- as.data.frame(Nile)
    Nile$annee <- seq(from = 1871, by = 1, length.out = nrow(Nile)) # Ajout de la colonne "annee"
    colnames(Nile) <- c("debit", "annee") # Renommage des colonnes pour plus de clarté
    Nile <- Nile[Nile$annee >= input$year_range[1] & Nile$annee <= input$year_range[2], ]
    return(Nile)
  })
  output$key_stats <- renderText({
    Nile <- filtered_data()
    paste0("Débit moyen : ", round(mean(Nile$debit), 2), " m^3/s",
            "; Minimum : ", min(Nile$debit), "m^3/s",
            "; Maximum : ", max(Nile$debit),"m^3/s")
  })

  output$summary_output <- renderPrint({
    summary(filtered_data())
  })
  output$graphe_Nile <- renderPlot({
  ggplot(filtered_data(), aes(x = annee, y = debit)) +
    geom_line(color = "#87CEFA") + 
    geom_point(color = "pink") + 
    labs(
      x = "Année",
      y = "Débit"
    ) +
    theme_minimal()
})

}
