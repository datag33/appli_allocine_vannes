
library(shiny)



function(input, output, session) {

    # Fonction réactive "intermédiaire" pour la sélection du périmètre choisi par l'utilisateur
     # Eventreactive : déclenchement seulement au clic sur boutton
  perimetre <- eventReactive(input$go, {
    
    
    if (input$choix_genre != "Tous les genres") {
      data_allocine_plot <- data_allocine %>% 
        filter(genre == input$choix_genre)  # Filtrer sur le genre choisi par l'utilisateur
    }
    
    else { 
      data_allocine_plot <- data_allocine  # Pas de filtre si "tous les genres" choisis
    }
    
    if (input$choix_reprise == FALSE) {           # Exclure les films repris si la boite est cochée
      data_allocine_plot <- data_allocine_plot %>% 
        filter(reprise != TRUE)
    }
    
    return(data_allocine_plot)
    
  })
  
    # output$plot_evolution <- renderPlotly({
    # 
    #  
    #   (perimetre() %>% # On repart de la fonction réactive de périmètre
    #     mutate(annee_sortie = year(date_sortie)) %>% 
    #     count(annee_sortie) %>% 
    #     ggplot() + 
    #     geom_line(aes(x = annee_sortie, y = n)) +
    #     labs(title = "Evolution du nombre de films par an", 
    #          subtitle = paste("Genre choisi :",input$choix_genre))
    #   ) %>% 
    #     ggplotly() # COnversion en graphique intéractif plotly
    #   
    # })
    
    output$plot_evolution <- renderGirafe({
      
      
      plot_evo <- perimetre() %>% # On repart de la fonction réactive de périmètre
         mutate(annee_sortie = year(date_sortie)) %>% 
         count(annee_sortie) %>% 
         ggplot(aes(tooltip =  n)) + # Bug à corriger...
         geom_line_interactive(aes(
           x = annee_sortie, 
           y = n
           )) +
         labs(title = "Evolution du nombre de films par an", 
              subtitle = paste("Genre choisi :",input$choix_genre))
    
       girafe(gg = plot_evo)
    
    
    })
    
    
    

    output$table_evolution <- renderUI({
      

      perimetre() %>%  # On repart de la fonction réactive de périmètre
        mutate(annee_sortie = year(date_sortie)) %>% 
        count(annee_sortie) %>% 
        kbl() %>%  # Transformation en tableau HTML %>% 
        HTML()
      
    })
    
    # Fonction observe sur déclenchement pour prévenir l'utilisateur du périmètre choisi
    observeEvent(input$go,{
      
      showNotification("Affichage des données sur", input$choix_genre)
      
    })

}



