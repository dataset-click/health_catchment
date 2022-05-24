#SQL2
#Obtain 1 sample address from each Mesh Blocks
create
table gnaf.address_all_sample as
select *, 'xxxxxxx' nearest, 99999.99999 dist , ' ' status
from
  ( select * , row_number() over (partition by mb_code16 ) num
    from gnaf.address_detail_all ad ) x
where
num <=1;
