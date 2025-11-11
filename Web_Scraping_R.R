# Installation et chargement des packages 
options(warn = -1)
install.packages("rvest", quiet = TRUE)
install.packages("ggplot2", quiet = TRUE)
install.packages("dplyr", quiet = TRUE)

cat("\n******************************\n")
cat("   Installation des packages\n")
cat("******************************\n")
cat("\nLes packages suivants ont été installés avec succès :\n")
cat(" - rvest\n")
cat(" - ggplot2\n")
cat(" - dplyr\n")
cat("\nL'installation est terminée avec succès !\n")
cat("--------------------------------\n")

library(rvest)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)

# URL de la page utilisee pour le 'scraping'
url <- "https://www.basketball-reference.com/leagues/NBA_2023_per_game.html"

# lecture de la page HTML
page <- read_html(url)

# Extraire le tableau des statistiques des joueurs
players_stats <- page %>%
  html_node("table") %>%          
  html_table(fill = TRUE)

# Filtrer les données pour exclure les équipes "2TM"
players_stats <- players_stats %>%
  filter(Team != "2TM")

cat("\n\n**************************\n")
cat("Données collectées : \n")
cat("Les données ont été extraites du site Basketball Reference (https://www.basketball-reference.com/)\n")
cat("et contiennent les statistiques des joueurs NBA pour la saison 2023, telles que les points, les\n")
cat("passes décisives, les rebonds, et plus encore.\n")
cat("**************************\n\n")
cat("\n====================================\n")
cat("Remarque sur les Données : Pas de Nettoyage Nécessaire\n")
cat("====================================\n")
cat("Les données extraites du site Basketball Reference pour la saison 2023 sont déjà triées et\n")
cat("complètes. Il n'est donc pas nécessaire d'effectuer des étapes de nettoyage supplémentaires\n")
cat("avant de procéder à l'analyse et à la visualisation. Toutes les informations sont prêtes à l'emploi.\n")
cat("\n")

#players_stats
cat("\n******************************\n")
cat("  Aperçu des premières lignes des données des joueurs NBA\n")
cat("******************************\n")
cat("\nVoici un aperçu des premières lignes du dataframe 'players_stats' :\n")
head(players_stats)
#str(players_stats)

# la sauvgarde des données dans un fichier CSV
write.csv(players_stats, "nba_players_stats_raw_2023.csv", row.names = FALSE)
cat("\nLes données brutes des joueurs NBA pour la saison 2023 ont été sauvegardées dans 'nba_players_stats_raw_2023.csv'.\n")


cat("\n******************************\n")
cat("  Début de la visualisation des données\n")
cat("******************************\n")
cat("\nNous allons maintenant passer à la phase de visualisation des données.\n")
cat("Cette étape consiste à explorer graphiquement les statistiques des joueurs NBA\n")
cat("pour mieux comprendre leurs performances durant la saison 2023.\n")
cat("\nPréparez-vous à découvrir des graphiques informatifs et intéressants !\n\n")

# affichage des 10 meilleurs joueurs par points ( analyse basique ! )
top_scorers <- players_stats %>%
  arrange(desc(as.numeric(PTS))) %>%  
  head(10)  
cat("Nous allonz commencer par une petite analyse sur la forme d'un tableau.\n")
cat("Les 10 meilleurs marqueurs de la saison NBA 2023 sont :")
print(top_scorers[, c("Player", "Team", "PTS")])


cat("\n====================================\n")
cat("Visualisation 1 : Distribution des Points par Match\n")
cat("====================================\n")
cat("Pour débuter l'analyse des statistiques NBA, nous examinons la distribution des points marqués\n")
cat("par match par les joueurs. Cette visualisation permet de voir combien de joueurs atteignent\n")
cat("des niveaux spécifiques de performance en termes de points. Cela nous aidera à identifier les\n")
cat("tendances générales et les joueurs exceptionnellement performants.\n")
cat("\n")

# Histogramme : Distribution des points marqués par match
ggplot(players_stats, aes(x = PTS)) +
  geom_histogram(binwidth = 2, fill = "blue", color = "white") +
  labs(title = "Distribution des points par match",
       x = "Points par match",
       y = "Nombre de joueurs")


cat("\n====================================\n")
cat("Visualisation 2 : Moyenne de Points par Position\n")
cat("====================================\n")
cat("Dans cette visualisation, nous analysons la moyenne des points marqués par les joueurs selon\n")
cat("leur position sur le terrain (ex : meneur, pivot, etc.). Cela nous permet de comprendre l'impact\n")
cat("typique de chaque rôle dans le jeu et d'identifier les positions les plus offensives.\n")
cat("Les positions sont affichées en tant que barres, avec leur hauteur représentant les points moyens.\n")
cat("\n")

#Diagramme en barres : Moyenne de points par position
players_stats %>%
  group_by(Pos) %>%
  summarise(AvgPoints = mean(PTS, na.rm = TRUE)) %>%
  ggplot(aes(x = Pos, y = AvgPoints, fill = Pos)) +
  geom_bar(stat = "identity") +
  labs(title = "Moyenne des points par position",
       x = "Position",
       y = "Points moyens") +
  theme_minimal()





