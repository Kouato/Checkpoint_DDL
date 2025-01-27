/* 1) Les entités , relations et les attributs

     Entités , attributs :
	  -- Wine (NumW,Category,Year,Degree)
	  -- Producer(NumP,FirstName,LastName,Region)
	  -- Harvest(NumW,NumP,Quantity)
 
   2) Modèle relationel :
   
     -- Wine (NumW,Category,Years,Degree)..(1..N) , NumW : Clé primaire
	 -- Producer(NumP,FirstName,LastName,Region)..(0..N) , NumP : Clé secondaire
	 -- Harvest(Harvest_Id,#NumW,#NumP,Quantity) Table d'association

   *** ETAPE 2 ***

    Mise en oeuvre du modèle relationnel .
 */
   
  CREATE DATABASE ProductWine ;
  GO 

  USE ProductWine ;
  GO

  CREATE TABLE Wine (
  
     NumW INT PRIMARY KEY   ,
	 Category VARCHAR(15) NOT NULL ,
	 Years INT NOT NULL ,
	 Degree DECIMAL NOT NULL ,
  );

  CREATE TABLE Producer (
  
     NumP INT PRIMARY KEY  ,
	 FirstName VARCHAR(15) NOT NULL ,
	 LastName VARCHAR(15) NOT NULL ,
	 Region VARCHAR(15) NOT NULL ,
  );

  CREATE TABLE Harvest (
  
     Harvest_Id VARCHAR(5) PRIMARY KEY  ,
	 NumW INT NOT NULL ,
	 NumP INT NOT NULL ,
	 Quantity INT NOT NULL,
	 CONSTRAINT FK_Harvest_Wine FOREIGN KEY (NumW) REFERENCES Wine (NumW),
	 CONSTRAINT FK_Harvest_Producer FOREIGN KEY (NumP) REFERENCES Producer (NumP),
  );

/* **** ETAPE 3 *** 
 SIMULATION DES DONNEES 
*/

INSERT INTO Wine(NumW,Category,Years,Degree)
VALUES (1,'Rouge',2011,12),
       (2 ,'Blanc',2010,13),
	   (3,'Blanc', 2013,15),
	   (4,'Rouge',2016,11.5),
	   (5,'Rose', 2022, 16),
	   (6,'Sparkling', 2010 ,14.5),
	   (7,'Sparkling',2010,13.5),
	   (8,'Rose',2016,15),
	   (9,'Rouge',2013,13.5),
	   (10,'Sparkling',2022,13),
	   (11,'Rouge',2016,12),
	   (12,'Blanc',2013,13);

INSERT INTO Producer (NumP,FirstName,LastName,Region)
VALUES  (1,'Kpassagnon','Gilbert' ,'Sousse'),
        (2,'Droh','Soumahoro', 'Tunis'),
		(3,'Ettien', 'Brou' , 'Tunis'),
		(4,'Soro','Dogafol','Sousse'),
		(5,'Koukougnon','Matthieu', 'SFAX'),
		(6,'Mabea','Jean', 'Monastir'),
		(7,'Dekao', 'Ange', 'SFAX'),
		(8,'Mao','Glofié ', 'Sousse'),
		(9,'Kouakou','Aude','Monastir'),
		(10,'Rene','Henri','Tunis'),
		(11,'Meda','Alphonse', 'SFAX'),
		(12,'Kalou','Loua','Monastir');

INSERT INTO Harvest (Harvest_Id, NumW,NumP,Quantity)
VALUES ('ld12',1,1,150),
       ('mk11',2,2,205),
	   ('kg13',3,3,167),
	   ('dc45',4,4,98),
	   ('ty25',5,5,250),
	   ('li56',6,6,300),
	   ('cb15',7,7,75),
	   ('aq36',8,8,162),
	   ('sf45',9,9,350),
	   ('hg12',10,10,40),
	   ('qs14',11,11,79),
	   ('op56',12,12,120);


/* ********* ETAPE 4 ************
 Ecriture des requetes SQL .

1) SELECT * 
   FROM Producer

2) SELECT *  
   FROM Producer
   ORDER BY FirstName

3) SELECT *
   FROM Producer
   WHERE Region = 'Sousse'

4)

SELECT w.NumW AS " Numero de vin " , h.Quantity AS "Quantité Totale"
FROM Wine w
INNER JOIN Harvest h ON w.NumW = h.NumW 
WHERE w.NumW = 12 ;

5)

SELECT DISTINCT Category , SUM(Quantity) AS "Quantité par Categorie"
FROM Wine w 
INNER JOIN Harvest h ON w.NumW = h.NumW 
GROUP BY w.Category 

6)
  SELECT p.FirstName , p.LastName , h.Quantity 
FROM Producer p
INNER JOIN Harvest h ON p.NumP = h.NumP
WHERE (h.Quantity > 300 AND p.Region = 'Sousse')

7)
  SELECT DISTINCT w.Degree , w.Category , p.FirstName AS "Nom du producteur" 
FROM Wine w
INNER JOIN Harvest h ON w.NumW = h.NumW 
INNER JOIN Producer p ON h.NumP = p.NumP
WHERE   Degree > 12 

8) SELECT p.FirstName , p.LastName , h.Quantity AS "Quantité produite"
FROM Producer p
INNER JOIN Harvest h ON p.NumP = h.NumP
WHERE Quantity IN (SELECT MAX(Quantity) FROM Harvest )

9) 
SELECT AVG(Degree) AS " Moyenne de degré de vin produit "
FROM Wine

10)
   SELECT DISTINCT Category AS "Nom du Vin" , Years AS "Année de production"
   FROM Wine 
   WHERE Years IN (SELECT MIN(Years) FROM Wine )

11)
   SELECT p.FirstName  , p.LastName , h.Quantity AS " Qauntité totale produite par producteur"
   FROM Producer p
   INNER JOIN Harvest h ON p.NumP = h.NumP
   WHERE Quantity IN (SELECT  SUM(Quantity) FROM Harvest GROUP BY NumP)

12)
   SELECT w.Category AS "Categorie de Vin", w.Degree AS Degrée ,
       p.FirstName AS "Nom du producteur", p.LastName AS "Prenom du producteur",p.Region AS "Region du producteur"
FROM Wine w 
INNER JOIN Harvest h ON w.NumW = h.NumW
INNER JOIN Producer p ON h.NumP = p.NumP


*/


    
