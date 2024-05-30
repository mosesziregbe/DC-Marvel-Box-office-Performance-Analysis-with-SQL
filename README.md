# DC Marvel Box office Performance Analysis with SQL 🎬🍿

Welcome to a thrilling adventure through the world of superheroes, where data meets entertainment in an epic showdown! In this SQL-powered exploration, we embark on a journey into the box office realm of Marvel and DC superhero movies.

Join me as we uncover the secrets behind their cinematic success and dive deep into the data to reveal hidden insights.

Superheroes have captured the hearts of audiences worldwide, dominating the silver screen with their larger-than-life adventures. But beyond the spectacle lies a treasure trove of data waiting to be explored. Using the power of SQL, we’ll navigate through the vast landscape of box office numbers, unraveling the mysteries behind the triumphs and tribulations of our favorite heroes.

From the towering skyscrapers of New York City to the mythical realms of Asgard, every superhero saga has a story to tell. So buckle up and get ready for an exhilarating ride as we embark on our SQL adventure through the Marvel and DC cinematic universes. Let’s dive in and discover what lies beneath the surface of superhero box office success!

#### Data Source
The Dataset is a single spreadsheet in the CSV file format downloaded from Kaggle. The dataset comprises box office data and supplemental information for all theatrically released films adapted from Marvel Comics and DC Comics core superhero universes. TV specials and other projects that did not receive a wide theatrical release are not included.

#### Data Overview:
The dataset consisted of columns including:

- Film: The title of the film in the U.S. market.

- U.S. release date: The first day the film was available in theatres in the United States of America to the general public.

- Box office gross Domestic (U.S and Canada): The total gross earnings of the film in U.S. dollars in Hollywood’s domestic market (comprising the United States of America and Canada).

- Box office gross other territories: The total gross earnings of the film in U.S. dollars in Hollywood’s international market (comprising any countries the film released in except the USA and Canada).

- Box office gross Worldwide: The sum total gross earnings for all territories in U.S. dollars.

- Budget: The production budget for the movie in U.S. dollars.

- MCU: indicates whether the film is part of the Marvel cinematic universe. Recorded as a Boolean value, with TRUE indicating that the film is part of the MCU.

- Phase: States which phase of MCU this film belongs to (if not applicable NA is used).

- Distributor: The name of the film studio that distributed the movie within the United States.

- MPAA Rating: The Motion Picture Association of America age rating for the film.

- Length: The length of the U.S. theatrical cut of the film given in hours, minutes and seconds, rounded to the nearest minute.

- Minutes: The same as above but presented only in minutes.

- Franchise: Whether a film is based on a Marvel or DC comic/character

- Character family: The character grouping the protagonist(s) is typically perceived to be part of.

- Domestic %: The percentage of the world-wide gross made up by the domestic (U.S. and Canada) gross.

- Gross to Budget: The ratio of production budget to worldwide gross

- Rotten Tomatoes Critic Score: The average score from all professional critics on Rotten Tomatoes, the popular review aggregator website.

- Male/Female-led: This column records whether the film had a male or female lead, or whether women and men co-star roughly equally.

- Year: The calendar year the film was released theatrically in the USA.

- Inflation Adjusted Worldwide Gross: The worldwide gross adjusted for inflation, given in 2023 U.S. dollars. It is a useful metric for looking at the relative box office success of these pictures irrespective of when they released. Without this data point for comparison, more recent movies tend to look more successful than older films due to inflation.

- Inflation Adjusted Budget: Production budget adjusted for inflation

- 2.5x prod: The production budget multiplied by 2.5. This is a common rule of thumb for determining whether a theatrical release achieved profitability for the distributor after marketing costs and exhibitors have taken their cut.

- Break Even: Did the worldwide gross pass the rule of thumb for profitability?

#### Project Overview
This project aims to analyze box office performance within the superhero movie genre, focusing on Marvel and DC franchises, using SQL queries and advanced techniques like window functions to extract insights. It seeks to compare revenue, identify top-grossing movies, analyze profitability, and explore trends in MPAA ratings and character family performance. 

