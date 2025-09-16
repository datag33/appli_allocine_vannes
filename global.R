
# Script à lancer au moment de l'initialisation de l'application



### Packages
library(shiny)
library(readr) # Tidyverse : chargement fichiers plats
library(dplyr) # Tidyverse : traitement de données
library(readxl) # Tidyverse : impoortation fichier Excel
library(lubridate) # Tidyverse : dates 
library(ggplot2) # Tidyverse  : graphique

library(shiny) # Shiny
library(shinythemes) # Thèmes Shiny
library(plotly) # Graphiques intéractifs
library(ggiraph) # Graphiques intéractifs (syntaxe ggplot2)
library(kableExtra) # Tableau intéractif

### Importation

  # Importation fichier csv
  data_allocine <- read_csv2("Data/data_allocine.csv")
  
  # Importation fichier excel correspondances
  correspondances <- read_excel("Data/correspondances_allocine.xlsx") %>% 
    rename(nationalite = nationalité)

  
### Pré-traitements

data_allocine <- data_allocine %>% 
  left_join(correspondances, by = "nationalite") # Jointure gauche (on garde tous les films)
