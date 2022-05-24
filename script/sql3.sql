#SQL3
#Obtain 10 samples from each SA2

drop table gnaf.address_all_new_sample10;
create table gnaf.address_all_new_sample10 as
select *
from
  ( select  address_detail_pid, address, aas.ste_name16, aas.mb_code16,
            sa1,sa2,sa3,sa4,postcode, aas.lga_code, gcc,aas.geom,nearest, dist, mb_cat16, 
            row_number() over (partition by sa2 ) snum
    from gnaf.address_all_sample aas
      join abs.mb_au16 ma
        on (aas.mb_code16 = ma.mb_code16)
    where mb_cat16='Residential') x
where
snum <=10;
