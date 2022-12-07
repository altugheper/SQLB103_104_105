-- JOINS
/*
2 Tablodaki datalari Birlestirmek icin kullanilir.
Su ana kadar gordugumuz Union,Intersect ve Minus sorgu sonuclari icin kullanilir
Tablolar icin ise JOIN kullanilir
5 Cesit Join vardir
1) INNER JOIN iki Tablodaki ortak datalari gosterir
2) LEFT JOIN Ilk datada olan tum recordlari gosterir
3) RIGHT JOIN Ikinci tabloda olan tum recordlari gosterir
4) FULL JOIN Iki tablodaki tum recordlari gosterir
5) SELF JOIN Bir tablonun kendi icinde Join edilmesi ile olusur.
*/

-- INNER JOINS

CREATE TABLE sirketler
(
sirket_id int,
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota');
INSERT INTO sirketler VALUES(101, 'Honda');
INSERT INTO sirketler VALUES(102, 'Ford');
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler
(
siparis_id int,
sirket_id int,
siparis_tarihi date
);
INSERT INTO siparisler VALUES(11, 101,
'17-Apr-2020');
INSERT INTO siparisler VALUES(22, 102,
'18-Apr-2020');
INSERT INTO siparisler VALUES(33, 103,
'19-Apr-2020');
INSERT INTO siparisler VALUES(44, 104,
'20-Apr-2020');
INSERT INTO siparisler VALUES(55, 105,
'21-Apr-2020');

-- Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi FROM sirketler
INNER JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;

/*
NOT :
1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
*/

--------------------------------------

-- LEFT JOINS

-- Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi FROM sirketler
LEFT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;

/*
NOT :
1) Left Join’de ilk tablodaki tum record’lar gosterilir.
2) Ilk tablodaki datalara 2.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir ancak
ortak olmayan datalar icin o kisimlar bos kalir
3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu istedigimize karar verip once onu yazmaliyiz
*/

--------------------------------------

-- RIGHT JOINS

-- Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi FROM sirketler
RIGHT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;

/*
NOT :
1)Right Join’de ikinci tablodaki tum record’lar gosterilir.
2)Ikinci tablodaki datalara 1.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir
ancak ortak olmayan datalar icin o kisimlar bos kalir
*/

--------------------------------------

-- FULL JOINS

-- Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi FROM sirketler
FULL JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;

/*
NOT :
1) FULL Join’de iki tabloda var olan tum record’lar gosterilir.
2) Bir tabloda olup otekinde olmayan data’lar bos kalir
*/

--------------------------------------

-- SELF JOINS
drop table if exists personel
CREATE TABLE personel
(
id int,
isim varchar(20),
title varchar(60),
yonetici_id int
);
INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4);
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);

-- Her personelin yanina yonetici ismini yazdiran bir tablo olusturun
SELECT isim FROM personel
SELECT p1.isim,p2.isim FROM personel p1 INNER JOIN personel p2 ON p1.yonetici_id=p2.id;

--------------------------------------

-- LIKE CONDITION

/*
LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
imkani verir.
1) % => 0 veya birden fazla karakter belirtir
*/

drop table if exists musteriler
CREATE TABLE musteriler
(
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musteriler (id, isim, gelir) VALUES (1001, 'Ali', 62000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1002, 'Ayse', 57500);
INSERT INTO musteriler (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1004, 'Fatma', 42000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1005, 'Kasim', 44000);

-- Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim LIKE'A%';

/*
LIKE kullanımında büyük küçük harf gözetmeksizin sonuç almak istersek ILIKE kullanırız
LIKE yerine ~~ sembollerini kullanabiliriz
*/
SELECT * FROM musteriler WHERE isim LIKE 'A%';
SELECT * FROM musteriler WHERE isim ~~* 'A%';

-- Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT gelir FROM musteriler WHERE isim LIKE '%e';

-- Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler WHERE isim LIKE '%er%';

-- 2) _ => sadece bir karakteri gosterir.

-- Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim ~~ '_atma';

-- Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim ~~ '_a%';

-- Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim ~~ '__s%';

-- Ucuncu harfi s olan ismi 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim LIKE '__s_';

--  Ilk harfi F olan en az 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim LIKE 'F___%';

-- Ikinci harfi a,4.harfi m olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim LIKE '_a_m%';

/*
3) REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir
*/

CREATE TABLE kelimeler
(
id int UNIQUE,
kelime varchar(50) NOT NULL,
Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);
INSERT INTO kelimeler VALUES (1002, 'hat', 3);
INSERT INTO kelimeler VALUES (1003, 'hit', 3);
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
INSERT INTO kelimeler VALUES (1008, 'hct', 3);
INSERT INTO kelimeler VALUES (1005, 'adem', 4);
INSERT INTO kelimeler VALUES (1006, 'selim', 5);
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);

-- Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ 'h[ai]t';

-- Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ 'h[a-k]t';

-- a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ '^[as]';

--  m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ '[mf]$';

--------------------------------------

-- NOT LIKE CONDITION

-- ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime NOT LIKE 'h%';

-- a harfi icermeyen kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime NOT LIKE '%a%';

--  ikinci ve ucuncu harfi ‘de’ olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime NOT LIKE '_de%';

-- 2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime !~ '[_eio]';

/*
LIKE: Sorgulama yaparken belirli patternleri(Kalıp ifadelerle sorgu) kullanabilmezi sağlar
ILIKE: Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir.
LIKE = ~~
ILIKE = ~~*
NOT LIKE = !~~
NOT ILIKE = !~~*
NOT REGEXP_LIKE = !~*
NOT REGEXP_LIKE = !~
*/

--------------------------------------

-- UPPER – LOWER - INITCAP
-- Tablolari yazdirirken buyuk harf, kucuk harf veya ilk harfleri buyuk digerleri
-- kucuk harf yazdirmak icin kullaniriz

-- Kelimeler tablosundaki kelime sutununda verileri once hepsi buyuk harf, sonra hepsi kucuk harf ve ilk harfleri
-- buyuk harf olucak sekilde yazdiralim
SELECT UPPER(kelime) AS kelime FROM kelimeler -- Hepsi buyuk
SELECT LOWER(kelime) AS kelime FROM kelimeler -- Hepsi kucuk
SELECT INITCAP(kelime) AS kelime FROM kelimeler -- Ilk harfleri buyuk