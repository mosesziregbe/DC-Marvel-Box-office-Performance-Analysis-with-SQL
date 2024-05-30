
-- 1. How does the recent performance of movies within each character family 
-- compare in terms of worldwide gross rankings?


WITH character_family_rank AS
(
SELECT 
    character_family, 
    film,
    year,
    worldwide_gross,
    inflation_adjusted_worldwide_gross,
    RANK() OVER(PARTITION BY character_family ORDER BY inflation_adjusted_worldwide_gross DESC) AS gross_rankings
FROM
    movie_boxoffice
)
SELECT * FROM character_family_rank
WHERE gross_rankings <= 2;



-- 2. Calculate the running total of worldwide gross for each distributor, 
-- ordered by release year.


SELECT distributor, 
	    year, 
        worldwide_gross,
        SUM(worldwide_gross) OVER(PARTITION BY distributor ORDER BY year) AS running_total
FROM movie_boxoffice;

-- 3. Find the movies whose worldwide gross is more than 1.5 times 
-- the average worldwide gross for their respective character family.

SELECT
    film,
    character_family,
    worldwide_gross,
    (SELECT AVG(worldwide_gross) FROM movie_boxoffice WHERE character_family = m.character_family) AS avg_worldwide_gross
FROM movie_boxoffice m
WHERE worldwide_gross > 
1.5 * 
(SELECT AVG(worldwide_gross)
FROM movie_boxoffice
WHERE character_family = m.character_family);


WITH avg_character_fam AS
(
SELECT film, 
		character_family, 
        worldwide_gross,
        AVG(worldwide_gross) OVER(PARTITION BY character_family) AS avg_gross
FROM movie_boxoffice
)
SELECT film, 
		character_family, 
        worldwide_gross,
        (worldwide_gross - (1.5 * avg_gross)) AS diff FROM avg_character_fam
WHERE worldwide_gross > 1.5 * (avg_gross);


WITH avg_character_fam AS
(
SELECT film, 
		character_family, 
        worldwide_gross,
        AVG(worldwide_gross) OVER(PARTITION BY character_family) AS avg_gross
FROM movie_boxoffice
)
SELECT COUNT(film) FROM avg_character_fam
WHERE worldwide_gross > 1.5 * (avg_gross);


-- 4. Retrieve the top 3 movies with the highest worldwide gross 
-- for each year, along with their rank within that year.


WITH top_movies AS
(
SELECT film,
	   year,
       worldwide_gross,
       RANK() OVER(PARTITION BY year ORDER BY worldwide_gross DESC) AS gross_rank
FROM movie_boxoffice
)
SELECT * FROM top_movies
WHERE gross_rank IN (1,2,3);  



-- 5. Calculate the percentage contribution of each movie's domestic gross 
-- to its distributor's total domestic gross.


WITH ranked_domestic_gross AS
(
SELECT 
    distributor, film, domestic_gross,
    SUM(domestic_gross) OVER(PARTITION BY distributor) AS total_domestic_gross
FROM
    movie_boxoffice
)
SELECT 
    distributor,
    film,
    ROUND(((domestic_gross) / (total_domestic_gross)) * 100, 2) AS percentage_contribution
FROM
    ranked_domestic_gross;
    


-- 6. Find the movies whose worldwide gross is more than the 
-- average worldwide gross of all movies released in the same year
-- yet the movies were still a flop.


WITH movie_cte AS
(
SELECT 
    year, film, worldwide_gross,
    AVG(worldwide_gross) OVER(PARTITION BY year) AS avg_worldwide_gross,
    break_even
FROM
    movie_boxoffice
)
SELECT film, year, worldwide_gross, avg_worldwide_gross, break_even
FROM movie_cte
WHERE worldwide_gross > avg_worldwide_gross
AND break_even = "Flop";



-- 7. Retrieve the movies whose worldwide gross 
-- is in the top 25% for their respective MPAA rating.

WITH quartile AS (
SELECT film,
	   mpaa_rating, 
       worldwide_gross, 
       NTILE(4) OVER(PARTITION BY mpaa_rating ORDER BY worldwide_gross DESC) AS quartile
FROM movie_boxoffice
)
SELECT * FROM quartile
WHERE quartile=1
;



-- 8. Which DC movies have been a success for the past 7 years?

SELECT year, film, break_even 
FROM movie_boxoffice
WHERE worldwide_gross > `2.5x_prod`
AND year >= year(CURRENT_DATE()) - 7
AND franchise = 'DC';

