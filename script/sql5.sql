# SQL5
# this script will populate the catchment for each sampled address
drop table catchment.address_all_new_sample10_catch;

create table catchment.address_all_new_sample10_catch as
select  address_detail_pid,
	address , ste_name16 , mb_code16 , sa1 , sa2 , sa3 , sa4 , postcode , lga_code , gcc, aans.geom, nearest , aans.dist dist_km, 
	case
		when gcc like 'Rest%' then round(aans.dist/70,2) 
		else round(aans.dist/30,2) end dist_hr,
	b.owner nearest_blue,
	case 
		when b.metropolitan='Y' then  (round(aans.dist + b.dist::numeric/1000,2)/30)
		else (round(aans.dist + b.dist::numeric/1000,2)/70) end blue_dist_hr,
	round(aans.dist + b.dist::numeric/1000,2) blue_dist_km,
	g.owner nearest_green,
	case 
		when g.metropolitan='Y' then  (round(aans.dist + g.dist::numeric/1000,2)/30)
		else (round(aans.dist + g.dist::numeric/1000,2)/70) end green_dist_hr,
	round(aans.dist + g.dist::numeric/1000,2) green_dist_km,
	o.owner nearest_orange,
	case 
		when o.metropolitan='Y' then  (round(aans.dist + o.dist::numeric/1000,2)/30)
		else (round(aans.dist + o.dist::numeric/1000,2)/70) end orange_dist_hr,
	round(aans.dist + o.dist::numeric/1000,2) orange_dist_km,
	r.owner nearest_red,
	case 
		when r.metropolitan='Y' then  (round(aans.dist + r.dist::numeric/1000,2)/30)
		else (round(aans.dist + r.dist::numeric/1000,2)/70) end red_dist_hr,
	round(aans.dist + r.dist::numeric/1000,2) red_dist_km,
	am.owner nearest_ambo,
	case 
		when am.metropolitan='Y' then  (round(aans.dist + am.dist::numeric/1000,2)/30)
		else (round(aans.dist + am.dist::numeric/1000,2)/70) end ambo_dist_hr,
	round(aans.dist + am.dist::numeric/1000,2) ambo_dist_km,
	x100.nodeid  n100, 
	x70.nodeid n70,
	x50.nodeid n50,
	x30.nodeid n30,
	x1hr.nodeid n1hr
from gnaf.address_all_new_sample10 aans 
left outer join 
	(select nodeid from nvd.ambo_100km_options
	 union
	 select nodeid from nvd.blue_100km_options
	 union
	 select nodeid from nvd.green_100km_options
	 union
	 select nodeid from nvd.orange_100km_options
	 union
	 select nodeid from nvd.red_100km_options 
	 ) x100 
 on (aans.nearest = x100.nodeid)
 left outer join 
	(select nodeid from nvd.ambo_70km_options
	 union
	 select nodeid from nvd.blue_70km_options
	 union
	 select nodeid from nvd.green_70km_options
	 union
	 select nodeid from nvd.orange_70km_options
	 union
	 select nodeid from nvd.red_70km_options ) x70 
 on (aans.nearest = x70.nodeid)
 left outer join 
	(select nodeid from nvd.ambo_50km_options
	 union
	 select nodeid from nvd.blue_50km_options
	 union
	 select nodeid from nvd.green_50km_options
	 union
	 select nodeid from nvd.orange_50km_options
	 union
	 select nodeid from nvd.red_50km_options ) x50 
 on (aans.nearest = x50.nodeid)
 left outer join 
	(select nodeid from nvd.ambo_30km_options
	 union
	 select nodeid from nvd.blue_30km_options
	 union
	 select nodeid from nvd.green_30km_options
	 union
	 select nodeid from nvd.orange_30km_options
	 union
	 select nodeid from nvd.red_30km_options ) x30 
 on (aans.nearest = x30.nodeid)
 left outer join 
	(select nodeid from nvd.ambo_1hr_options
	 union
	 select nodeid from nvd.blue_1hr_options
	 union
	 select nodeid from nvd.green_1hr_options
	 union
	 select nodeid from nvd.orange_1hr_options
	 union
	 select nodeid from nvd.red_1hr_options ) x1hr 
 on (aans.nearest = x1hr.nodeid) 
 left outer join 
	(select * from nvd.t2251_983_nodes x
	join hospital.hospital_ambulance hp
	on (x.owner = 'f'||hp.id)
	where hp.class='BLUE') b
on (aans.nearest = b.nodeid)
left outer join  
	(select * from nvd.t2251_1340_nodes x
	join hospital.hospital_ambulance hp
	on (x.owner = 'f'||hp.id)
	where hp.class='GREEN') g
on (aans.nearest = g.nodeid)
left outer join 
	(select * from nvd.t2252_170_nodes x
	join hospital.hospital_ambulance hp
	on (x.owner = 'f'||hp.id)
	where hp.class='ORANGE') o
on (aans.nearest = o.nodeid)
left outer join 
	(select * from nvd.t2252_683_nodes x
	join hospital.hospital_ambulance hp
	on (x.owner = 'f'||hp.id)
	where hp.class='RED') r
on (aans.nearest = r.nodeid)
left outer join 
	(select * from nvd.t2268_787_nodes x
	join hospital.hospital_ambulance hp
	on (x.owner = 'f'||hp.id)
	where hp.class='AMBO') am
on (aans.nearest = am.nodeid)
where aans.dist<100 ;
