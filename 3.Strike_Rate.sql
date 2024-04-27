

create view  batsmen_season2 as
 select f.*,substring_index(matchDate,',',-1) as season
from dim_match_summary s
 join fact_bating_summary f on 
f.match_id = s.match_id;

with cte1 as(
select batsmanName,
 sum(case when season=2021 then runs else 0 end) as Runs_2021,
 sum(case when season=2022 then runs else 0 end) as Runs_2022,
 sum(case when season=2023 then runs else 0 end) as Runs_2023,
 sum(case when season=2021 then balls else 0 end) as balls_2021,
 sum(case when season=2022 then balls else 0 end) as balls_2022,
 sum(case when season=2023 then balls else 0 end) as balls_2023,
 count(case when out_notout='out' then 1 else null end) as total_out 
  from batsmen_season2
group by batsmanName),
cte2 as(
select *,(Runs_2021+Runs_2022+Runs_2023) as total_runs,
(balls_2021+balls_2022+balls_2023) as total_balls
 from cte1 where 
balls_2021>=60 and balls_2022>=60 and balls_2023>=60),
cte3 as(
select * ,round((total_runs/total_balls)*100,2) as Strike_rate 
  from cte2)
select batsmanName , Strike_rate from cte3 
order by Strike_rate desc limit 10;

 