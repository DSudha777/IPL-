select batsmanName,sum(runs) as total_runs from fact_bating_summary
group by batsmanName order by total_runs desc limit 10;