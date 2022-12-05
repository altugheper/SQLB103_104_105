-- “tedarikciler” isminde bir tablo olusturun ve “tedarikci_id”, “tedarikci_ismi”, “tedarikci_adres”
-- ve “ulasim_tarihi” field’lari olsun. 
CREATE TABLE tedarikciler
(
tedarikci_id char(5),
tedarikci_isim varchar(20),
tedarikci_adres varchar(20),
ulasim_tarihi date
);

SELECT * FROM tedarikciler;

CREATE TABLE tedarikci_ziyaret
AS SELECT tedarikci_isim
FROM tedarikciler;

------------------------------------------

CREATE TABLE ogretmenler
(
kimlik_no char(11) UNIQUE,
isim varchar(20),
brans varchar(20),
cinsiyet char(5)
);

SELECT * FROM ogretmenler;

INSERT INTO ogretmenler VALUES('234431223','Ayse Guler',' Matematik','Kadin');
INSERT INTO ogretmenler VALUES('567597624','Ali Veli');

------------------------------------------

CREATE TABLE sehirler
(
alan_kodu char(3) PRIMARY KEY,
isim varchar(20) NOT NULL,
nufus varchar(20)
);

SELECT * FROM sehirler;

------------------------------------------

CREATE TABLE tedarikcilerx
(
tedarikci_id varchar(20) PRIMARY KEY,
tedarikci_isim varchar(20),
iletisim_isim varchar(20)
);

CREATE TABLE urunlerx
(
tedarikci_id varchar(20),
urun_id varchar(20),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikcilerx (tedarikci_id)
);

SELECT * FROM tedarikcilerx;
SELECT * FROM urunlerx;

------------------------------------------

CREATE TABLE calisanlarx
(
calisanlar_id varchar(20) PRIMARY KEY,
isim varchar(20) UNIQUE,
maas int NOT NULL,
ise_baslama date
);

CREATE TABLE adresler
(
adres_id varchar(20),
sokak varchar(20),
cadde varchar(20),
sehir varchar(20),
FOREIGN KEY (adres_id) REFERENCES calisanlarx (calisanlar_id)
);

INSERT INTO calisanlarx VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlarx VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlarx VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); -- tirnak icinde degil
INSERT INTO calisanlarx VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlarx VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlarx VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- maas'a NOT NULL dedigimiz icin null olamaz
INSERT INTO calisanlarx VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlarx VALUES('10007', 'CAN', 5000, '2018-04-14'); -- isim UNIQUE oldugu icin duplicate olamaz
INSERT INTO calisanlarx VALUES('10009', 'cem', '', '2018-04-14'); -- maas int oldugu icin tirnak isareti olmaz, sayi olmasi lazim
INSERT INTO calisanlarx VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlarx VALUES('', 'osman can', 2000, '2018-04-14'); -- isim UNIQUE oldugu icin duplicate olamaz
INSERT INTO calisanlarx VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- calisanlar_id PRIMARY KEY oldugu icin duplicate yazilamaz
INSERT INTO calisanlarx VALUES( null, 'filiz ' ,12000, '2018-04-14'); ---- calisanlar_id PRIMARY KEY oldugu icin null kabul etmez
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

SELECT * FROM calisanlarx;
SELECT * FROM adresler;

------------------------------------------

CREATE TABLE ogrencilerx
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrencilerx VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrencilerx VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrencilerx VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrencilerx VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrencilerx VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrencilerx VALUES(127, 'Mustafa Bak', 'Ali', 99);

-- idsi 124 olan ogrenciyi siliniz
-- ismi kemal Yasa olan satirini siliniz
DELETE FROM ogrencilerx WHERE id=124;
DELETE FROM ogrencilerx WHERE isim='Kemal Yasa';

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
DELETE FROM ogrencilerx WHERE isim='Nesibe Yilmaz' OR isim='Mustafa Bak';

-- İsmi Ali Can ve id'si 123 olan kaydı siliniz.
DELETE FROM ogrencilerx WHERE isim='Ali Can' AND id=123;

-- id 'si 126'dan büyük olan kayıtları silelim.
DELETE FROM ogrencilerx WHERE id>=126;

SELECT * FROM ogrencilerx;

-- id'si 123, 125 veya 126 olanları silelim
DELETE FROM ogrencilerx WHERE id IN (123,125,126);

------------------------------------------

CREATE table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

-- - id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
SELECT * FROM personel WHERE id BETWEEN '1003' AND '1005';

--D ile Y arasındaki personel bilgilerini listeleyiniz
SELECT * FROM personel WHERE isim BETWEEN 'D' AND 'Y';

--D ile Y arasında olmayan personel bilgilerini listeleyiniz
SELECT * FROM personel WHERE isim NOT BETWEEN 'D' AND 'Y';

--- Maaşı 70000 ve ismi Sena olan personeli listeleyiniz
SELECT * FROM personel WHERE isim='Sena Beyaz' OR maas=70000;

------------------------------------------

-- 66 sayfa

