# Installation and loading of packages
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
from bs4 import BeautifulSoup
import requests
import warnings
warnings.filterwarnings('ignore')


print("\n\n\n**************************\n")
print("Titre du projet : Projet de Scraping des Données NBA 2023\n")
print("Wissem Sahli\n")
print("**************************\n\n\n")

print("Introduction :\n")
print("Le projet consiste à extraire et analyser les statistiques des joueurs NBA pour la saison 2023 en\n")
print("utilisant le web scraping. Nous avons extrait des données depuis le site Basketball Reference pour\n")
print("en faire des visualisations significatives et comprendre les performances des joueurs durant cette\n")
print("saison. Nous avons utilisé les packages R tels que rvest pour le scraping, dplyr pour la manipulation\n")
print("des données et ggplot2 pour la création des visualisations.\n\n")


print("\n******************************")
print("   Installation des packages")
print("******************************")
print("\nLes packages suivants sont nécessaires :")
print(" - pandas")
print(" - matplotlib")
print(" - seaborn")
print(" - plotly")
print(" - beautifulsoup4")
print(" - requests")
print("\nSi vous ne les avez pas, installez-les avec: pip install pandas matplotlib seaborn plotly beautifulsoup4 requests")
print("--------------------------------")

# URL for scraping
url = "https://www.basketball-reference.com/leagues/NBA_2023_per_game.html"

# Read the HTML page
response = requests.get(url)
soup = BeautifulSoup(response.content, 'html.parser')

# Extract player statistics table
table = soup.find('table')
if table is None:
    raise ValueError("No table found on the webpage. Please check the URL or the webpage structure.")
try:
    players_stats = pd.read_html(str(table))[0]
except ValueError as e:
    raise ValueError("Failed to parse the table into a DataFrame. Please check the table structure.") from e

# Filter out rows with "2TM" in Team column
players_stats = players_stats[players_stats['Team'] != '2TM']
players_stats.to_csv("nba_players_stats_raw_2023.csv", index=False)
print("\nLes données brutes des joueurs NBA pour la saison 2023 ont été sauvegardées dans 'nba_players_stats_raw_2023.csv'.")

print("\n\n**************************")
print("Données collectées : ")
print("Les données ont été extraites du site Basketball Reference (https://www.basketball-reference.com/)")
print("et contiennent les statistiques des joueurs NBA pour la saison 2023, telles que les points, les")
print("passes décisives, les rebonds, et plus encore.")
print("**************************\n\n")
print("\n====================================")
print("Remarque sur les Données : Pas de Nettoyage Nécessaire")
print("====================================")
print("Les données extraites du site Basketball Reference pour la saison 2023 sont déjà triées et")
print("complètes. Il n'est donc pas nécessaire d'effectuer des étapes de nettoyage supplémentaires")
print("avant de procéder à l'analyse et à la visualisation. Toutes les informations sont prêtes à l'emploi.")
print("\n")

# Display first rows
print("\n******************************")
print("  Aperçu des premières lignes des données des joueurs NBA")
print("******************************")
print("\nVoici un aperçu des premières lignes du dataframe 'players_stats' :")
print(players_stats.head())

# Save data to CSV
players_stats.to_csv("nba_players_stats_raw_2023.csv", index=False)
print("\nLes données brutes des joueurs NBA pour la saison 2023 ont été sauvegardées dans 'nba_players_stats_raw_2023.csv'.")

print("\n******************************")
print("  Début de la visualisation des données")
print("******************************")
print("\nNous allons maintenant passer à la phase de visualisation des données.")
print("Cette étape consiste à explorer graphiquement les statistiques des joueurs NBA")
print("pour mieux comprendre leurs performances durant la saison 2023.")
print("\nPréparez-vous à découvrir des graphiques informatifs et intéressants !\n\n")

# Display top 10 scorers
top_scorers = players_stats.sort_values('PTS', ascending=False).head(10)
print("Nous allons commencer par une petite analyse sur la forme d'un tableau.")
print("Les 10 meilleurs marqueurs de la saison NBA 2023 sont :")
print(top_scorers[['Player', 'Team', 'PTS']])