cat("\n====================================\n")
cat("Visualisation 4 : Répartition des Points par Équipe\n")
cat("====================================\n")
cat("Dans cette visualisation, nous analysons la répartition des points marqués par les joueurs\n")
cat("de chaque équipe. Ce graphique permet de comprendre les performances des différentes équipes\n")
cat("en termes de points marqués. Chaque équipe est représentée par une barre, et la hauteur de chaque\n")
cat("barre représente la somme totale des points marqués par les joueurs de cette équipe. Cela nous aide\n")
cat("à identifier les équipes les plus performantes offensivement dans la saison.\n")
cat("\n")

players_stats %>%
  group_by(Team) %>%
  summarise(TotalPoints = sum(PTS, na.rm = TRUE)) %>%
  ggplot(aes(x = Team, y = TotalPoints, fill = Team)) +
  geom_bar(stat = "identity") +
  labs(title = "Contribution des joueurs par équipe",
       x = "Équipe",
       y = "Points totaux") +
  theme_minimal()+
  theme(axis.text.x = element_blank())



cat("\n====================================\n")
cat("Visualisation 5 : Corrélation entre les Passes Décisives et les Points\n")
cat("====================================\n")
cat("Dans cette visualisation, nous explorons la relation entre les passes décisives et les points\n")
cat("marqués par les joueurs. Chaque point représente un joueur, avec les passes décisives en abscisse\n")
cat("et les points en ordonnée. Ce graphique nous permet d'observer si une corrélation existe entre\n")
cat("les deux variables et d'identifier les joueurs qui se distinguent dans l'une ou l'autre catégorie.\n")
cat("\n")

# Scatterplot : Corrélation entre les passes décisives et les points
ggplot(players_stats, aes(x = AST, y = PTS)) +
  geom_point(color = "red") +
  labs(title = "Corrélation entre les passes et les points",
       x = "Passes décisives par match",
       y = "Points par match") +
  theme_minimal()

ggplot(players_stats, aes(x = PTS, y = AST)) +
  geom_point(aes(color = Team), alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +  # Ligne de régression
  labs(title = "Relation entre Points et Passes Décisives des Joueurs NBA (2023)",
       x = "Points Marqués par Match", y = "Passes Décisives par Match") +
  theme_minimal() +
  theme(legend.position = "bottom")



cat("\n====================================\n")
cat("Visualisation 6 : Répartition des Rebonds par Équipe\n")
cat("====================================\n")
cat("Cette visualisation examine la répartition des rebonds par équipe à l'aide d'un boxplot.\n")
cat("Chaque boîte représente la variation des rebonds pour les joueurs d'une même équipe.\n")
cat("Cela nous permet d'identifier les équipes avec des performances homogènes ou des joueurs\n")
cat("exceptionnels en termes de rebonds. Les valeurs extrêmes (outliers) sont également mises en évidence.\n")
cat("\n")

#Boxplot : Comparaison des rebonds par équipe
ggplot(players_stats, aes(x = Team, y = TRB)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Répartition des rebonds par équipe",
       x = "Équipe",
       y = "Rebonds par match") +
  theme(axis.text.x = element_text(angle = 90))



cat("\n====================================\n")
cat("Visualisation 7 : Nombre de Récompenses par Joueur\n")
cat("====================================\n")
cat("Dans cette visualisation, nous comptons le nombre de récompenses que chaque joueur NBA a reçues\n")
cat("pour la saison 2023. Les joueurs ayant plusieurs récompenses apparaîtront avec des barres plus hautes.\n")
cat("Les récompenses sont extraites de la colonne 'Awards' et comptées, chaque joueur étant affiché\n")
cat("avec le nombre total de récompenses obtenues.\n")
cat("\n")

player_awards_count <- players_stats %>%
  filter(!is.na(Awards) & Awards != "") %>%  
  separate_rows(Awards, sep = ",") %>%  
  mutate(Awards = sub("-.*", "", Awards)) %>% # Extraire uniquement la récompense avant le tiret
  group_by(Player) %>%
  summarize(Number_of_Awards = n())  # Compter le nombre de récompenses pour chaque joueur

# Histogramme : nombre de récompenses par joueur
ggplot(player_awards_count, aes(x = reorder(Player, -Number_of_Awards), y = Number_of_Awards)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Nombre de Récompenses par Joueur NBA (2023)",
       x = "Joueur", y = "Nombre de Récompenses") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))



library(ggplot2)
library(dplyr)
cat("\n====================================\n")
cat("Visualisation 8 : Comparaison des Statistiques de Défense et d'Attaque\n")
cat("====================================\n")
cat("Dans cette visualisation, nous comparons les statistiques de défense (vols, blocs, rebonds défensifs)\n")
cat("et d'attaque (points, passes, rebonds offensifs) pour les joueurs ayant marqué plus de 25 points par match.\n")
cat("Les joueurs ayant un score élevé sont affichés avec des barres plus hautes dans le graphique.\n")
cat("\n")

