# 🏀 NBA 2023 Player Statistics — Web Scraping & Data Visualization

A data science project that collects, processes, and visualizes **NBA player statistics for the 2022–2023 season** using web scraping from [Basketball Reference](https://www.basketball-reference.com/).  
The project is implemented in both **Python** and **R**, delivering identical analyses through two separate scripts.

---


## 📖 Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Data Source](#data-source)
- [Technologies Used](#technologies-used)
- [Visualizations](#visualizations)
- [How to Run](#how-to-run)
- [Author](#author)

---

## 📌 Overview

The goal of this project is to:

1. **Scrape** per-game NBA player statistics for the 2023 season from Basketball Reference.
2. **Clean & prepare** the dataset for analysis (filtering out multi-team duplicate rows, etc.).
3. **Visualize** the data through a series of informative charts covering scoring distributions, team contributions, positional comparisons, and more.

> **Main file:** `notebook.ipynb` — a fully executed Jupyter Notebook that contains all code, explanations, and rendered visualizations.  
> The `Web_Scraping_Python.py` and `Web_Scraping_R.R` scripts contain the **same analysis** in standalone Python and R formats respectively.

---

## 📂 Project Structure

```
.
├── notebook.ipynb                  # Main notebook (Python) — primary deliverable
├── Web_Scraping_Python.py          # Standalone Python script (same analysis as the notebook)
├── Web_Scraping_R.R                # Standalone R script (same analysis as the notebook)
├── nba_players_stats_raw_2023.csv  # Output dataset — raw scraped player statistics
└── README.md                       # This file
```

---

## 🌐 Data Source

All data is scraped from:

**[Basketball Reference — 2022-23 NBA Per Game Stats](https://www.basketball-reference.com/leagues/NBA_2023_per_game.html)**

The dataset includes **530+ player records** with the following statistics per game:

| Column | Description |
|--------|-------------|
| `Rk` | Rank |
| `Player` | Player name |
| `Age` | Player age |
| `Team` | Team abbreviation |
| `Pos` | Position (PG, SG, SF, PF, C) |
| `G` | Games played |
| `GS` | Games started |
| `MP` | Minutes played per game |
| `FG`, `FGA`, `FG%` | Field goals made, attempted, and percentage |
| `3P`, `3PA`, `3P%` | Three-point field goals made, attempted, and percentage |
| `2P`, `2PA`, `2P%` | Two-point field goals made, attempted, and percentage |
| `eFG%` | Effective field goal percentage |
| `FT`, `FTA`, `FT%` | Free throws made, attempted, and percentage |
| `ORB`, `DRB`, `TRB` | Offensive, defensive, and total rebounds |
| `AST` | Assists |
| `STL` | Steals |
| `BLK` | Blocks |
| `TOV` | Turnovers |
| `PF` | Personal fouls |
| `PTS` | Points per game |
| `Awards` | Season awards (MVP voting, All-Star, All-NBA, etc.) |

---

## 🛠️ Technologies Used

### Python
| Library | Purpose |
|---------|---------|
| `requests` | HTTP requests for scraping |
| `BeautifulSoup` (bs4) | HTML parsing |
| `pandas` | Data manipulation and analysis |
| `matplotlib` | Static data visualizations |
| `seaborn` | Statistical data visualizations |
| `plotly` | Interactive visualizations |

### R
| Library | Purpose |
|---------|---------|
| `rvest` | Web scraping and HTML parsing |
| `ggplot2` | Data visualization |
| `dplyr` | Data manipulation |
| `plotly` | Interactive visualizations |

---

## 📊 Visualizations

The project includes the following visualizations (available in both the notebook and the scripts):

| # | Visualization | Description |
|---|--------------|-------------|
| 1 | **Points Distribution** | Histogram showing the distribution of points per game across all players |
| 2 | **Average Points by Position** | Pie chart of mean scoring output by position (PG, SG, SF, PF, C) |
| 3 | **Top 10 Scorers** | Bar chart ranking the top 10 highest-scoring players |
| 4 | **Team Contributions** | Total points by team — identifies the most offensively productive teams |
| 5 | **Assists vs. Points Correlation** | Scatter plot with regression line exploring the relationship between assists and scoring |
| 6 | **Rebounds by Team** | Box plot of rebounds per game distribution across all teams |
| 7 | **Player Awards** | Bar chart of the number of awards received by top players |
| 8 | **Offense vs. Defense Comparison** | Grouped bar chart comparing offensive and defensive stats for elite scorers (>25 PPG) |
| 9 | **Position Performance Heatmap** | Normalized heatmap of key statistics (PTS, AST, Rebounds, BLK, STL, TOV, PF) by position |
| 10 | **Interactive Explorer** | Plotly scatter plot to interactively explore player performance (PTS vs AST, sized by TRB, colored by position) |

---

## 🚀 How to Run

### Option 1 — Jupyter Notebook (Recommended)

```bash
# Install dependencies
pip install pandas matplotlib seaborn plotly beautifulsoup4 requests numpy

# Launch the notebook
jupyter notebook notebook.ipynb
```

### Option 2 — Python Script

```bash
# Install dependencies
pip install pandas matplotlib seaborn plotly beautifulsoup4 requests

# Run the script
python Web_Scraping_Python.py
```

### Option 3 — R Script

```r
# Open Web_Scraping_R.R in RStudio and run it.
# Required packages (rvest, ggplot2, dplyr, plotly) will be installed automatically by the script.
```

> **Note:** An active internet connection is required to scrape live data from Basketball Reference. The scraped output is also saved as `nba_players_stats_raw_2023.csv` for offline analysis.

---

## 👤 Author

**Wissem Sahli**

---

*This project was created as a data analysis and web scraping exercise to explore and visualize NBA player performance for the 2022–2023 season.*
