-- DATABASE(VeriTabani) Olusturma
Create dataBase altug;
create database heper;


-- DDL - DATA DEFINITION LANGUAGE
-- CREATE - TABLO OLUSTURMA
CREATE TABLE ogrenciler1
(
ogrenci_no char(7),-- Uzunlugunu bildigimiz stringler icin CHAR kullanilir
isim varchar(20),-- Uzunlugunu bilmedigimiz stringler icin VARCHAR kullanilir
soyisim varchar(25),
not_ort real,--Ondalikli sayilar icin kullanilir(Double gibi)
kayit_tarih date
-- Variable olusturduktan sonra baska bir variable daha eklemek istersen "," koy. En son bitirince birsey koymana gerek yok
);


--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE ogrenci_notlari 
AS --Benzer tablodaki basliklarla ve data tipleriyle yeni bir tablo olusturmak icin 
--normal tablo olustururkenki parantezler yerine AS kullanip Select komutuyla almak istedigimiz verileri aliriz
SELECT isim,soyisim,not_ort 
FROM ogrenciler1;


-- DML - DATA MANIPULATION LANGUAGE
-- INSERT (Database'e veri ekleme)
INSERT INTO ogrenciler1 VALUES('1234567','Altug','HEPER','93.3',now());
INSERT INTO ogrenciler1 VALUES('1234567','Altug','HEPER','93.3','2020-12-11');


-- BIR TABLOYA PARCALI VERI EKLEMEK
INSERT INTO ogrenciler1(isim,soyisim) VALUES('Karolina','Michalik');

-- DQL - DATA QUERY LANGUAGE
-- SELECT

select * FROM ogrenciler1; -- Burdaki * sembolu "herseyi" anlamindadir

