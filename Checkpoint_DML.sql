-- Checkpoint portant sur la partie insertion de notre base de données Livraison

--Produits:
--ProductID = 1, Name = "Cookies", Price = 10, Category = "Snacks"
--ProductID = 2, Name = "Candy", Price = 5.2, Category = "Sweets"
--ProductID = 3, Name = "Chips", Price = 8.5, Catégorie = "Snacks"
--ProductID = 4, Nom = "Juice", Prix = 15, Catégorie = "Beverages"
--ProductID = 5, Nom = "Ice Cream", Prix = 12, Catégorie = "Desserts"

--Clients :
--CustomerID = 1, Name = "Ahmed", Address = "Tunisia"
--CustomerID = 4, Nom = "Yasmine", Adresse = "Maroc"

--Commandes :
--OrderID = 1, CustomerID = 1, ProductID = 2, Quantity = 3, Order Date = 2023-01-22
--OrderID = 3, CustomerID = 3, ProductID = 4, Quantité = 5, Date de commande = 2023-06-10

-- Nous remarquons à travers les données à inséré qu'il faudrait ajouter ou retirer de nouvelles colonnes .

  -- Au niveau de la table Produits
ALTER TABLE Produits 
ADD Names VARCHAR(15) NOT NULL  ;

ALTER TABLE Produits 
ADD Category VARCHAR(15) NOT NULL ;  

  -- Au niveau de la table Clients
ALTER TABLE Clients
DROP COLUMN tel_du_client ;

ALTER TABLE Clients 
ADD Adress VARCHAR(15) NOT NULL ;

  -- Au niveau de la table Commandes
ALTER TABLE Commandes 
DROP COLUMN Total_Amount ;

ALTER TABLE Commandes 
ADD Order_date DATE ;

-- N.B : Cette étape a été effectué avant la question 1 .
  
-- 1) Écriture des requêtes SQL appropriées pour insérer tous les enregistrements fournis dans leurs tables correspondantes.

-- Insertion Table Produits

SET IDENTITY_INSERT Produits ON;

INSERT INTO Produits (Product_Id,Names,Prix,Category)
VALUES (1,'Cookies',10,'Snacks'),
       (2,'Candy',5.2,'Sweets'),
	   (3,'Chips',8.5,'Snacks'),
	   (4,'Juice',15,'Beverages'),
	   (5,'Ice cream',12,'Desserts');

SET IDENTITY_INSERT Produits OFF;


-- Insertion Table Clients
SET IDENTITY_INSERT Clients ON;

INSERT INTO Clients(Customer_Id,nom_du_client,Adress)

VALUES (1,'Ahmed','Tunisia'),
       (4,'Yasmine','Maroc');

SET IDENTITY_INSERT Clients OFF;



--Insertion Table Commandes

ALTER TABLE Commandes NOCHECK CONSTRAINT FK_Commandes_Clients;

-- Insérer les donnees sans validation de la clé étrangère
INSERT INTO Commandes (Order_Id, Customer_Id, Product_Id, Quantity, Order_date)
VALUES (1, 1, 2, 3, '2023-01-22'),
       (3, 3, 4, 5, '2023-06-10');

-- Réactiver la contrainte
ALTER TABLE Commandes CHECK CONSTRAINT FK_Commandes_Clients;


-- Nous avons utiliser l'option SET IDENTITY_INSERT dans chaque table afin de desactivé l'incrementation des I_d .


-- 2) Mise des données dans la table Commandes 

  -- Nous allons utiliser la commande UPDATE 

  UPDATE Commandes 
  SET Quantity = 6
  WHERE Order_Id = 3
