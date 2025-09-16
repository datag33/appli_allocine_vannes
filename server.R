
library(shiny)


function(input, output, session) {

    output$plot_evolution <- renderPlot({

      
        # Graphique sur l'évolution du nombre de films par an (sur un genre donné)
      
      if (input$choix_genre != "Tous les genres") {
        data_allocine_plot <- data_allocine %>% 
          filter(genre == input$choix_genre)  # Filtrer sur le genre choisi par l'utilisateur
      }
      
      else { 
          data_allocine_plot <- data_allocine  # Pas de filtre si "tous les genres" choisis
      }

      data_allocine_plot %>% 
        mutate(annee_sortie = year(date_sortie)) %>% 
        count(annee_sortie) %>% 
        ggplot() + 
        geom_line(aes(x = annee_sortie, y = n)) +
        labs(title = "Evolution du nombre de films par an", 
             subtitle = paste("Genre choisi :",input$choix_genre))
      
    })

}
