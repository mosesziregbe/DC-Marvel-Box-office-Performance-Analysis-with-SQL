-------------------------------
-- DC & Marvel SuperHero Movies Box Office Performance
-------------------------------
-- Author: Moses Tega Ziregbe 
-- Tool used: MySQL Server
--------------------------

CREATE DATABASE dc_marvel_boxoffice;

USE dc_marvel_boxoffice;

SELECT * FROM dc_marvel_movie_data;

DESC dc_marvel_movie_data;


-- Before I start with the solutions, I investigate the data and found 
-- that there are some cleaning and transformation to do on most of the columns and data types

-- We create table movie_boxoffice for our transformations

DROP TABLE IF EXISTS movie_boxoffice;
CREATE TABLE movie_boxoffice
SELECT * FROM dc_marvel_movie_data;

SELECT * FROM movie_boxoffice;

DESC movie_boxoffice;


-- Next, we retrieve the column names from the table for transformation due to sql column naming conventions

-- Removing '$' sign and any commas from 'Box office gross Dosmetic (U.S. and Canada)' column
UPDATE movie_boxoffice
SET `Box office gross Domestic (U.S. and Canada )` = REPLACE(`Box office gross Domestic (U.S. and Canada )`, '$', ''),
    `Box office gross Domestic (U.S. and Canada )` = REPLACE(`Box office gross Domestic (U.S. and Canada )`, ',', '');
    
    
-- Removing '$' sign and any commas from 'Box office gross Other territories' column

UPDATE movie_boxoffice
SET `Box office gross Other territories` = REPLACE(REPLACE(`Box office gross Other territories`, '$', ''), ',', '');

-- Removing '$' sign and any commas from 'Box office gross Worldwide' column
UPDATE movie_boxoffice
SET `Box office gross Worldwide` = REPLACE(REPLACE(`Box office gross Worldwide`, '$', ''), ',', '');

-- Removing '$' sign and any commas from 'Budget' column
UPDATE movie_boxoffice
SET `Budget` = REPLACE(REPLACE(`Budget`, '$', ''), ',', '');

-- Removing '%' sign from 'Domestic %' column
UPDATE movie_boxoffice
SET `Domestic %` = REPLACE(`Domestic %`, '%', '');


-- Removing '$' sign and any commas from 'Inflation Adjusted Worldwide Gross' column
UPDATE movie_boxoffice
SET `Inflation Adjusted Worldwide Gross` = REPLACE(REPLACE(`Inflation Adjusted Worldwide Gross`, '$', ''), ',', '');


-- Removing '$' sign and any commas from 'Inflation Adjusted Budget' column
UPDATE movie_boxoffice
SET `Inflation Adjusted Budget` = REPLACE(REPLACE(`Inflation Adjusted Budget`, '$', ''), ',', '');

-- Removing '$' sign and any commas from '2.5x prod' column
UPDATE movie_boxoffice
SET `2.5x prod` = REPLACE(REPLACE(`2.5x prod`, '$', ''), ',', '');


-- Inspecting our tables after the first transformation
SELECT * FROM movie_boxoffice;


-- we ran into some issues while changing the name of the columns because of a null value 
-- inside 'Box office gross other territories' column
-- So I will Update existing blank values in the 'Box office gross Other territories' column to NULL.
-- This ensures consistency in data representation before modifying the column name.

UPDATE movie_boxoffice
SET `Box office gross Other territories` = NULL
WHERE `Box office gross Other territories` = '';


-- change the columns to the appropriate column names and data types

ALTER TABLE movie_boxoffice 
CHANGE COLUMN `ï»¿Film` film VARCHAR(255),
CHANGE COLUMN `Box office gross Domestic (U.S. and Canada )` domestic_gross BIGINT,
CHANGE COLUMN `Box office gross Other territories` other_territories_gross BIGINT,
CHANGE COLUMN `Box office gross Worldwide` worldwide_gross BIGINT,
CHANGE COLUMN `Budget` budget BIGINT,
CHANGE COLUMN `MCU` mcu VARCHAR(10),
CHANGE COLUMN `Phase` phase VARCHAR(10),
CHANGE COLUMN `Distributor` distributor VARCHAR(255),
CHANGE COLUMN `MPAA Rating` mpaa_rating VARCHAR(255),
CHANGE COLUMN `Length` length VARCHAR(50),
CHANGE COLUMN `Minutes` minutes INT,
CHANGE COLUMN `Franchise` franchise VARCHAR(50),
CHANGE COLUMN `Character Family` character_family VARCHAR(50),
CHANGE COLUMN `Domestic %` domestic_percent INT,
CHANGE COLUMN `Gross to Budget` gross_to_budget DECIMAL(5, 2),
CHANGE COLUMN `Rotten Tomatoes Critic Score` rotten_tomatoes_score INT,
CHANGE COLUMN `Male/Female-led` lead_gender VARCHAR(50),
CHANGE COLUMN `Year` `year` YEAR,
CHANGE COLUMN `Inflation Adjusted Worldwide Gross` inflation_adjusted_worldwide_gross BIGINT,
CHANGE COLUMN `Inflation Adjusted Budget` inflation_adjusted_budget BIGINT,
CHANGE COLUMN `2.5x prod` `2.5x_prod` BIGINT,
CHANGE COLUMN `Break Even` break_even VARCHAR(50);


-- Now, I will handle the date column (U.S release date)
-- Rename the 'U.S release date' column 

ALTER TABLE movie_boxoffice
RENAME COLUMN `U.S. release date` TO us_release_date;


-- Update us_release_date column to the correct date format
UPDATE movie_boxoffice
SET us_release_date = STR_TO_DATE(us_release_date, '%d/%m/%Y');


-- change the us_release_date column to the appropriate datatype

ALTER TABLE movie_boxoffice
MODIFY COLUMN us_release_date DATE;


-- Finally, we can inspect our table and columns again
-- we find out that there are actually 113 movies in the table but some movies 
-- have the same name but different release year


SELECT COUNT(film) FROM movie_boxoffice;

SELECT COUNT(DISTINCT film) FROM movie_boxoffice;

SELECT film, COUNT(*) FROM movie_boxoffice
GROUP BY film
HAVING COUNT(*) > 1;


-- Update movie_boxoffice table to append the year in parentheses to the movie title 
-- only for movies with duplicate title


-- We use a derived table (m2) to select the films that have duplicate titles.
-- We join this derived table with the movie_boxoffice table (m1) on the film title.
-- We update the film column in movie_boxoffice (m1) by concatenating the movie title 
-- with the release year enclosed in parentheses.


UPDATE movie_boxoffice AS m1
JOIN (
    SELECT film
    FROM movie_boxoffice
    GROUP BY film
    HAVING COUNT(*) > 1
) AS m2 ON m1.film = m2.film
SET m1.film = CONCAT(m1.film, ' (', m1.year, ')');


--  Now we can confirm the exact number of distinct movies in our table

SELECT COUNT(DISTINCT film) AS movies_released FROM movie_boxoffice;

