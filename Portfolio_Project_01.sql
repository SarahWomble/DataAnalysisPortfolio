-- Rename Winner Pts Column

ALTER TABLE superbowl 
RENAME COLUMN `Winner Pts` TO Winner_Pts;
SELECT * FROM superbowl s ;

-- Rename Loser Pts Column

ALTER TABLE superbowl 
RENAME COLUMN `Loser Pts` TO Loser_Pts;
SELECT * FROM superbowl s ;

-- What is the average amount of points a team wins by?

SELECT 	Date,
		SB,
		Winner,
		(Winner_Pts - Loser_Pts) AS Points_won_by
FROM superbowl s ;

SELECT ROUND(AVG(Winner_Pts - Loser_Pts), 0) AS Points_won_by
FROM superbowl s ;

-- The average points won by is about 14 points (rounded from 13.9074)

-- How many super bowls do we have data for?

SELECT COUNT(SB) AS NumberOfSuperBowls FROM superbowl s ;

-- We have data for 54 superbowls

-- What is the average score of the winning team?

SELECT * FROM superbowl s ;
SELECT ROUND(AVG(Winner_pts), 0) AS average_winning_score
FROM superbowl s ;

-- On average the winning team scores 30 points (rounded from 30.1111)


-- Let's play around with some other aggregate fuctions

-- What is the highest losing score and the lowest winning score?

SELECT MAX(Loser_Pts) AS Highest_losing_score FROM superbowl s ;
-- The highest losing score is 33 points
SELECT MIN(Winner_Pts) AS Lowest_winning_score FROM superbowl s ;
-- The lowest winning score is 13 points


-- More questions about the data using WHERE, GROUP BY, and ORDER BY:

-- Which superbowls had the highest losing and lowest winning scores? And which teams were playing?

SELECT 	SB, 
		Winner, 
		Winner_Pts, 
		Loser, 
		Loser_Pts
FROM superbowl s 
WHERE Loser_Pts = 33;
-- Super bowl 52: The New England Patriots lost to the Philadelphia Eagles with a score of 41 to 33

SELECT 	SB, 
		Winner, 
		Winner_Pts, 
		Loser, 
		Loser_Pts
FROM superbowl s 
WHERE Winner_Pts = 13;
-- Super bowl LIII (53): The New England Patriots beat the Los Angeles Rams with a score of 13 to 3


SELECT 	Winner, 
		ROUND(AVG(Winner_Pts), 0) AS Avg_Winning_Score
FROM superbowl s 
GROUP BY Winner 
ORDER BY Avg_Winning_Score DESC ;

-- On average the Tampa Bay Buccaneers have the highest winning score of all super bowl games

SELECT SB, Winner, Winner_Pts, Loser, Loser_Pts
	FROM superbowl s 
	WHERE Winner = 'Tampa Bay Buccaneers';
	
-- This is impressive, but they have actually only ever won one super bowl
-- Super bowl 37 against the Oakland Raiders, who scored 21 points

-- Who has won the most super bowls?

SELECT Winner, COUNT(Winner) AS Number_of_wins FROM superbowl s 
	GROUP BY Winner
	ORDER BY Number_of_wins DESC;

-- The New England Patriots and Pittsburgh Steelers have won the most super bowls (6) 
-- Let's find out who they've won against and if they've ever played each OTHERS 

SELECT SB, Winner, Loser FROM superbowl s 
	WHERE (Winner = 'New England Patriots' AND Loser  = 'Pittsburgh Steelers')
	OR (Winner = 'Pittsburgh Steelers' AND Loser = 'New England Patriots')
	ORDER BY Winner;

-- There is no data from this query, therefore they have never played each other in a super bowl; ORDER BY clause is unnecessary

-- What is the most common Stadium, City, and State where super bowls are played?

SELECT Stadium, COUNT(Stadium) AS Number_of_SBs_Played FROM superbowl s
	GROUP BY Stadium
	ORDER BY Number_of_SBs_Played DESC;

-- The Orange Bowl, Rose Bowl, and Louisiana Superdome have all hosted the most (5) super bowls

SELECT City, COUNT(City) AS Number_of_SBs_Played FROM superbowl s
	GROUP BY City
	ORDER BY Number_of_SBs_Played DESC;

-- New Orleans has hosted the most super bowl games (10), with the second most played city being Miami Gardens (6)

SELECT State, COUNT(State) AS Number_of_SBs_Played FROM superbowl s
	GROUP BY State
	ORDER BY Number_of_SBs_Played DESC;

-- Florida has hosted the most super bowls (16), followed by California (12) and Louisiana (10)


-- Now we've added Table "NFL_Team_Locations". Let's join them

SELECT * FROM NFL_Team_Locations ntl ;
SELECT Date, SB, Winner, Division, ntl.City, ntl.State FROM superbowl s
	JOIN NFL_Team_Locations ntl 
	ON Winner = team;

-- How many total wins are there per division?
	
SELECT Date, Division, Team, s.Winner, ntl.City, ntl.State
	FROM NFL_Team_Locations ntl 
	JOIN superbowl s 
	ON Winner = team;
	

SELECT *, COUNT(Division) AS WinsPerDivision
FROM superbowl s 
JOIN NFL_Team_Locations ntl 
ON s.Winner = ntl.Team 
GROUP BY Division;


-- Working on the query below to find syntax error

SELECT Date, Division, Team, s.Winner, ntl.City, ntl.State
	FROM NFL_Team_Locations ntl 
	JOIN superbowl s 
	ON Winner = team
	COUNT(Division) AS WinsPerDivision
	GROUP BY Division DESC ;


-- This works fine - where do I add the COUNT???
SELECT Date, Division, Team, s.Winner, ntl.City, ntl.State
	FROM NFL_Team_Locations ntl 
	JOIN superbowl s 
	ON Winner = team;
	

-- OKAY! This works, but I dk why I can't add the other columns...
-- Making PROGRESS THO! - 31 Jan 2023
-- Having issue with "SQL Mode = Only Full Group By" - Google this...

-- THE BELOW QUERY WORKS!

SELECT 
  Division, COUNT(Division) AS WinsPerDivision
FROM
  NFL_Team_Locations ntl  
JOIN superbowl s 
ON Winner = Team 
GROUP BY
  Division 
 ORDER BY WinsPerDivision DESC ;

-- Alright, so now that I've removed the other columns from the SELECT query I have the answer to my question
-- The NFC East Division has the most wins per division (9)
-- I think I understand why I can't have the other columns there now :)



SELECT *,  FROM NFL_Team_Locations ntl  
JOIN superbowl s 
ON Winner = Team;




