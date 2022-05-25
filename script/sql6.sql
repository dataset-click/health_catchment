# SQL6
# this SQL will identify the options from each sampled address
drop table catchment.address_all_new_sample10_blue_options;

create table catchment.address_all_new_sample10_blue_options as
select a.address_detail_pid, a.lga_code,a.ste_name16,
  a.nearest_blue ,
  a.blue_dist_km ,
  a.blue_dist_hr ,
  b."owner" blue_100km_options,
  b.dist_km blue_100km_distance,
  b.num blue_100km_num,
  c."owner" blue_70km_options,
  c.dist_km blue_70km_distance,
  c.num blue_70km_num,   
  d."owner" blue_50km_options,
  d.dist_km blue_50km_distance,
  d.num blue_50km_num,   
  e."owner" blue_30km_options,
  e.dist_km blue_30km_distance,
  e.num blue_30km_num,   
  e."owner" blue_1hr_options,
  e.dist_km blue_1hr_distance,
  e.num blue_1hr_num   
from catchment.address_all_new_sample10_catch a
left outer join nvd.blue_100km_options b
on (a.nearest = b.nodeid)
left outer join nvd.blue_70km_options c
on (a.nearest = c.nodeid)
left outer join nvd.blue_50km_options d
on (a.nearest = d.nodeid)
left outer join nvd.blue_30km_options e
on (a.nearest = e.nodeid)
left outer join nvd.blue_1hr_options f
on (a.nearest = f.nodeid)
where a.blue_dist_km is not null
order by ste_name16 , lga_code , address_detail_pid ;

