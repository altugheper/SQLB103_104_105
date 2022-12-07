CREATE TABLE toptancilar     --> parent
(
vergi_no int PRIMARY KEY,
sirket_ismi VARCHAR(40),
irtibat_ismi VARCHAR(30)
);
INSERT INTO toptancilar VALUES (201, 'IBM', 'Kadir Şen');
INSERT INTO toptancilar VALUES (202, 'Huawei', 'Çetin Hoş');
INSERT INTO toptancilar VALUES (203, 'Erikson', 'Mehmet Gör');
INSERT INTO toptancilar VALUES (204, 'Apple', 'Adem Coş');
select * from toptancilar;
CREATE TABLE malzemeler     --> child
(
ted_vergino int,
malzeme_id int,
malzeme_isim VARCHAR(20),
musteri_isim VARCHAR(25),
CONSTRAINT fk FOREIGN KEY(ted_vergino) REFERENCES toptancilar(vergi_no)
on delete cascade
);
INSERT INTO malzemeler VALUES(201, 1001,'Laptop', 'Aslı Can');
INSERT INTO malzemeler VALUES(202, 1002,'Telefon', 'Fatih Ak');
INSERT INTO malzemeler VALUES(202, 1003,'TV', 'Ramiz Özmen');
INSERT INTO malzemeler VALUES(202, 1004,'Laptop', 'Veli Tan');
INSERT INTO malzemeler VALUES(203, 1005,'Telefon', 'Cemile Al');
INSERT INTO malzemeler VALUES(204, 1006,'TV', 'Ali Can');
INSERT INTO malzemeler VALUES(204, 1007,'Telefon', 'Ahmet Yaman');
SELECT * FROM malzemeler;

/*
 child tabloda on delete cascade komutu yazilirsa:
 drop:
 1) child tablo silinmeden parent silinebilir. Pgadmin error vermez.
 yani parent tablo silinir ancak child tablo otomatik silinmez drop ile
 bizim silmemiz gerekir.
 2) child tablodaki veri silinmeden parent tablodaki veri silinmeye calisildiginda
 pgAdmin error vermez. parent tablodaki veriyi siler. fakat bu durumda
 child tablodaki veri de otomatik silinir.
*/

-- SORU1: vergi_no’su 202 olan toptancinin sirket_ismi'ni 'VivoBook' olarak güncelleyeniz.
update toptancilar set sirket_ismi = 'VivoBook'
where vergi_no= '202';
select * from toptancilar;

--  SORU2: toptancilar tablosundaki tüm sirket isimlerini 'NOKIA' olarak güncelleyeniz.
update toptancilar set sirket_ismi = 'NOKIA';
select * from toptancilar;

-- SORU3: vergi_no’su 201 olan toptancinin
-- sirket_ismi'ni 'nokia' ve irtibat_ismi’ni 'Canan Can' olarak güncelleyiniz.
UPDATE toptancilar SET sirket_ismi='Nokia',irtibat_ismi='Canan Can' WHERE vergi_no=201;

-- SORU4: sirket_ismi nokia olan toptancinin
-- irtibat_ismi'ni 'Bilal Han' olarak güncelleyiniz.
UPDATE toptancilar SET irtibat_ismi='Bilal Han' WHERE sirket_ismi='Nokia'; 

-- SORU5: malzemeler tablosundaki 'Telefon' değerlerini 'Phone' olarak güncelleyiniz.
UPDATE malzemeler SET malzeme_isim='Phone' WHERE malzeme_isim='Telefon';

-- SORU6: malzemeler tablosundaki malzeme_id değeri 1004'ten büyük olanların
-- malzeme_id'lerini 1 artırarak güncelleyiniz.
UPDATE malzemeler SET malzeme_id=malzeme_id+1 WHERE malzeme_id>1004;

-- SORU7: malzemeler tablosundaki tüm malzemelerin malzeme_id değerini ted_vergino ile toplayarak güncelleyiniz.
UPDATE malzemeler SET malzeme_id=malzeme_id+ted_vergino;

-- SORU8: Malzemeler tablosundaki musteri_isim'i Ali Can olan malzeme_isim'ini,
-- toptancılar  tablosunda irtibat_ismi 'Adem Coş' olan sirket_ismi ile güncelleyiniz.
UPDATE malzemeler SET malzeme_isim=(SELECT sirket_ismi FROM toptancilar WHERE irtibat_ismi='Adem Cos') WHERE musteri_isim='Ali Can';

-- SORU9: malzeme_ismi Laptop olan musteri_isim'ini,
-- sirket_ismi Apple’in irtibat_isim'i ile güncelleyiniz.
UPDATE malzemeler SET musteri_isim=(SELECT irtibat_ismi FROM toptancilar WHERE sirket_ismi='Apple') WHERE malzeme_isim='Laptop';

