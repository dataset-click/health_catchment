#70km options

create table nvd.blue_70km as
select * from nvd.blue_100km
where dist<=70000;


#50km options
create table nvd.blue_70km as
select * from nvd.blue_100km
where dist<=50000;

#30km options
create table nvd.blue_70km as
select * from nvd.blue_100km
where dist<=30000;
