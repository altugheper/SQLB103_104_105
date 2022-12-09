-- DISTINCT

CREATE TABLE musteri_urun
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma');
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut');
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma');
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal');
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi');
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

SELECT * FROM musteri_urun;

CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int 
);
INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

-- Musteri urun tablosundan urun isimlerini tekrarsiz listeleyiniz

-- GROUP BY COZUM
SELECT urun_isim FROM musteri_urun GROUP BY urun_isim;

-- DISTINCT COZUM
SELECT DISTINCT(urun_isim) FROM musteri_urun;

-- Tabloda kac farkli meyve vardir
SELECT COUNT(DISTINCT urun_isim) FROM musteri_urun;

-- FETCH NEXT (SAYI) ROW ONLY / OFFSET / LIMIT

-- Musteri urun tablosundan ilk uc kaydi listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id FETCH NEXT 3 ROW ONLY;

-- Limit
SELECT * FROM musteri_urun ORDER BY urun_id LIMIT 3;

-- en yuksek maasi alan musteriyi listeleyiniz
SELECT musteri_isim,maas FROM maas ORDER BY maas DESC LIMIT 1;

-- en yuksek 2. maasi alan musteriyi listeleyiniz
SELECT musteri_isim,maas FROM maas ORDER BY maas DESC LIMIT 1 OFFSET 1; --OFFSET = 1 atla
/*
Satir atlamak istedigimizde offset komutunu kullaniriz
*/

SELECT musteri_isim,maas FROM maas ORDER BY maas DESC OFFSET 1 FETCH NEXT 1 ROW ONLY;

-- Maas tablosundan en dusuk dorduncu maasi listeleyiniz
SELECT musteri_isim,maas FROM maas ORDER BY maas DESC LIMIT 1 OFFSET 4;

-------------------------------------------------------

-- ALTER TABLE STATEMENT

/*
ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
islemleri icin kullanilir.
ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir
*/


DROP TABLE IF EXISTS personel
CREATE TABLE personel
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
SELECT * FROM personel;

-- 1) ADD default deger ile tabloya bir field ekleme\
ALTER TABLE personel ADD ulke_isim varchar(20) DEFAULT 'Turkiye'; --DEFAULT yazarsak olusturdugumuz stunua belirttigimiz veriyi tum satirlara girer

-- 2) Tabloya birden fazla field ekleme
ALTER TABLE personel ADD cinsiyet varchar(20), ADD yas int;

-- 3) DROP tablodan sutun silme
ALTER TABLE personel DROP yas;

-- 4) RENAME COLUMN sutun adi degistirme
ALTER TABLE personel RENAME COLUMN ulke_isim TO ulke_adi;

-- 5) RENAME tablonun ismini degistirme
ALTER TABLE personel RENAME TO isciler;

-- 6) TYPE/SET(modify) sutunlarin ozelliklerini degistirme
ALTER TABLE isciler ALTER COLUMN ulke_adi TYPE varchar(30),ALTER COLUMN ulke_adi SET NOT NULL;

-- NOT: Not: String data türünü numerik bir data türüne
-- dönüştürmek istersek;

ALTER TABLE isciler
ALTER COLUMN maas
TYPE varchar(30) USING(maas::varchar(30));

-------------------------------------------------------

-- TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT)
/*
Transaction veritabani sistemlerinde bir islem basladiginda baslar ve islem bitince sona erer. Bu
islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir
*/
DROP TABLE ogrenciler2;
CREATE TABLE ogrenciler2
(
id serial, --  Serial data type otomatik olarak 1den baslayarak sirali olarak sayi atamasi yapar
			-- INSERT INTO ile tabloya veri eklerken serial data type kullandigim veri degeri yerine default yazariz
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT;

SELECT * FROM ogrenciler2;
delete from ogrenciler2;
drop table ogrenciler2;


/*
Transaction kullaniminda SERIAL data type kullanimi tercih edilmez. Savepointten sonra ekledigimiz veride sayac mantigi ile calistigi icin sayacta
en son hangi sayida kaldiysa ordan devam eder
*/

/*
NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar
yanlış bir veriyi düzelmek veya bizim için önemli olan verilerden
sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu
kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki
verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka
"COMMIT" komutu kullanılır.
*/
