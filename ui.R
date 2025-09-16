

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Application Allociné"),

    # Barre latérale avec un bouton de choix du genre
    sidebarLayout(
        sidebarPanel(
           
          selectInput("choix_genre", "Choix du genre : ", 
          choices = c("Tous les genres", unique(data_allocine$genre)))
          
          
        ),

        # Afficher le graphique d'évolution du nombre de films par an
        mainPanel(
            plotOutput("plot_evolution")
        )
    )
)
