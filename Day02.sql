CREATE TABLE ogrenciler2
(
ogrenci_no char(7),-- Uzunlugunu bildigimiz stringler icin CHAR kullanilir
isim varchar(20),-- Uzunlugunu bilmedigimiz stringler icin VARCHAR kullanilir
soyisim varchar(25),
not_ort real,--Ondalikli sayilar icin kullanilir(Double gibi)
kayit_tarih date);
	
--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE NOTLAR
AS 
SELECT isim,soyisim,not_ort 
FROM ogrenciler2;

select * from notlar;

-- ----------------------------------------------------------------------------------

--INSERT: TABLO ICINE VERI EKLEME
INSERT INTO notlar VALUES ('Altug','Heper',85.5);
INSERT INTO notlar VALUES ('Emek','Heper',90);
INSERT INTO notlar VALUES ('Fikret','Heper',89);
INSERT INTO notlar VALUES ('Demir','Heper',100);

-- ----------------------------------------------------------------------------------

--CONSTRAINT
--UNIQUE
CREATE TABLE ogrenciler3
(
ogrenci_no char(7) unique,
	isim varchar(20) not null,
	soyisim varchar(25),
	not_ort real,
	kayit_tarih date
);
select * from ogrenciler3;

INSERT INTO ogrenciler3 VALUES ('1234567','Altug','Heper',85.5,now());
INSERT INTO ogrenciler3 VALUES ('7891011','Ali','Veli',88,now());
INSERT INTO ogrenciler3(ogrenci_no,soyisim,not_ort) VALUES('1234567','Evren',90);--Parcali Veri - NOT NULL oldugu icin 

-- ----------------------------------------------------------------------------------

--PRIMARY KEY atamasi
CREATE TABLE ogrenciler4
(
ogrenci_no char(7) PRIMARY KEY,
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarih date
);

--PRIMARY KEY atamasi 2. Yol
CREATE TABLE ogrenciler5
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarih date,
CONSTRAINT ogr PRIMARY KEY(ogrenci_no)
);

--PRIMARY KEY atamasi 3. Yol
CREATE TABLE ogrenciler6
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarih date,
PRIMARY KEY(ogrenci_no)
);

-- ----------------------------------------------------------------------------------

/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,
“iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/
--PARENT
CREATE TABLE tedarikciler3
( 
tedarikci_id char(5) PRIMARY KEY,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)
);

CREATE TABLE urunler( --CHILD
tedarikci_id char(5),
urun_id char(5),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

select * from tedarikciler3;

-- ----------------------------------------------------------------------------------

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” 
field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun. 
“adres_id” field‘i ile Foreign Key oluşturun.
*/
CREATE TABLE calisanlar(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int NOT NULL,
ise_baslama date
);

CREATE TABLE adresler(
adres_id varchar(20),
sokak varchar(20),
cadde varchar(20),
sehir varchar(20),
FOREIGN KEY (adres_id) REFERENCES calisanlar(adres_id)
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

select * from calisanlar;
select * from adresler;

-- ----------------------------------------------------------------------------------

-- CHECK CONSTRAINT

CREATE TABLE calisanlar1(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int CHECK(maas>10000),
ise_baslama date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,9000, '2018-04-14'); -- maas>10000 constraint check koydugumuz icin hata verdi cunku maas 9000

-- ----------------------------------------------------------------------------------

-- DQL - DATA QUERY LANGUAGE - WHERE KULLANIMI
SELECT * FROM calisanlar;
SELECT isim FROM calisanlar;

-- calisanlar tablosundan maasi 5000'den buyuk olanlari listeleyiniz
SELECT isim FROM calisanlar WHERE maas>5000; -- WHERE sart icin kullanilir.

-- calisanlar tablosundan ismi
SELECT * FROM calisanlar WHERE isim='Veli Han';

-- calisanlar tablosunda maasi 5000 olan tum verileri listeleyin
SELECT * FROM calisanlar WHERE maas>5000;

-- ----------------------------------------------------------------------------------

-- DML -- DELETE KOMUTU
DELETE FROM calisanlar; -- Eger parent tablo baska bir child tablo ile iliskili ise once child table silinmelidir
DELETE FROM adresler;
SELECT * FROM adresler;

-- adresler tablosundaki sehri Antep olan verileri silelim
DELETE FROM adresler WHERE sehir='Antep';

-- ----------------------------------------------------------------------------------

CREATE TABLE ogrenciler7
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler7 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler7 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler7 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler7 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler7 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler7 VALUES(127, 'Mustafa Bak', 'Ali', 99);
select * from ogrenciler7;



