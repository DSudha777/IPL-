////Orange and purple cap player////;

SELECT batsmanName,total_runs_season FROM iplmatch.batsmen_season
where total_runs_season in
(select max(total_runs_season) from batsmen_season where season=2023);

select bowlerName,total_wickets_season from bowlers_season
where total_wickets_season in
(select max(total_wickets_season) from bowlers_season  where season=2023);