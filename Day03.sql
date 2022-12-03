CREATE TABLE ogrenciler8
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler8 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler8 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler8 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler8 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler8 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler8 VALUES(127, 'Mustafa Bak', 'Ali', 99);
select * from ogrenciler8;

-- Ismi Mustafa Bak ve Nesibe Yilmaz olan kayitlari silelim
DELETE FROM ogrenciler8 WHERE isim='Mustafa Bak' or isim='Nesibe Yilmaz';

-- Veli ismi Hasan olan datayi silelim
DELETE FROM ogrenciler8 WHERE veli_isim='Hasan';

-- TRUNCATE --
-- Bir tablodaki tum verileri geri alinmaksizin siler. Sartli silme yapmaz
TRUNCATE TABLE ogrenciler8;

-- ----------------------------------------------------------------------------------

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar1(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id)
REFERENCES talebeler(id)
on delete cascade
);

-- ON DELETE CASCADE (KADEMELI SILME)
DROP TABLE if exists adresler -- Eger tablo varsa tabloyu siler

INSERT INTO notlar1 VALUES ('123','kimya',75);
INSERT INTO notlar1 VALUES ('124', 'fizik',65);
INSERT INTO notlar1 VALUES ('125', 'tarih',90);
INSERT INTO notlar1 VALUES ('126', 'Matematik',90);

INSERT INTO talebeler VALUES(123, 'Ali
Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124,
'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125,
'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126,
'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127,
'Mustafa Bak', 'Can',99);

SELECT * FROM talebeler;
SELECT * FROM notlar1;

-- Child olan tablodan talebe id'si 123 olan datayi silelim
DELETE FROM notlar1 WHERE talebe_id='123';

-- Parent olan table'dan id'si 126 olan datayi silelim. 
-- On Delete Cascade kullanildigi icin data Child'da olmasina ragmen silebildik.
-- Hem Child hem Parent'dan sildik datayi. 
-- Eger On Delete Cascade olmasaydi data Child'da da oldugu icin silemezdik. 
-- Once Child'dakini silmemiz gerekirdi
DELETE FROM talebeler WHERE id='126';

/*
Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
parent tablo dan da veri silebiliriz. Yanlız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
data child tablo dan da silinir
*/

-- ----------------------------------------------------------------------------------

-- IN CONDITION -- AND & OR

CREATE TABLE musteriler
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');
SELECT * FROM musteriler;

-- Musteriler tablosundan urun ismi orange, apple veya apricot olan datalari listeleyiniz 
-- OR --
SELECT * FROM musteriler WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

-- AND --
SELECT * FROM musteriler WHERE urun_isim='Orange' AND urun_id=10;

-- IN
SELECT * FROM musteriler WHERE urun_isim IN ('Orange','Apple','Apricot');

-- NOT IN
SELECT * FROM musteriler WHERE urun_isim NOT IN ('Orange','Apple','Apricot');

-- ----------------------------------------------------------------------------------

-- BETWEEN

-- musteriler tablosundan id'si 20 ile 40 arasi listele
SELECT * FROM musteriler WHERE urun_id BETWEEN 20 AND 40;

SELECT * FROM musteriler WHERE urun_id>=20 AND urun_id<=40;

SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 AND 40;

-- ----------------------------------------------------------------------------------

-- SUBQUERIES -- NESTED QUERY
-- SUBQUERY baska bir SORGU(query)’nun icinde calisan SORGU’dur. 

CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);

INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM calisanlar2;
SELECT * FROM markalar;

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
-- bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
SELECT isim,maas,isyeri FROM calisanlar2 
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);

-- marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz
SELECT isim,maas,sehir FROM calisanlar2 
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>101)

-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz. ODEV
SELECT marka_id,calisan_sayisi FROM markalar WHERE marka_isim IN(SELECT isyeri FROM calisanlar2 WHERE sehir='Ankara');


-- AGGREGATE METHOD

-- Calisanlar tablosundan maksimum maasi listele
SELECT max(maas) AS maksimum_maas FROM calisanlar2;
/*
Eger bir field'a gecici olarak isim vermek istersek AS komutunu 
yazdiktan sonra vermek istedigimiz ismi yazariz
*/

-- Calisanlar tablosundan minimum maasi listele
SELECT MIN(maas) AS minimum_maas FROM calisanlar2;

-- Calisanlar tablosundan toplamini maasi listele
SELECT SUM(maas) AS toplam_maas FROM calisanlar2;

-- Calisanlar tablosundan ortalama maasi listele
SELECT AVG(maas) AS ortalama_maas FROM calisanlar2;
SELECT round(AVG(maas),2) FROM calisanlar2; -- DECIMAL FORMAT

