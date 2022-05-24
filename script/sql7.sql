#SQL7
#this SQL create the aggregated data in LGA level
drop table catchment.lga_new_sample10_catchment;
create table catchment.lga_new_sample10_catchment as
select c.lga_code, la.geom,
    coalesce(avg(ambo.ambo_dist_km),0) ambo_nearest_km,   
    coalesce(avg(ambo.ambo_dist_hr),0) ambo_nearest_hr,
    coalesce(avg(ambo.ambo_100km_num),0) ambo_num100km,   
    coalesce(avg(ambo.ambo_70km_num),0) ambo_num70km,
    coalesce(avg(ambo.ambo_50km_num),0)ambo_num50km,  
    coalesce(avg(ambo.ambo_30km_num),0) ambo_num30km,
    coalesce(avg(ambo.ambo_1hr_num),0) ambo_num1hr,
    
    coalesce(avg(blue.blue_dist_km),0) blue_nearest_km,
    coalesce(avg(blue.blue_dist_hr),0)  blue_nearest_hr,               	
    coalesce(avg(blue.blue_100km_num),0) blue_num100km,
    coalesce(avg(blue.blue_70km_num),0) blue_num70km,              	
    coalesce(avg(blue.blue_50km_num),0) blue_num50km,
    coalesce(avg(blue.blue_30km_num),0) blue_num30km,
    coalesce(avg(blue.blue_1hr_num),0) blue_num1hr,
    
    coalesce(avg(green.green_dist_km),0) green_nearest_km,        
    coalesce(avg(green.green_dist_hr),0) green_nearest_hr,        
    coalesce(avg(green.green_100km_num),0) green_num100km,        
    coalesce(avg(green.green_70km_num),0) green_num70km,        
    coalesce(avg(green.green_50km_num),0) green_num50km,         
    coalesce(avg(green.green_30km_num),0) green_num30km,        
    coalesce(avg(green.green_1hr_num),0) green_num1hr,
    
    coalesce(avg(orange.orange_dist_km),0) orange_nearest_km, 	
    coalesce(avg(orange.orange_dist_hr),0) orange_nearest_hr,
    coalesce(avg(orange.orange_100km_num),0) orange_num100km,         
    coalesce(avg(orange.orange_70km_num),0) orange_num70km, 	
    coalesce(avg(orange.orange_50km_num),0) orange_num50km,
	  coalesce(avg(orange.orange_30km_num),0) orange_num30km,
	  coalesce(avg(orange.orange_1hr_num),0) orange_num1hr,
    
    coalesce(avg(red.red_dist_km),0) red_nearest_km,	
    coalesce(avg(red.red_dist_hr),0) red_nearest_hr, 	
    coalesce(avg(red.red_100km_num),0) red_num100km,	
    coalesce(avg(red.red_70km_num),0) red_num70km,	
    coalesce(avg(red.red_50km_num),0) red_num50km,	
    coalesce(avg(red.red_30km_num),0) red_num30km,	
    coalesce(avg(red.red_1hr_num),0) red_num1hr                
from regression.address_all_new_sample10_catch c
left outer join catchment.address_all_new_sample10_ambo_options ambo
  on (c.address_detail_pid = ambo.address_detail_pid)
left outer join catchment.address_all_new_sample10_blue_options blue
  on (c.address_detail_pid=blue.address_detail_pid)
left outer join catchment.address_all_new_sample10_green_options green
  on (c.address_detail_pid=green.address_detail_pid)
left outer join catchment.address_all_new_sample10_orange_options orange
  on (c.address_detail_pid=orange.address_detail_pid)
left outer join catchment.address_all_new_sample10_red_options red
  on (c.address_detail_pid=red.address_detail_pid)
left outer join abs.lga_au la
  on (c.lga_code = la.lga_code20)
group by c.lga_code, la.geom;