# Visualization 1: Points distribution
print("\n====================================")
print("Visualisation 1 : Distribution des Points par Match")
print("====================================")
plt.figure(figsize=(10, 6))
sns.histplot(data=players_stats, x='PTS', bins=20, color='blue')
plt.title("Distribution des points par match")
plt.xlabel("Points par match")
plt.ylabel("Nombre de joueurs")
plt.show()

# Visualization 2: Average points by position
print("\n====================================")
print("Visualisation 2 : Moyenne de Points par Position")
print("====================================")
avg_points = players_stats.groupby('Pos')['PTS'].mean().reset_index()
plt.figure(figsize=(10, 6))
sns.barplot(data=avg_points, x='Pos', y='PTS', palette='viridis')
plt.title("Moyenne des points par position")
plt.xlabel("Position")
plt.ylabel("Points moyens")
plt.show()

# Visualization 4: Points by team
print("\n====================================")
print("Visualisation 4 : Répartition des Points par Équipe")
print("====================================")
team_points = players_stats.groupby('Team')['PTS'].sum().reset_index()
plt.figure(figsize=(12, 6))
sns.barplot(data=team_points, x='Team', y='PTS', palette='tab20')
plt.title("Contribution des joueurs par équipe")
plt.xlabel("Équipe")
plt.ylabel("Points totaux")
plt.xticks([])
plt.show()

# Visualization 5: Correlation between assists and points
print("\n====================================")
print("Visualisation 5 : Corrélation entre les Passes Décisives et les Points")
print("====================================")
plt.figure(figsize=(10, 6))
sns.scatterplot(data=players_stats, x='AST', y='PTS', color='red')
plt.title("Corrélation entre les passes et les points")
plt.xlabel("Passes décisives par match")
plt.ylabel("Points par match")
plt.show()

# Another version with regression line
plt.figure(figsize=(10, 6))
sns.regplot(data=players_stats, x='PTS', y='AST', scatter_kws={'alpha':0.5})
plt.title("Relation entre Points et Passes Décisives des Joueurs NBA (2023)")
plt.xlabel("Points Marqués par Match")
plt.ylabel("Passes Décisives par Match")
plt.show()

# Visualization 6: Rebounds by team
print("\n====================================")
print("Visualisation 6 : Répartition des Rebonds par Équipe")
print("====================================")
plt.figure(figsize=(12, 6))
sns.boxplot(data=players_stats, x='Team', y='TRB', palette='pastel')
plt.title("Répartition des rebonds par équipe")
plt.xlabel("Équipe")
plt.ylabel("Rebonds par match")
plt.xticks(rotation=90)
plt.show()

# Visualization 7: Awards count (Note: Awards column might not exist in the scraped data)
print("\n====================================")
print("Visualisation 7 : Nombre de Récompenses par Joueur")
print("====================================")
print("Note: Cette visualisation nécessite une colonne 'Awards' qui pourrait ne pas être présente dans les données scrapées.")
print("Nous allons donc simuler des données de récompenses pour cette visualisation.")

# Simulating awards data for demonstration
import numpy as np
np.random.seed(42)
players_stats['Awards'] = np.random.choice(['All-Star', 'MVP', 'DPOY', 'ROY', '6MOTY', ''], 
                                         size=len(players_stats), 
                                         p=[0.05, 0.01, 0.03, 0.02, 0.04, 0.85])

player_awards_count = players_stats[players_stats['Awards'] != ''].groupby('Player')['Awards'].count().reset_index()
player_awards_count.columns = ['Player', 'Number_of_Awards']
player_awards_count = player_awards_count.sort_values('Number_of_Awards', ascending=False).head(20)

plt.figure(figsize=(12, 6))
sns.barplot(data=player_awards_count, x='Player', y='Number_of_Awards', palette='coolwarm')
plt.title("Nombre de Récompenses par Joueur NBA (2023)")
plt.xlabel("Joueur")
plt.ylabel("Nombre de Récompenses")
plt.xticks(rotation=90)
plt.show()

# Visualization 8: Offense and defense comparison for players with >25 PPG
print("\n====================================")
print("Visualisation 8 : Comparaison des Statistiques de Défense et d'Attaque")
print("====================================")
players_above_25 = players_stats[players_stats['PTS'] > 25]
players_melted = players_above_25.melt(id_vars=['Player'], 
                                      value_vars=['PTS', 'AST', 'STL', 'BLK', 'TRB'],
                                      var_name='Stat', value_name='Value')

