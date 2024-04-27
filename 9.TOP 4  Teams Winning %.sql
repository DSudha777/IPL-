create View Team_Total_match1 as
with cte1 as(
select team1 as team,count(team1) as team_count  from dim_match_summary
group by team1
union all
select team2 as team ,count(team2) as team_count from dim_match_summary
group by team2)
select team,sum(team_count)as total_matches from cte1 group by team;

Create View winner as
SELECT winner ,count(winner) as wins from dim_match_summary
group by winner;
        
with cte1 as (select * from Team_Total_match1 m
cross join winner w 
on m.team = w.winner)
select team,total_matches,wins, round(wins/total_matches*100,2) as winning_Percent from cte1
order by winning_Percent desc limit 4 ;