SELECT 
    SUM(CASE WHEN break_even = 'Success' THEN 1 ELSE 0 END) AS successful_movies,
    COUNT(*) AS total_movies,
    (SUM(CASE WHEN break_even = 'Success' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS success_percentage
FROM 
    movie_boxoffice
WHERE 
    year >= YEAR(CURRENT_DATE()) - 7
    AND franchise = 'DC';
    


SELECT 
    SUM(CASE WHEN break_even = 'Success' THEN 1 ELSE 0 END) AS successful_movies,
    COUNT(*) AS total_movies,
    (SUM(CASE WHEN break_even = 'Success' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS success_percentage
FROM 
    movie_boxoffice
WHERE 
    year >= YEAR(CURRENT_DATE()) - 7
    AND franchise = 'Marvel';

    
    
-- 9. Identify the movies that have the highest and lowest gross-to-budget ratio for each distributor.


WITH distributor_rank AS (
    SELECT
        film,
        distributor,
        gross_to_budget,
        ROW_NUMBER() OVER(PARTITION BY distributor ORDER BY gross_to_budget DESC) AS high_rank,
        ROW_NUMBER() OVER(PARTITION BY distributor ORDER BY gross_to_budget ASC) AS low_rank
    FROM
        movie_boxoffice
)
SELECT
    film,
    distributor,
    gross_to_budget,
    CASE 
        WHEN high_rank = 1 THEN 'Highest'
        WHEN low_rank = 1 THEN 'Lowest'
    END AS rank_label
FROM
    distributor_rank
WHERE
    high_rank = 1 OR low_rank = 1;



-- 10. 	Are both venom movies a success?

SELECT film, worldwide_gross, break_even 
FROM movie_boxoffice
WHERE film LIKE 'venom%';



-- 11. Retrieve the movies that have a higher worldwide gross than all 
-- the movies released in the previous year by the same distributor.


WITH ranked_movies AS (
    SELECT 
        film,
        distributor,
        year,
        worldwide_gross,
        MAX(worldwide_gross) OVER (PARTITION BY distributor ORDER BY year ROWS 
        BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS max_gross_last_year
    FROM 
        movie_boxoffice
)
SELECT 
    film,
    distributor,
    year,
    max_gross_last_year,
    worldwide_gross
FROM 
    ranked_movies
WHERE 
    worldwide_gross > max_gross_last_year;



-- 12. What is the cumulative box office gross worldwide for each distributor over the years?


WITH distributor_cumulative_gross AS (
    SELECT DISTINCT
        distributor,
        year,
        SUM(worldwide_gross) OVER (PARTITION BY distributor ORDER BY year) AS cumulative_gross
    FROM 
        movie_boxoffice
)
SELECT 
    distributor,
    year,
    cumulative_gross
FROM 
    distributor_cumulative_gross;


-- 13. Can you identify the movie with the highest box office gross worldwide for each MPAA rating category?


WITH highest_gross_movies
AS
(
SELECT mpaa_rating, 
	   film, 
       RANK() OVER(PARTITION BY mpaa_rating ORDER BY worldwide_gross DESC) AS gross_rankings
FROM movie_boxoffice
)
SELECT * FROM 
highest_gross_movies
WHERE gross_rankings = 1;


-- 14. Calculate the average box office gross worldwide for each year, 
--  and also include the average gross for the previous year in the same row.


WITH YearlyAverage AS (
    SELECT 
        year,
        AVG(worldwide_gross) AS avg_worldwide_gross,
        LAG(AVG(worldwide_gross)) OVER (ORDER BY year) AS prev_year_avg_worldwide_gross
    FROM 
        movie_boxoffice
    GROUP BY 
        year
)
SELECT 
    year,
    avg_worldwide_gross,
    prev_year_avg_worldwide_gross
FROM 
    YearlyAverage;



-- 15. Rank the movies based on their profitability 
-- (gross to budget ratio) within each distributor.

SELECT distributor, film, 
        RANK() OVER(PARTITION BY distributor ORDER BY gross_to_budget DESC) AS gross_to_budget_rank
FROM movie_boxoffice;


-- 16. Identify the top 5 movies with the highest inflation-adjusted 
-- worldwide gross for each character family.


WITH ranked_movies AS
(
SELECT character_family, film, 
ROW_NUMBER() OVER(PARTITION BY character_family ORDER BY inflation_adjusted_worldwide_gross DESC) AS gross_rank
FROM movie_boxoffice
)
SELECT character_family, film, gross_rank
FROM ranked_movies
WHERE gross_rank <= 5;