-- Calisanlar tablosundan maaslarin sayisini listele
SELECT COUNT(maas) AS maas_sayisi FROM calisanlar2; -- Maas yerine * koyup satir sayisini da alabilirsin ama null olup olmadigina dikkat et

-- AGGREGATE METHODLARDA SUBQUERY
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz
SELECT marka_id,marka_isim,(SELECT COUNT(sehir) AS sehir_sayisi FROM calisanlar2 WHERE marka_isim=isyeri)FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
SELECT * FROM calisanlar2;
SELECT * FROM markalar;
SELECT marka_isim,calisan_sayisi,(SELECT SUM(maas) AS toplam_maas FROM calisanlar2 WHERE isyeri=marka_isim) FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen
-- bir Sorgu yaziniz.
SELECT marka_isim,calisan_sayisi,
(SELECT MAX(maas) AS max_maas FROM calisanlar2 WHERE isyeri=marka_isim), 
(SELECT MIN(maas) AS min_maas FROM calisanlar2 WHERE isyeri=marka_isim)
FROM markalar;

-- VIEW kullanimi
CREATE VIEW maxminmaas -- Java'da method yaratma gibi
AS
SELECT marka_isim,calisan_sayisi,
(SELECT MAX(maas) AS max_maas FROM calisanlar2 WHERE isyeri=marka_isim), 
(SELECT MIN(maas) AS min_maas FROM calisanlar2 WHERE isyeri=marka_isim)
FROM markalar;

SELECT * FROM maxminmaas;

-- ----------------------------------------------------------------------------------

-- EXIST CONDITION
-- EXISTS Condition subquery’ler ile kullanilir. IN ifadesinin kullanımına benzer
-- olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin içerisinde
-- bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar.

CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan
(
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

SELECT * FROM mart;
SELECT * FROM nisan;

-- MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
-- URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
-- MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
SELECT urun_id,musteri_isim FROM mart WHERE EXISTS (SELECT urun_id FROM nisan WHERE mart.urun_id=nisan.urun_id);

-- Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
-- NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
SELECT urun_isim,musteri_isim FROM NISAN WHERE EXISTS(SELECT urun_isim FROM mart WHERE nisan.urun_isim=mart.urun_isim);

-- Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
-- NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız. ODEV
SELECT musteri_isim, urun_isim FROM nisan WHERE NOT EXISTS(SELECT urun_isim FROM mart WHERE nisan.urun_isim=mart.urun_isim);

-- Her iki ayda da Honda alan isimleri yaziniz
CREATE VIEW nisanhondaalankisiler2
AS
SELECT musteri_isim AS honda_alan_musteriler FROM nisan WHERE EXISTS(SELECT urun_isim FROM mart WHERE mart.urun_isim='Honda' AND nisan.urun_isim='Honda');
CREATE VIEW marthondaalankisiler2
AS
SELECT musteri_isim AS honda_alan_musteriler FROM mart WHERE EXISTS(SELECT urun_isim FROM nisan WHERE mart.urun_isim='Honda' AND nisan.urun_isim='Honda');

SELECT * FROM nisanhondaalankisiler2;
SELECT * FROM marthondaalankisiler2;

SELECT * FROM nisanhondaalankisiler2,marthondaalankisiler2;



-- ----------------------------------------------------------------------------------

-- DML - UPDATE

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler3 -- child
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino)
REFERENCES tedarikciler(vergi_no)
on delete cascade
);

INSERT INTO urunler3 VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler3 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler3 VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler3 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler3 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler3 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler3 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

SELECT * FROM tedarikciler;
SELECT * FROM urunler3;

-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz
UPDATE tedarikciler SET firma_ismi='Vestel' WHERE vergi_no=102;

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
UPDATE tedarikciler SET firma_ismi='casper',irtibat_ismi='Ali Veli' WHERE vergi_no=101;

-- urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
UPDATE urunler3 SET urun_isim='Telefon' WHERE urun_isim='Phone';

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
UPDATE urunler3 SET urun_id=urun_id+1 WHERE urun_id>1000;

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
UPDATE urunler3 SET urun_id = urun_id+ted_vergino;

DELETE FROM urunler3;
DELETE FROM tedarikciler;

-- UPDATE SUBQUERY

-- urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
-- 'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
UPDATE urunler3 SET urun_isim=(SELECT firma_ismi FROM tedarikciler WHERE irtibat_ismi='Adam Eve') WHERE musteri_isim='Ali Bak';

-- Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.
UPDATE urunler3 SET musteri_isim=(SELECT irtibat_ismi FROM tedarikciler WHERE firma_ismi='Apple')WHERE urun_isim='Laptop';

