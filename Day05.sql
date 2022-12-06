drop table if exists personel
drop table if exists personel_bilgi
CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
	CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

DELETE FROM personel;

-- Isme gore toplam maaslari bulun
SELECT isim, SUM(maas) FROM personel GROUP BY isim;

-- Personel tablosundaki isimleri gruplayiniz
SELECT isim from personel
GROUP BY isim;

-- Sehire gore personel sayisini yazdir
SELECT sehir, COUNT(isim) AS sayi FROM personel GROUP BY sehir ORDER BY sayi DESC;

-- Sirketlere gore maasi 5000'den fazla olan personel sayisini bulun
SELECT sirket, COUNT(isim) FROM personel WHERE maas>5000 GROUP BY sirket;

--------------------------------------------------

-- HAVING KULLANIMI
/*
Having komutu yanlizca GROUP BY komutu ile kullanilir.
Eger gruplamadan sonra bir sart varsa having komutu kullanilir
*/
-- HAVING, AGGREGATE FUNCTION’lar ile birlikte kullanilan FILTRELEME komutudur.

-- Her sirketin MIN maaslarini eger 2000'den buyukse goster
SELECT sirket,MIN(maas) AS en_dusuk_maas FROM personel GROUP BY sirket HAVING MIN(maas)>4000;

-- Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gosteren sorgu yaziniz
SELECT isim,SUM(maas) FROM personel GROUP BY isim HAVING SUM(maas)>10000;

-- Eger bir sehirde calisan personel sayisi 1'den coksa sehir ismini ve personel sayisini veren sorgu yaziniz
SELECT sehir,COUNT(isim) FROM personel GROUP BY sehir HAVING COUNT(isim)>1;

-- Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz
SELECT sehir,MAX(maas) FROM personel GROUP BY sehir HAVING MAX(maas)<5000;

--------------------------------------------------

-- UNION OPERATOR
-- Iki farkli sorgulamanin sonucunu birlestiren islemdir. Secilen Field SAYISI ve DATA TYPE’i ayni olmalidir

-- Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan
-- sehirleri gosteren sorguyu yaziniz
SELECT isim,maas FROM personel WHERE maas>4000 
UNION 
SELECT sehir,maas FROM personel WHERE maas>5000;

--  Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
-- bir tabloda gosteren sorgu yaziniz
SELECT isim,maas FROM personel WHERE isim='Mehmet Ozturk'
UNION
SELECT sehir,maas FROM personel WHERE sehir='Istanbul';

-- Sehirlerden odenen ucret 3000’den fazla olanlari ve personelden ucreti 5000’den az
-- olanlari bir tabloda maas miktarina gore sirali olarak gosteren sorguyu yaziniz
SELECT sehir,maas FROM personel WHERE maas>3000
UNION
SELECT isim,maas FROM personel WHERE maas<5000;

CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int
);
INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

-- id’si 12345678 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi
-- tablosundan da tel ve cocuk sayisini yazdirin
SELECT sehir AS Sehir_tel ,maas AS cocuk_sayisi_veya_maas FROM personel WHERE id='123456789'
UNION
SELECT tel,cocuk_sayisi FROM personel_bilgi WHERE id= '123456789';

--------------------------------------------------

-- UNION ALL OPERATOR
-- UNION islemi 2 veya daha cok SELECT isleminin sonuc KUMELERINI birlestirmek icin kullanilir,
-- Ayni kayit birden fazla olursa, sadece bir tanesini alir.
-- UNION ALL ise tekrarli elemanlari, tekrar sayisinca yazar

-- Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
SELECT isim,maas FROM personel WHERE maas<5000;

--  Ayni sorguyu UNION ile iki kere yazarak calistirin
SELECT sehir,maas FROM personel WHERE maas<5000
UNION
SELECT sehir,maas FROM personel WHERE maas<5000;

-- Ayni sorguyu UNION ALL ile iki kere yazarak calistirin
SELECT sehir,maas FROM personel WHERE maas<5000
UNION ALL
SELECT sehir,maas FROM personel WHERE maas<5000;

--------------------------------------------------

-- INTERSECT OPERATOR

-- Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
SELECT id FROM personel WHERE sehir IN ('Istanbul','Ankara');

-- Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
SELECT id FROM personel_bilgi WHERE cocuk_sayisi IN (2,3);

-- Iki sorguyu INTERSECT ile birlestirin
SELECT id FROM personel WHERE sehir IN ('Istanbul','Ankara')
INTERSECT
SELECT id FROM personel_bilgi WHERE cocuk_sayisi IN (2,3);

-- Maasi 4800’den az olanlar veya 5000’den cok olanlarin id’lerini listeleyin
SELECT id FROM personel WHERE maas>5000 OR maas<4800;

-- Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
SELECT id FROM personel_bilgi WHERE cocuk_sayisi IN (2,3);

-- Iki sorguyu INTERSECT ile birlestirin
SELECT id FROM personel WHERE maas>5000 OR maas<4800
INTERSECT
SELECT id FROM personel_bilgi WHERE cocuk_sayisi IN (2,3);

-- Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
SELECT isim FROM personel WHERE sirket='Honda'
INTERSECT
SELECT isim FROM personel WHERE sirket='Ford'
INTERSECT
SELECT isim FROM personel WHERE sirket='Tofas';

--------------------------------------------------

-- EXCEPT OPERATOR

-- 5000’den az maas alip Honda’da calismayanlari yazdirin
SELECT isim,sirket FROM personel WHERE maas<5000
EXCEPT
SELECT isim,sirket FROM personel WHERE sirket='Honda';

-- Ismi Mehmet Ozturk olup Istanbul’da calismayanlarin isimlerini ve sehirlerini listeleyin
SELECT isim,sehir FROM personel WHERE isim='Mehmet Ozturk'
EXCEPT
SELECT isim,sehir FROM personel WHERE sehir='Istanbul';
