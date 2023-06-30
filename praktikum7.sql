create database praktikum7;
use praktikum7;
drop database praktikum7;

create table Perusahan(
id_p varchar(10) primary key,
nama varchar(45) not null,
alamat varchar(45) default null
);

create table Departemen (
id_dept varchar(10) primary key,
nama varchar(45) not null,
id_p varchar(10) not null,
manajer_nik varchar(10) default null
);

create table Karyawan (
nik varchar(10) primary key,
nama varchar(45) not null,
id_dept varchar(10) not null,
sup_nik varchar(10) default null,
gaji_pokok int
);

create table Project(
id_proj varchar(10) primary key,
nama varchar(45) not null,
tgl_mulai datetime,
tgl_selesai datetime,
status tinyint(1)
);

create table Project_detail(
id_proj varchar(10) not null,
nik varchar(10) not null
);

insert into Perusahan (id_p, nama, alamat)
values ('P01', 'Kantor Pusat', NULL),
	   ('P02', 'Cabang Bekasi', NULL);
select * from Perusahan;
       
insert into Departemen (id_dept, nama, id_p, manajer_nik)
values ('D01', 'Produksi', 'P02', 'N01'),
	   ('D02', 'Marketing', 'P01', 'N03'),
       ('D03', 'RnD', 'P02', NULL),
       ('D04', 'Logistik', 'P02', NULL);
select * from Departemen;

insert into Karyawan (nik, nama, id_dept, sup_nik, gaji_pokok)
values ('N01', 'Ari', 'D01', NULL, 2000000),
	   ('N02', 'Dina', 'D01', NULL, 2500000),
       ('N03', 'Rika', 'D03', NULL, 2400000),
       ('N04', 'Ratih', 'D01', 'N01', 3000000),
       ('N05', 'Riko', 'D01', 'N01', 2800000),
       ('N06', 'Dani', 'D02', NULL, 2100000),
       ('N07', 'Anis', 'D02', 'N06', 5000000),
       ('N08', 'Dika', 'D02', 'N06', 4000000),
       ('N09', 'Raka', 'D03', 'N06', 2000000);
select * from Karyawan;    
              
insert into Project (id_proj,nama,tgl_mulai,tgl_selesai,status)
values ('PJ01', 'A', '2019-01-10', '2019-03-10', '1'),
	   ('PJ02', 'B', '2019-02-15', '2019-04-10', '1'),
	   ('PJ03', 'C', '2019-03-21', '2019-05-10', '1');
select * from Project;

insert into Project_detail (id_proj, nik)
values ('PJ01', 'N01'),
       ('PJ01', 'N02'),
	   ('PJ01', 'N03'),
	   ('PJ01', 'N04'),
	   ('PJ01', 'N05'),
	   ('PJ01', 'N07'),
	   ('PJ01', 'N08'),
	   ('PJ02', 'N01'),
	   ('PJ02', 'N03'),
	   ('PJ02', 'N05'),
	   ('PJ03', 'N03'),
	   ('PJ03', 'N07'),
	   ('PJ03', 'N08');
select * from Project_detail;

alter table Project_detail
add constraint fk_project_detail_id_proj foreign key (id_proj) references Project (id_proj);

select nik, nama, gaji_pokok from Karyawan where gaji_pokok > (select MAX(gaji_pokok) from Karyawan where nama = 'Riko');
select nik, nama from Karyawan where sup_nik = (select sup_nik from Karyawan where nama = 'Riko');
select nik, nama from Karyawan where sup_nik = (select nik from Karyawan where nama = 'Ari');
select nik, nama, gaji_pokok from Karyawan where gaji_pokok = (select MIN(gaji_pokok) from Karyawan);
select nik, nama, gaji_pokok from Karyawan where gaji_pokok IN (select MIN(gaji_pokok) from Karyawan group by id_dept);

select nik, nama, id_dept from Karyawan where id_dept = (select id_dept from Karyawan where nama = 'Dika');
select nik, nama, id_dept, gaji_pokok from karyawan where gaji_pokok > (select avg(gaji_pokok) from Karyawan) order by gaji_pokok desc;
select nik, nama from Karyawan where id_dept in (select id_dept from Karyawan where nama like '%K%');
select karyawan.nik, karyawan.nama, karyawan.id_dept from karyawan join departemen on karyawan.id_dept = departemen.id_dept where departemen.id_p = 'P01';
select distinct k1.nik, k1.nama from karyawan k1 join karyawan k2 on k1.id_dept = k2.id_dept where k1.gaji_pokok > (select avg(gaji_pokok) from karyawan where nama like '%K%');
