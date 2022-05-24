# 1hr catchment for both metro and regional
# Metro : 30km
# Regional 70km

create table nvd.blue_1hr as
select nodeid, bk.geom, hp.name, owner, color, remark, trafficlight ,dist, physical_dist
from nvd.blue_100km bk
join hospital.hospital_paper hp
  on (owner = 'f'||hp.id)
where 
  hp.metropolitan is null
  and dist<=70000
union
select nodeid, bk.geom, hp.name, owner, color, remark, trafficlight ,dist, physical_dist
from nvd.blue_100km bk
join hospital.hospital_paper hp
  on (owner = 'f'||hp.id)
where hp.metropolitan ='Y' and dist<=30000;
