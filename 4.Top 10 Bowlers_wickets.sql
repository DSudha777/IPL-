   
select bowlerName,sum(wickets) as total_wickets_player
 from fact_bowling_summary
 group by bowlerName
 order by total_wickets_player desc limit 10;