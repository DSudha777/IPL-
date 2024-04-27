create view For_Team as
with cte2 as (
select teamInnings,sum(runs) as total_runs_team,
round((sum(balls)/6),2) as total_overs_team from fact_bating_summary
group by teamInnings)
select *,round((total_runs_team/total_overs_team),2) as for_team from cte2;

create view Against_team as
with cte1 as(
select bowlingTeam,sum(runs) as total_runs_against,
round(sum(overs),2) as total_overs_against from fact_bowling_summary
group by bowlingTeam)
select *,round((total_runs_against/total_overs_against),2) as team_against from cte1;

with cte3 as(
select *,round((for_team  - team_against),2)as NRR from For_Team f
join Against_team a
on f.teamInnings = a.bowlingTeam)
select bowlingTeam,(wins*2)as points,NRR from cte3 t
join winner w on
t.bowlingTeam = w.winner
order by wins desc limit 4;

