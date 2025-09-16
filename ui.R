

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
fluidPage(
  theme = shinytheme("lumen"),
   #themeSelector(), # CHoix du theme (pour tester un thème)
  # Pour un thème plus personnalisé, utiliser le package bslib
  
  navbarPage("Application Allociné",  # Structure avec barre de navigation
             
             # Logo allociné
             img(src = "logo_allocine.jpeg", height = "100x"),
             
             tabPanel("Page principale",  # Page principal
                      
               
                      # Barre latérale avec un bouton de choix du genre
                      sidebarLayout(
                        sidebarPanel(
                          
                          selectInput("choix_genre", "Choix du genre : ", 
                                      choices = c("Tous les genres", unique(data_allocine$genre))
                          ),
                          checkboxInput("choix_reprise", "Inclure les films repris"),
                          actionButton("go", "Valider")
                          
                          
                        ),
                        
                        # Afficher le graphique d'évolution du nombre de films par an
                        mainPanel(
                          tabsetPanel(
                            tabPanel("Graphique", plotOutput("plot_evolution")),
                            tabPanel("Tableau", tableOutput("table_evolution"))
                          )
                        )
                      )
             ),
             tabPanel("A propos",  # Page secondaire
                      "Ceci est une application d'exemple basée sur les données", strong("Allociné")
             )
             
  )
)

