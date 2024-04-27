////Top 3 Allrounders////;

create view allrounder2 as
select sum(runs) as total_runs,batsmanName from fact_bating_summary where batsmanName IN(
select name from dim_players where playingRole="Allrounder")
group by batsmanName;

create view allrounder3 as
select sum(wickets) as wickets_taken,bowlerName from fact_bowling_summary where bowlerName IN(
select name from dim_players where playingRole="Allrounder")
group by bowlerName;

select batsmanName as Name,total_runs,wickets_taken  from allrounder2 a
 join allrounder3 b
on a.batsmanName=b.bowlerName
order by wickets_taken desc limit 5;