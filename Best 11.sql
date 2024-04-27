(select * from(
select batsmanName from batsmen_season3 group by batsmanName 
order by sum(runs) desc limit 7) As A
union
select * from(
select bowlername from bowlers_season2
group by bowlerName order by sum(wickets) desc limit 5)As B)
