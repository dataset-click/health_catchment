# 4c
# this table will show the options within x km from x catchment

create table nvd.blue_100km_options as
select  nodeid, geom, name, string_agg("owner",'| ' order by dist) "owner",
        string_agg(round((dist/1000))||'',' | ' order by dist) dist_km,
        count("owner") num
from nvd.blue_100km bk
group by nodeid, geom, name;



#-- change 100 with 70, 50, 30
