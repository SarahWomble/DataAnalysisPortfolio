-- Rename Winner Pts Column for readability
ALTER TABLE superbowl 
	RENAME COLUMN `Winner Pts` TO Winner_Pts;

-- Rename Loser Pts Column for readability
ALTER TABLE superbowl 
	RENAME COLUMN `Loser Pts` TO Loser_Pts;

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

-- What is the highest losing score and the lowest winning score?
SELECT MAX(Loser_Pts) AS Highest_losing_score FROM superbowl s ;
-- The highest losing score is 33 points
SELECT MIN(Winner_Pts) AS Lowest_winning_score FROM superbowl s ;
-- The lowest winning score is 13 points

-- Which teams were playing with the highest losing score and lowest winning score?
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

-- Of all winning teams, which team has the highest average winning score of all time?
SELECT 	Winner, 
		ROUND(AVG(Winner_Pts), 0) AS Avg_Winning_Score
FROM superbowl s 
GROUP BY Winner 
ORDER BY Avg_Winning_Score DESC ;
-- On average the Tampa Bay Buccaneers have the highest winning score of all super bowl games with 48 points

-- Query to see all Super Bowls where the Tampa Bay Buccaneers have won
SELECT SB, Winner, Winner_Pts, Loser, Loser_Pts
	FROM superbowl s 
	WHERE Winner = 'Tampa Bay Buccaneers';
-- They have only won one Super Bowl: Super Bowl 37 against the Oakland Raiders, who scored 21 points

-- Who has won the most super bowls?
SELECT Winner, COUNT(Winner) AS Number_of_wins FROM superbowl s 
	GROUP BY Winner
	ORDER BY Number_of_wins DESC;
-- The New England Patriots and Pittsburgh Steelers have won the most super bowls (6) 

-- Who did they win against and have they ever played each other?
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
SELECT Date, SB, Division, Team, s.Winner, ntl.City, ntl.State
	FROM NFL_Team_Locations ntl 
	JOIN superbowl s 
	ON Winner = team;

SELECT 
  Division, 
  COUNT(Division) AS WinsPerDivision
FROM
  NFL_Team_Locations ntl  
JOIN superbowl s 
ON Winner = Team 
GROUP BY
  Division 
 ORDER BY WinsPerDivision DESC ;
-- The NFC East Division has the most wins per division (9)


