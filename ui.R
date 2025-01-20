#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(
 
    # Application title
    titlePanel("Welcome!"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        textInput("nom", "Quel est votre nom ?"),
        textInput("prenom", "Quel est votre prenom?"),
        textOutput("salutation"),
        textOutput("Prenom"),
        
        h3("Documentation"),
        p("Utilisez cette application pour explorer les débits du Nile entre les années 1871 et 1970. Avec le curseur choisissez
          votre intervalle d'années et visisonnez les analyses correspondantes "),
        
        sliderInput("year_range", 
                    "Sélectionnez la plage d'années :", 
                    min = 1871, max = 1970, value = c(1871, 1970), step = 1),
        h3("Statistiques clés :"),
        textOutput(outputId = "key_stats"),
    ),
    mainPanel(
      h3("Une image du Nile"),
      tags$img(src = "image_nile.png", alt = "Alternative text", height = "300px", width = "400px"),
      
      h3("Resumé des données du Nile:"),
      verbatimTextOutput(outputId = "summary_output"),
      
      h3("Evolution du Débit par année"),
      plotOutput(outputId = "graphe_Nile")
  )
)
)

