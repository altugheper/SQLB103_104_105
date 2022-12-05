-- Birden fazla primary key ve unique atamak

CREATE TABLE ogrenciler93
(
ogrenci_no char(7),
isim varchar(20), 
soyisim varchar(25),
not_ort real,
kayit_tarih date,
PRIMARY KEY(ogrenci_no,isim),  --COMPOSİTE PK  
unique (soyisim,not_ort)
);

--------------------------------------------

-- ALIASES
-- Aliases kodu ile tablo yazdirilirken, field isimleri sadece o cikti icin degistirilebilir
CREATE TABLE calisanlar3
(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar3 VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO calisanlar3 VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO calisanlar3 VALUES(345678901, 'Mine Bulut','Izmir');

SELECT * FROM calisanlar3;

-- Eger iki sutunun verilerini birlestirmek istersek concet sembolu olan || kullaniriz
SELECT calisan_id AS id, calisan_isim ||'-'||calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar3;

-- 2. Yol
SELECT calisan_id AS id, concat (calisan_isim,'-',calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar3;

--------------------------------------------

/*
ODEV: Sayfa 77
a) Yukarda verilen “personel” tablosunu olusturun
b) Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
c) Iscilerin tum bilgilerini listeleyin
d) Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
e) Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
f) Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin
*/

-- a) Yukarda verilen “personel” tablosunu olusturun
CREATE TABLE personel1(
id int,
isim varchar(30),
soyisim varchar(30),
email varchar(30),
ise_baslama_tar date,
is_unvani varchar(20),
maas int
);
INSERT INTO personel1 VALUES(123456789,'Ali','Can','alican@gmail.com','2010-04-10','Isci',5000);
INSERT INTO personel1 VALUES(123456788,'Veli','Cem','velicem@gmail.com','2012-01-10','Isci',5500);
INSERT INTO personel1 VALUES(123456787,'Ayse','Gul','ayseguln@gmail.com','2014-05-01','Muhasebeci',4500);
INSERT INTO personel1 VALUES(123456789,'Fatma','Yasa','fatmayasa@gmail.com','2010-04-09','Muhendis',7500);
SELECT * FROM personel1;

-- b) Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
SELECT isim FROM personel1 WHERE maas<5000 OR is_unvani='Isci'; 

-- c) Iscilerin tum bilgilerini listeleyin
SELECT * FROM personel1;

-- d) Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
SELECT is_unvani,maas FROM personel1 WHERE soyisim IN('Can','Cem','Gul');

-- e) Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
SELECT email,ise_baslama_tar FROM personel1 WHERE maas>5000;

-- f) Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin
SELECT * FROM personel1 WHERE maas>5000 OR maas<7000;

--------------------------------------------

-- IS NULL
-- Arama yapilan field’da NULL degeri almis kayitlari getirir.

CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

SELECT * FROM insanlar;

-- Name sutununda null olan degerleri listeleyelim
SELECT * FROM insanlar WHERE name IS NULL;

-- insanlar tablosunda sadece null olmayan degerleri listeleyelim
SELECT * FROM insanlar WHERE name IS NOT NULL;

-- insanlar tablosunda null deger almis verileri no name olarak degistiriniz
UPDATE insanlar SET name='No name' WHERE name IS NULL;

--------------------------------------------

-- 	ORDER BY CLAUSE
/*
	ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama
	yapmak icin kullanilir
	ORDER BY komutu sadece SELECT komutu Ile kullanilir
	Default olarak kucukten buyuge siralar
	Eger buyukten kucuge siralamak istersen ORDER BY komutundan sonra DESC komutunu kullaniriz
*/

drop table if exists insanlar
CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

-- insanlar tablosundaki datalari adres'e gore siralayin
SELECT * FROM insanlar ORDER BY adres;

-- insanlar tablosundaki ismi Mine olanlari ssn sirali olarak listeleyin
SELECT * FROM insanlar WHERE isim='Mine' ORDER BY ssn;

-- NOT: ORDER BY komutundan sonra field ismi yerine field numarasi da kullanilabilir
-- insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listele
SELECT * FROM insanlar WHERE soyisim='Bulut' ORDER BY 2;

-- insanlar tablosundaki tum kayitlari ssn numarasi buyukten kucuge sirala
SELECT * FROM insanlar ORDER BY ssn DESC;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
SELECT * FROM insanlar ORDER BY isim ASC, soyisim DESC;

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
/*
Eger sutun uzunluguna gore siralamak istersek LENGTH komutu kullaniriz
Ve yine uzunlugu buyukten kucuge siralamak istersek  sonuna DESC komutunu ekleriz
*/
SELECT isim,soyisim FROM insanlar ORDER BY LENGTH(soyisim) DESC;

-- Tum isim ve soyisim degerlerini ayni sutunda cagirarak her bir sutun degerini uzunluguna gore siralayiniz
SELECT isim || ' ' || soyisim AS isim_soyisim FROM insanlar ORDER BY LENGTH (isim||soyisim);
SELECT isim || ' ' || soyisim AS isim_soyisim FROM insanlar ORDER BY LENGTH (isim) + LENGTH (soyisim);
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar ORDER BY LENGTH (isim) + LENGTH (soyisim);
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar ORDER BY LENGTH (CONCAT(isim,soyisim));

--------------------------------------------

-- GROUP BY
-- Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
-- komutuyla birlikte kullanılır

CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);
SELECT * FROM manav;

-- Isme gore alinan toplam urunleri bulun ve buyukten kucuge siralayin
SELECT isim, SUM(Urun_miktar) AS alinan_toplam_meyve FROM manav GROUP BY isim ORDER BY alinan_toplam_meyve DESC;

-- Urun ismine gore urunu alan toplam kisi sayisi
SELECT Urun_adi, COUNT(isim) AS urunu_alan_toplam_kisi FROM manav GROUP BY Urun_adi;

-- Alinan kilo miktarina gore musteri sayisi
SELECT Urun_miktar, COUNT(isim) AS urun_miktarini_alan_kisi FROM manav GROUP BY Urun_miktar;

