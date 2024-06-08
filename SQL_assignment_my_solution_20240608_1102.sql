-- LEVEL 1

-- Question 1: Number of users with sessions
SELECT COUNT(DISTINCT(user_id)) FROM sessions;

-- With Subconsultas
WITH distinct_users AS (
    SELECT DISTINCT user_id 
    FROM sessions
)

SELECT COUNT(*) 
FROM distinct_users;


-- Question 2: Number of chargers used by user with id 1


SELECT COUNT(DISTINCT charger_id), user_id FROM sessions
WHERE user_id = 1;

-- With subconsultas
WITH distinct_charger AS (
    SELECT DISTINCT charger_id, user_id FROM sessions
    )
SELECT COUNT(*) from distinct_charger
WHERE user_id = 1;      



-- LEVEL 2

-- Question 3: Number of sessions per charger type (AC/DC):
SELECT type, COUNT(*) FROM chargers
JOIN sessions ON sessions.charger_id = chargers.id
GROUP BY chargers.type;

-- with suub

WITH joined AS (
    SELECT * FROM chargers
    JOIN sessions ON sessions.charger_id = chargers.id
    )
SELECT type, COUNT(*) FROM joined
GROUP BY joined.type;     

-- Question 4: Chargers being used by more than one user
SELECT user_id, charger_id, COUNT(DISTINCT user_id) AS counter FROM chargers
JOIN sessions ON sessions.charger_id = chargers.id
GROUP BY charger_id
HAVING counter > 1;

-- with subqueries

WITH joined AS (
    SELECT charger_id, COUNT(DISTINCT user_id) AS counter FROM chargers
    JOIN sessions ON sessions.charger_id = chargers.id
    GROUP BY charger_id
    )
SELECT * FROM joined
HAVING counter > 1;    

-- Question 5: Average session time per charger

WITH subtable AS (
SELECT chargers.*, sessions.*, 
    (julianday(sessions.end_time) - julianday(sessions.start_time)) * 24 AS duration_in_hours
FROM chargers
JOIN sessions ON sessions.charger_id = chargers.id
)
SELECT charger_id, AVG(duration_in_hours) AS average_duration FROM subtable

GROUP BY charger_id
ORDER BY average_duration;


-- LEVEL 3

-- Question 6: Full username of users that have used more than one charger in one day (NOTE: for date only consider start_time)
WITH grouped AS (
    SELECT user_id, charger_id, DATE(start_time) AS date_only FROM sessions
    GROUP BY charger_id, date_only
    )
    
SELECT DISTINCT user_id FROM grouped

GROUP BY user_id, date_only
HAVING COUNT(DISTINCT charger_id) > 1
ORDER BY user_id;




-- Question 7: Top 3 chargers with longer sessions

-- Question 8: Average number of users per charger (per charger in general, not per charger_id specifically)

-- Question 9: Top 3 users with more chargers being used




-- LEVEL 4

-- Question 10: Number of users that have used only AC chargers, DC chargers or both

-- Question 11: Monthly average number of users per charger

-- Question 12: Top 3 users per charger (for each charger, number of sessions)




-- LEVEL 5

-- Question 13: Top 3 users with longest sessions per month (consider the month of start_time)
    
-- Question 14. Average time between sessions for each charger for each month (consider the month of start_time)