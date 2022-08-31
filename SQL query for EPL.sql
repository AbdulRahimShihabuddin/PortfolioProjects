select * from PLplayers

--ALTER TABLE PLplayers
--add
--	goals_per_90_overall FLOAT,
--	goals_involved_per_90_overall FLOAT,
--	assists_per_90_overall	FLOAT,
--	goals_per_90_overall FLOAT,
--	goals_per_90_home FLOAT,
--	goals_per_90_away FLOAT,
--	min_per_goal_overall FLOAT,
--	conceded_per_90_overall FLOAT,
--	min_per_conceded_overall FLOAT,
--	min_per_match	FLOAT,
--	min_per_card_overall FLOAT,
--	min_per_assist_overall FLOAT,
--	cards_per_90_overall FLOAT,

SELECT position,count(position) as CountPosition
from PLplayers
group by position
order by CountPosition

---Find the oldest player in the league
SELECT *
from PLplayers
order by age DESC

--Order by on the basis of age and position
SELECT *
from PLplayers
order by 6 DESC,2 DESC

UPDATE PLplayers SET goals_per_90_overall=round((CASE WHEN minutes_played_overall=0 then 0
WHEN minutes_played_overall <> 0 then goals_overall/(minutes_played_overall/90)END),2)

UPDATE PLplayers SET assists_per_90_overall=round((CASE WHEN minutes_played_overall=0 then 0
WHEN minutes_played_overall <> 0 then assists_overall/(minutes_played_overall/90)END),2)

UPDATE PLplayers SET goals_involved_per_90_overall=round((CASE WHEN minutes_played_overall=0 then 0
WHEN minutes_played_overall <> 0 then goals_overall+assists_overall/(minutes_played_overall/90)END),2)


UPDATE PLplayers SET goals_per_90_home=round((CASE WHEN minutes_played_home=0 then 0
WHEN minutes_played_home <> 0 then goals_home/(minutes_played_home/90)END),0)

UPDATE PLplayers SET goals_per_90_away=round((CASE WHEN minutes_played_away=0 then 0
WHEN minutes_played_away <> 0 then goals_home/(minutes_played_away/90)END),0)

UPDATE PLplayers SET min_per_goal_overall=round((CASE WHEN goals_overall=0 then 0
WHEN goals_overall <> 0 then minutes_played_overall/(goals_overall)END),2)

UPDATE PLplayers SET min_per_assist_overall=round((CASE WHEN assists_overall=0 then 0
WHEN assists_overall <> 0 then minutes_played_overall/(assists_overall)END),2)

UPDATE PLplayers SET min_per_card_overall=round((CASE WHEN yellow_cards_overall+red_cards_overall=0 then 0
WHEN yellow_cards_overall+red_cards_overall<> 0 then minutes_played_overall/(yellow_cards_overall+red_cards_overall)END),2)

UPDATE PLplayers SET min_per_conceded_overall=round((CASE WHEN conceded_overall=0 then 0
WHEN conceded_overall<> 0 then minutes_played_overall/(conceded_overall)END),2)

UPDATE PLplayers SET min_per_match=round((CASE WHEN appearances_overall=0 then 0
WHEN appearances_overall<> 0 then minutes_played_overall/(appearances_overall)END),2)

UPDATE PLplayers SET conceded_per_90_overall=round((CASE WHEN minutes_played_overall=0 then 0
WHEN minutes_played_overall <> 0 then conceded_overall/(minutes_played_overall/90)END),2)

UPDATE PLplayers SET cards_per_90_overall=round((CASE WHEN minutes_played_overall=0 then 0
WHEN minutes_played_overall <> 0 then  yellow_cards_overall+red_cards_overall/(minutes_played_overall/90)END),0)
select * from PLplayers

UPDATE PLplayers SET goals_per_90_home=round((CASE WHEN minutes_played_home=0 then 0
WHEN minutes_played_home <> 0 then goals_home/(minutes_played_home/90)END),2)

UPDATE PLplayers SET goals_per_90_away=round((CASE WHEN minutes_played_away=0 then 0
WHEN minutes_played_away <> 0 then goals_home/(minutes_played_away/90)END),2)


SELECT position,age,count(position)
from PLplayers
group by position,age

SELECT full_name,age,position,
GROUP BY
   case
		when age > 30 then 'Veteran'
		when age between 23 and 30 then 'In their prime'
		else 'Promising Star'
   end as Experience

from PLplayers

--CTE
with Experience1(full_name,age,position,Experience)
AS
(SELECT full_name,age,position,
   case
		when age > 30 then 'Veteran'
		when age between 23 and 30 then 'In their prime'
		else 'Promising Star'
   end as Experience
   from PLplayers
)

select Experience,position,count(full_name) as PlayerCountExperience from Experience1
group by Experience,position;


group by Experience

---Bench_strength for different positions in each club
SELECT position,PLplayers.[Current Club],count(PLplayers.[Current Club]) as Bench_strength
from PLplayers
group by position,PLplayers.[Current Club]

select * from PLplayers

--Showing the nationality of players
select nationality , count(full_name) as number_of_players from PLplayers
group by nationality 
order by number_of_players DESC;

--Top ten fair players with minnutes_played_overall

select full_name,min_per_card_overall, (yellow_cards_overall+red_cards_overall) as Cards_overall ,position from PLplayers
order by min_per_card_overall DESC;


--Finding the number of players in each team.

select PLplayers.[Current Club], count(full_name) as number_of_players from PLplayers
group by PLplayers.[Current Club]
order by number_of_players DESC;

select full_name,goals_overall,assists_overall,conceded_overall from PLplayers
order by goals_overall DESC,assists_overall DESC,conceded_overall;

--Top goal scorers in the league
select full_name,goals_overall from PLplayers
order by goals_overall DESC;

--Top players who have resulted in a goal

select full_name,(goals_overall+assists_overall) as goals_involved from PLplayers
order by goals_involved DESC;