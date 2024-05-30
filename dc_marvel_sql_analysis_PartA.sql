
-- 1. What is the average box office revenue for DC superhero movies 
-- compared to marvel superhero movies?

SELECT
    AVG(CASE WHEN franchise = 'DC' THEN worldwide_gross END) AS DC_avg_boxoffice_revenue,
    AVG(CASE WHEN franchise = 'Marvel' THEN worldwide_gross END) AS Marvel_avg_boxoffice_revenue
FROM
    movie_boxoffice
WHERE
    franchise IN ('DC', 'Marvel');
    
-- 2. Which DC and Marvel superhero movie has the highest box office revenue respectively?

WITH rank_movies AS
(
SELECT 
    franchise, film, worldwide_gross,
    RANK() OVER(PARTITION BY franchise ORDER BY worldwide_gross DESC) AS Rnk
FROM
    movie_boxoffice
)
SELECT franchise, film, worldwide_gross
FROM rank_movies 
WHERE Rnk = 1;


-- 3. Which year had the highest total box office revenue for superhero movies?

SELECT year, SUM(worldwide_gross) AS total_boxoffice_revenue
FROM movie_boxoffice
GROUP BY year
ORDER BY total_boxoffice_revenue DESC
LIMIT 1;



-- 4. Which movie has the highest worldwide box office gross, and what is its gross-to-budget ratio?

SELECT film, worldwide_gross, gross_to_budget
FROM movie_boxoffice 
WHERE worldwide_gross = (SELECT MAX(worldwide_gross) FROM movie_boxoffice);


-- 5. Which distributor has released the most successful (in terms of worldwide gross) superhero movies?

SELECT distributor, COUNT(break_even) AS success_count 
FROM movie_boxoffice
WHERE break_even = "Success"
GROUP BY distributor
ORDER BY success_count DESC;


-- 6. How many movies have a Rotten Tomatoes critic score above 80%?

SELECT COUNT(film) AS movies_above_80_percent 
FROM movie_boxoffice
WHERE rotten_tomatoes_score > 80;


-- 7. What is the average domestic percentage (Domestic %) for male-led and female-led movies?

SELECT 
    lead_gender,
    AVG(domestic_percent) AS avg_domestic_percentage
FROM
    movie_boxoffice
WHERE lead_gender IN ('male', 'female')
GROUP BY lead_gender;


-- 8. Which character family has the highest average worldwide gross?

SELECT character_family, AVG(worldwide_gross) AS avg_worldwide_gross 
FROM movie_boxoffice
GROUP BY character_family
ORDER BY avg_worldwide_gross DESC
LIMIT 1;


-- 9. What is the distribution of MPAA ratings among the movies?

SELECT mpaa_rating, COUNT(*) AS rating_count
FROM movie_boxoffice
GROUP BY mpaa_rating;


-- 10. How has the average budget and worldwide gross changed over the years?

SELECT 
    year,
    AVG(budget) AS average_budget,
    AVG(worldwide_gross) AS average_worldwide_gross
FROM
    movie_boxoffice
GROUP BY year
ORDER BY year DESC;


-- 11. Which movies have failed to break even (worldwide gross < 2.5 times production budget) 
-- in the past 5 years?

SELECT year, film, rotten_tomatoes_score, break_even 
FROM movie_boxoffice
WHERE worldwide_gross < `2.5x_prod`
AND year >= year(CURRENT_DATE()) - 5;


-- 12. Which movie has the lowest Rotten Tomatoes critic score?

SELECT film, rotten_tomatoes_score 
FROM movie_boxoffice
WHERE rotten_tomatoes_score = (SELECT MIN(rotten_tomatoes_score) FROM movie_boxoffice);


-- 13. Which movie(s) achieved profitability according to the 2.5x production 
-- budget rule for profitability, but still had a relatively low Rotten Tomatoes critic score?

-- The Tomatometer score – based on the opinions of hundreds of film and 
-- television critics – is a trusted measurement of critical recommendation for millions of fans.

-- The Tomatometer score represents the percentage of professional critic reviews 
-- that are positive for a given film or television show. A Tomatometer score is calculated 
-- for a movie or TV show after it receives at least five reviews.

-- Fresh red tomato
-- When at least 60% of reviews for a movie or TV show are positive, 
-- a red tomato is displayed to indicate its Fresh status.

-- Green splat tomato
-- When less than 60% of reviews for a movie or TV show are positive, 
-- a green splat is displayed to indicate its Rotten status.

SELECT film, rotten_tomatoes_score, break_even
FROM movie_boxoffice
WHERE break_even = 'Success'
AND rotten_tomatoes_score < 60;


-- 14. How does the average gross to budget ratio vary across different MPAA ratings?

SELECT mpaa_rating, AVG(gross_to_budget) AS avg_gross_to_budget
FROM movie_boxoffice
GROUP BY mpaa_rating;


-- 15. Which Marvel movie had the highest Rotten Tomatoes critic score?

SELECT film, rotten_tomatoes_score AS highest_rotten_tomatoes_score
FROM movie_boxoffice WHERE rotten_tomatoes_score = (SELECT MAX(rotten_tomatoes_score) FROM movie_boxoffice);

-- 16. What is the distribution of MPAA ratings among DC movies?

SELECT mpaa_rating, COUNT(*) AS no_of_dc_movies
FROM movie_boxoffice
WHERE franchise = 'DC'
GROUP BY mpaa_rating;

-- 17. How does the average inflation-adjusted worldwide gross vary across 
-- different phases of the Marvel Cinematic Universe?

SELECT phase, AVG(inflation_adjusted_worldwide_gross) FROM movie_boxoffice
WHERE franchise = 'Marvel'
GROUP BY phase;


-- 18. Which character family has the highest average gross to budget ratio?

SELECT character_family, AVG(gross_to_budget) AS avg_gross_to_budget
FROM movie_boxoffice
GROUP BY character_family
ORDER BY avg_gross_to_budget DESC
LIMIT 1;

-- 19. What is the total number of male-led and female-led movies in the dataset?

SELECT lead_gender, COUNT(*) AS total_no_of_movies
FROM movie_boxoffice
WHERE lead_gender IN ('Male', 'Female')
GROUP BY lead_gender;

-- 20. What is the average length of Marvel movies vs DC movies?

SELECT 
    AVG(CASE
        WHEN franchise = 'Marvel' THEN minutes
    END) AS avg_marvel_minutes,
    AVG(CASE
        WHEN franchise = 'DC' THEN minutes
    END) AS avg_dc_minutes
FROM
    movie_boxoffice;
    