The objective is to provide valuable insights for stakeholders in the entertainment industry while demonstrating proficiency in SQL querying and data analysis.

#### Methodology
First, I cleaned and prepared the dataset for analysis, including handling missing values and formatting inconsistencies. I achieved the project objectives by developing a series of SQL queries that addressed a variety of question about the dataset. Each query was designed to extract specific insights and was accompanied by details explaining its purpose. 

I conducted a comparative analysis of box office performance between Marvel and DC superhero movies, examining average revenue, top-grossing movies, and distributor trends. I also utilized SQL functions and window functions to perform calculations, aggregations, and data manipulations.

Tool used: MySQL

#### Data Analysis
##### PartA: Basic SQL analysis
1. What is the average box office revenue for DC superhero movies compared to marvel superhero movies?
2. Which DC and Marvel superhero movie has the highest box office revenue respectively?
3. Which year had the highest total box office revenue for superhero movies?
4. Which movie has the highest worldwide box office gross, and what is its gross-to-budget ratio?
5. Which distributor has released the most successful (in terms of worldwide gross) superhero movies?
6. How many movies have a Rotten Tomatoes critic score above 80%?
7. What is the average domestic percentage (Domestic %) for male-led and female-led movies?
8. Which character family has the highest average worldwide gross?
9. What is the distribution of MPAA ratings among the movies?
10. How has the average budget and worldwide gross changed over the years?
11. Which movies have failed to break even (worldwide gross < 2.5 times production budget) in the past 5 years?
12. Which movie has the lowest Rotten Tomatoes critic score?
13. Which movie(s) achieved profitability according to the 2.5x production budget rule for profitability, but still had a relatively low Rotten Tomatoes critic score?
14. How does the average gross to budget ratio vary across different MPAA ratings?
15. Which Marvel movie had the highest Rotten Tomatoes critic score?
16. What is the distribution of MPAA ratings among DC movies?
17. How does the average inflation-adjusted worldwide gross vary across different phases of the Marvel Cinematic Universe?
18. Which character family has the highest average gross to budget ratio?
19. What is the total number of male-led and female-led movies in the dataset?
20. What is the average length of Marvel movies vs DC movies?

Click here to see the solutions to Part A.

----------

##### PartB : SQL analysis using Windows function and CTE
1. How does the recent performance of movies within each character family compare in terms of worldwide gross rankings?
2. Calculate the running total of worldwide gross for each distributor, ordered by release year.
3. Find the movies whose worldwide gross is more than 1.5 times the average worldwide gross for their respective character family.
4. Retrieve the top 3 movies with the highest worldwide gross for each year, along with their rank within that year.
5. Calculate the percentage contribution of each movie's domestic gross to its distributor's total domestic gross.
6. Find the movies whose worldwide gross is more than the average worldwide gross of all movies released in the same year yet the movies were still a flop.
7. Retrieve the movies whose worldwide gross is in the top 25% for their respective MPAA rating.
8. Which DC movies have been a success for the past 7 years?    
9. Identify the movies that have the highest and lowest gross-to-budget ratio for each distributor.
10. Are both venom movies a success?
11. Retrieve the movies that have a higher worldwide gross than all the movies released in the previous year by the same distributor.
12. What is the cumulative box office gross worldwide for each distributor over the years?
13. Can you identify the movie with the highest box office gross worldwide for each MPAA rating category?
14. Calculate the average box office gross worldwide for each year, and also include the average gross for the previous year in the same row.
15. Rank the movies based on their profitability (gross to budget ratio) within each distributor.
16. Identify the top 5 movies with the highest inflation-adjusted worldwide gross for each character family.

Click here to see the solutions to Part B

[Click here[(https://app.powerbi.com/view?r=eyJrIjoiMzY2YjJhYWMtNWY5Mi00NmYxLThhZWMtMzdmYjFhMDE0ZDM0IiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9&pageName=ReportSection1cb7493dac0598db70e9) to see the Movie Performance Analysis Dashboard on Power BI