# Bar Chart : Attaque et defense des joueurs qui ont plus de 25 points par match 
players_above_25 <- players_stats %>%
  filter(PTS > 25) %>%  
  select(Player, PTS, AST, STL, BLK, TRB) %>%  
  gather(key = "Stat", value = "Value", -Player)  

ggplot(players_above_25, aes(x = Player, y = Value, fill = Stat)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Comparaison des Statistiques de Défense et d'Attaque pour les Joueurs \n                                 avec plus de 25 Points (2023)",
       x = "Joueur", y = "Valeur des Statistiques") +
  scale_fill_manual(values = c("orange", "black", "red", "purple", "blue")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))



cat("\n====================================\n")
cat("Visualisation 9 : Heatmap Normalisée des Moyennes par Position (Joueurs avec 60+ matchs)\n")
cat("====================================\n")
cat("Cette heatmap montre les moyennes des statistiques suivantes pour chaque position :\n")
cat("- Points, Passes Décisives, Rebonds, Contres, Vols, Ballons Perdus (TOV), Fautes Personnelles (PF).\n")
cat("Nous avons filtré les joueurs ayant joué au moins 60 matchs pour garantir que les statistiques sont significatives.\n")
cat("- Chaque statistique est normalisée (0 à 1) pour permettre une comparaison équitable.\n")
cat("- Les couleurs varient de rose clair (faible contribution) à rouge foncé (forte contribution).\n")
cat("Cela permet de mettre en évidence les forces et faiblesses relatives des positions, en excluant les joueurs ayant peu joué.\n")

# Heatmap: Moyennes de Statistiques par Position
players_stats_filtered <- players_stats %>%
  filter(G >= 60)
position_stats <- players_stats_filtered %>%
  group_by(Pos) %>%
  summarize(
    Points = mean(PTS, na.rm = TRUE),
    Assists = mean(AST, na.rm = TRUE),
    Rebounds = mean(DRB + ORB, na.rm = TRUE),
    Blocks = mean(BLK, na.rm = TRUE),
    Steals = mean(STL, na.rm = TRUE),
    Turnovers = mean(TOV, na.rm = TRUE),
    Fouls = mean(PF, na.rm = TRUE)
  )

# Normalisation des valeurs (0 à 1)
normalized_stats <- position_stats %>%
  pivot_longer(cols = -Pos, names_to = "Stat", values_to = "Value") %>%
  group_by(Stat) %>%
  mutate(Normalized_Value = (Value - min(Value)) / (max(Value) - min(Value)))

ggplot(normalized_stats, aes(x = Stat, y = Pos, fill = Normalized_Value)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "lightpink", high = "darkred") +
  labs(
    title = "Heatmap Normalisée des Moyennes par Position (Joueurs avec 60+ matchs)",
    x = "Statistique",
    y = "Position",
    fill = "Valeur Normalisée"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

cat("\n====================================\n")
cat("Visualisation Interactive des Performances NBA\n")
cat("====================================\n")
cat("Nous allons finir par une exploration des performances des joueurs NBA grâce à un graphique interactif.\n")
cat("Ce graphique permet de visualiser la relation entre les points marqués, les passes décisives,\n")
cat("et les rebonds. Les joueurs sont différenciés par leur position et leur taille de bulle indique\n")
cat("leur contribution en termes de rebonds. Vous pouvez interagir avec ce graphique pour examiner\n")
cat("les données de manière plus détaillée.\n")
cat("\n")

fig <- players_stats %>%
  plot_ly(x = ~PTS, y = ~AST, 
          type = "scatter", 
          mode = "markers",
          text = ~paste("Joueur :", Player, "<br>Équipe :", Team, "<br>Rebonds :", TRB),
          color = ~Pos,
          size = ~TRB) %>%
  layout(
    title = "Exploration des performances des joueurs NBA",
    xaxis = list(title = "Points par match"),
    yaxis = list(title = "Passes décisives par match"),
    hovermode = "closest"
  )

fig



cat("\n******************************\n")
cat("  Remarque sur mes choix dans le code\n")
cat("******************************\n")
cat("\nDans ce script, j'ai choisi d'utiliser `cat()` plutôt que `print()` car :\n")
cat(" - `cat()` permet d'afficher du texte de manière fluide.\n")
cat(" - Il est plus simple pour concaténer du texte et organiser les affichages avec des sauts de ligne (`\\n`).\n")
cat("\nJ'ai également utilisé des commentaires (avec `#`) pour expliquer chaque étape de mon code.\n")
cat("Cela permet :\n")
cat(" - D'aider les lecteurs à comprendre les différentes parties du programme.\n")
cat(" - D'identifier facilement les sections importantes ou potentiellement problématiques.\n")
cat("\nCes choix visent à rendre le code plus clair, lisible et maintenable.\n")


cat("\n************************************\n")
cat("Conclusion\n")
cat("************************************\n")
cat("Le projet a permis de collecter et d'analyser les statistiques des joueurs NBA pour la saison 2023.\n")
cat("Les visualisations montrent les meilleurs joueurs par points, la distribution des points, la répartition\n")
cat("des positions, et la relation entre les passes décisives et les points. Ces résultats permettent de\n")
cat("mieux comprendre les performances des joueurs.\n")
cat("\n")