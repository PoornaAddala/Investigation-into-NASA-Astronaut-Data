-- Create database named "space_exploration"
CREATE DATABASE space_exploration;

-- Use the "space_exploration" database
USE space_exploration;

-- Select all columns from the "astronauts" table
SELECT * FROM astronauts;

-- 1. Retrieve the status of astronauts and their count
SELECT Status, COUNT(*) AS Number
FROM astronauts
GROUP BY Status;

-- 2. Obtain the Military Branch of astronauts and their count
SELECT Military_Branch, COUNT(*) AS Number
FROM astronauts
GROUP BY Military_Branch;

-- 3. Identify the top 5 military ranks among astronauts
SELECT TOP 5
    Military_Rank, COUNT(*) AS Number
FROM astronauts
GROUP BY Military_Rank
ORDER BY Number DESC;

-- 4. Count the number of male and female astronauts
SELECT Gender, COUNT(*) AS Number
FROM astronauts
GROUP BY Gender;

-- 5. Calculate the average life expectancy of astronauts
SELECT ROUND(AVG(Life_Expectancy), 0) AS Average_Life_Expectancy
FROM (
    SELECT
        CASE
            WHEN Status = 'Deceased' THEN YEAR(Death_Date) - YEAR(Birth_Date)
            ELSE 2023 - YEAR(Birth_Date)
        END AS Life_Expectancy
    FROM astronauts
) subquery;

-- 6. Calculate the average life expectancy of female astronauts
SELECT ROUND(AVG(Female_Life_Expectancy), 0) AS Female_Average_Life_Expectancy
FROM (
    SELECT
        CASE
            WHEN Status = 'Deceased' AND Gender = 'Female' THEN YEAR(Death_Date) - YEAR(Birth_Date)
            WHEN Status <> 'Deceased' AND Gender = 'Female' THEN 2023 - YEAR(Birth_Date)
            ELSE NULL
        END AS Female_Life_Expectancy
    FROM astronauts
) subquery;

-- 7. Calculate the average life expectancy of male astronauts
SELECT ROUND(AVG(Male_Life_Expectancy), 0) AS Male_Average_Life_Expectancy
FROM (
    SELECT
        CASE
            WHEN Status = 'Deceased' AND Gender = 'Male' THEN YEAR(Death_Date) - YEAR(Birth_Date)
            WHEN Status <> 'Deceased' AND Gender = 'Male' THEN 2023 - YEAR(Birth_Date)
            ELSE NULL
        END AS Male_Life_Expectancy
    FROM astronauts
) subquery;

-- 8. Retrieve the top 10 graduate majors among astronauts
SELECT TOP 10
    Graduate_Major, COUNT(*) AS Number
FROM astronauts
GROUP BY Graduate_Major
ORDER BY Number DESC;

-- 9. Count astronauts with undergraduate and graduate degrees
SELECT
    COUNT(*) AS Number_of_Astronauts,
    SUM(CASE WHEN Undergraduate_Major IS NOT NULL THEN 1 ELSE 0 END) AS Astronauts_with_Undergraduate_Degrees,
    SUM(CASE WHEN Graduate_Major IS NOT NULL THEN 1 ELSE 0 END) AS Astronauts_with_Graduate_Degrees
FROM astronauts;

-- 10. Retrieve the top 5 states of birth for astronauts
SELECT TOP 5
    STATE,
    COUNT(*) AS Astronauts_Count
FROM (
    SELECT 
        RIGHT(Birth_Place, LEN(Birth_Place) - CHARINDEX(',', Birth_Place)) AS STATE
    FROM astronauts
) subquery
GROUP BY STATE
ORDER BY Astronauts_Count DESC;

-- 11. Calculate the average number of space flights and spacewalks for astronauts
SELECT 
    ROUND(AVG(Space_Flights), 2) AS Average_Number_Of_Space_Flight,
    ROUND(AVG(Space_Walks), 2) AS Average_Number_Of_Space_Walks
FROM astronauts;

-- 12. Retrieve the top 10 alma maters of astronauts
SELECT TOP 10
    Alma_Mater,
    COUNT(*) AS Astronauts_Count
FROM astronauts
GROUP BY Alma_Mater
ORDER BY Astronauts_Count DESC;

-- 13. Retrieve the top 10 undergraduate majors among astronauts
SELECT TOP 10
    Undergraduate_Major,
    COUNT(*) AS Astronauts_Count
FROM astronauts
GROUP BY Undergraduate_Major
ORDER BY Astronauts_Count DESC;

-- 14. Count astronauts who pursued the same major for both undergraduate and graduate studies
SELECT COUNT(*) AS Astronauts_Count_No_Major_Change
FROM astronauts
WHERE Undergraduate_Major IS NOT NULL AND Graduate_Major IS NOT NULL AND Undergraduate_Major = Graduate_Major;

-- 15. Retrieve the youngest astronaut
SELECT TOP 1
    Name, Birth_Date
FROM astronauts
ORDER BY Birth_Date DESC;

-- 16. Identify astronauts who passed away without being on a mission and determine their death dates
SELECT Name, Death_Date, Death_Mission
FROM astronauts
WHERE Status = 'Deceased' AND Death_Mission IS NOT NULL;

-- 17. Retrieve the top 5 astronauts with the most space flights
SELECT TOP 10
    Name, Space_Flights
FROM astronauts
ORDER BY Space_Flights DESC;

-- 18. Retrieve the top 3 astronauts who spent the longest time in space
SELECT TOP 10
    Name,
    "Space_Flight_(hr)"
FROM astronauts
ORDER BY "Space_Flight_(hr)" DESC;

-- 19. Retrieve the top 10 astronauts with the most spacewalks
SELECT TOP 10
    Name, Space_Walks
FROM astronauts
ORDER BY Space_Walks DESC;

-- 20. Retrieve the top 10 astronauts with the longest total spacewalk hours and their names
SELECT TOP 10
    Name, "Space_Walks_(hr)"
FROM astronauts
ORDER BY "Space_Walks_(hr)" DESC;

-- 21. Identify astronauts with no alma mater (no information about their undergraduate institution)
SELECT *
FROM astronauts
WHERE Alma_Mater IS NULL AND Undergraduate_Major IS NULL;

-- 22. Identify the most recently joined astronaut
SELECT TOP 1
    *
FROM astronauts
ORDER BY Year DESC;

-- 23. Retrieve names of astronauts who were part of the Apollo missions
SELECT DISTINCT
    Name, Missions
FROM astronauts
WHERE Missions LIKE '%Apollo%';

-- 24. Retrieve astronauts who did not take any space flights
SELECT *
FROM astronauts
WHERE Space_Flights = 0;

-- 25. Identify the oldest active astronaut as of today
SELECT TOP 1
    *
FROM astronauts
WHERE Status = 'Active'
ORDER BY Birth_Date ASC;