plt.figure(figsize=(12, 6))
sns.barplot(data=players_melted, x='Player', y='Value', hue='Stat', palette=['orange', 'black', 'red', 'purple', 'blue'])
plt.title("Comparaison des Statistiques de Défense et d'Attaque pour les Joueurs\n avec plus de 25 Points (2023)")
plt.xlabel("Joueur")
plt.ylabel("Valeur des Statistiques")
plt.xticks(rotation=90)
plt.legend(title='Statistique')
plt.show()

# Visualization 9: Heatmap of normalized stats by position (players with 60+ games)
print("\n====================================")
print("Visualisation 9 : Heatmap Normalisée des Moyennes par Position (Joueurs avec 60+ matchs)")
print("====================================")

# Filter players with 60+ games
players_stats_filtered = players_stats[players_stats['G'] >= 60]

# Calculate mean stats by position
position_stats = players_stats_filtered.groupby('Pos').agg({
    'PTS': 'mean',
    'AST': 'mean',
    'DRB': 'mean',
    'ORB': 'mean',
    'BLK': 'mean',
    'STL': 'mean',
    'TOV': 'mean',
    'PF': 'mean'
}).reset_index()

# Calculate total rebounds
position_stats['Rebounds'] = position_stats['DRB'] + position_stats['ORB']
position_stats.drop(['DRB', 'ORB'], axis=1, inplace=True)

# Normalize the data (0-1 scaling)
normalized_stats = position_stats.copy()
stats_to_normalize = ['PTS', 'AST', 'Rebounds', 'BLK', 'STL', 'TOV', 'PF']
normalized_stats[stats_to_normalize] = normalized_stats[stats_to_normalize].apply(
    lambda x: (x - x.min()) / (x.max() - x.min())
)

# Melt the data for proper heatmap format
melted_stats = normalized_stats.melt(id_vars=['Pos'], 
                                   value_vars=stats_to_normalize,
                                   var_name='Stat', 
                                   value_name='Normalized_Value')

# Create pivot table using the correct syntax
heatmap_data = melted_stats.pivot(index='Pos', columns='Stat', values='Normalized_Value')

# Create the heatmap
plt.figure(figsize=(12, 6))
sns.heatmap(data=heatmap_data, 
            cmap='Reds', 
            annot=True, 
            linewidths=.5,
            fmt='.2f')  # Format annotations to 2 decimal places

plt.title("Heatmap Normalisée des Moyennes par Position (Joueurs avec 60+ matchs)")
plt.xlabel("Statistique")
plt.ylabel("Position")
plt.tight_layout()  # Adjust layout to prevent label cutoff
plt.show()

# Interactive visualization
print("\n====================================")
print("Visualisation Interactive des Performances NBA")
print("====================================")
fig = px.scatter(players_stats, x='PTS', y='AST', size='TRB', color='Pos',
                 hover_data=['Player', 'Team', 'TRB'],
                 title="Exploration des performances des joueurs NBA")
fig.update_layout(xaxis_title="Points par match",
                 yaxis_title="Passes décisives par match")
fig.show()

print("\n******************************")
print("  Remarque sur mes choix dans le code")
print("******************************")
print("\nDans ce script, j'ai choisi d'utiliser print() avec des chaînes multilignes pour :")
print(" - Afficher du texte de manière fluide.")
print(" - Organiser les affichages avec des sauts de ligne.")
print("\nJ'ai également utilisé des commentaires pour expliquer chaque étape de mon code.")
print("Cela permet :")
print(" - D'aider les lecteurs à comprendre les différentes parties du programme.")
print(" - D'identifier facilement les sections importantes ou potentiellement problématiques.")
print("\nCes choix visent à rendre le code plus clair, lisible et maintenable.")

print("\n************************************")
print("Conclusion")
print("************************************")
print("Le projet a permis de collecter et d'analyser les statistiques des joueurs NBA pour la saison 2023.")
print("Les visualisations montrent les meilleurs joueurs par points, la distribution des points, la répartition")
print("des positions, et la relation entre les passes décisives et les points. Ces résultats permettent de")
print("mieux comprendre les performances des joueurs.")
print("\n")