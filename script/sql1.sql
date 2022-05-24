# SQL1
drop table
gnaf.address_detail_all;

create table
gnaf.address_detail_all as
select
  ad.address_detail_pid,
  case
    when 
      ad.flat_number is null then ''
    else
      ad.flat_number||'/'
  end
  ||         
  ad.number_first||' '||sl.street_name||' '||sl.street_type_code address , 
  ma.ste_name16,
  ma.mb_code16,
  ma.sa1_main16 sa1,
  ma.sa2_main16 sa2,
  ma.sa3_code16 sa3,
  ma.sa4_code16 sa4,               
  ad.postcode,
  ma.lga_code,
  ma.gcc_name16,
  adg.geom
from  gnaf.address_detail ad
  join gnaf.street_locality sl
    on (ad.street_locality_pid = sl.street_locality_pid)
  join gnaf.address_mesh_block_2016 amb
    on (ad.address_detail_pid = amb.address_detail_pid)
  join gnaf.mb_2016 m
    on (amb.mb_2016_pid = m.mb_2016_pid)
  join gnaf.address_default_geocode adg
    on (ad.address_detail_pid = adg.address_detail_pid)
  join abs.mb_au16 ma
    on (ma.mb_code16 = m.mb_2016_code);
