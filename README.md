# DC Marvel Box office Performance Analysis with SQL

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
This project aims to analyze box office performance within the superhero movie genre, focusing on Marvel and DC franchises, using SQL queries and advanced techniques like window functions to extract insights. It seeks to compare revenue, identify top-grossing movies, analyze profitability, and explore trends in MPAA ratings and character family performance. The objective is to provide valuable insights for stakeholders in the entertainment industry while demonstrating proficiency in SQL querying and data analysis.

#### Methodology
First, I cleaned and prepared the dataset for analysis, including handling missing values and formatting inconsistencies. I achieved the project objectives by developing a series of SQL queries that addressed a variety of question about the dataset. Each query was designed to extract specific insights and was accompanied by details explaining its purpose. I conducted a comparative analysis of box office performance between Marvel and DC superhero movies, examining average revenue, top-grossing movies, and distributor trends. I also utilized SQL functions and window functions to perform calculations, aggregations, and data manipulations.

Tool used: MySQL
