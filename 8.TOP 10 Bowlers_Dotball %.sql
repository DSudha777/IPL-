create view  bowlers_season2 as
 select f.*,substring_index(matchDate,',',-1) as season
from dim_match_summary s
 join fact_bowling_summary f on 
f.match_id = s.match_id;


with cte1 as(
select bowlerName,
 sum(case when season=2021 then runs else 0 end) as Runs_2021,
 sum(case when season=2022 then runs else 0 end) as Runs_2022,
 sum(case when season=2023 then runs else 0 end) as Runs_2023,
 sum(case when season=2021 then overs else 0 end) as overs_2021,
 sum(case when season=2022 then overs else 0 end) as overs_2022,
 sum(case when season=2023 then overs else 0 end) as overs_2023,
 sum(0s) as total_0s
  from bowlers_season2
group by bowlerName),
cte2 as(
select *,(Runs_2021+Runs_2022+Runs_2023) as total_runs,
(overs_2021+overs_2022+overs_2023) as total_overs
 from cte1 where 
overs_2021>=10 and overs_2022>=10 and overs_2023>=10),
cte3 as(
select *, (total_overs)*6 as total_balls
 from cte2)
select bowlerName, round((total_0s/total_balls)*100,2) as dotball_percent from cte3 
order by dotball_percent desc limit 10;


