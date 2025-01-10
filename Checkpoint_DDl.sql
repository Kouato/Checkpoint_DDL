--Creation de la base de données

CREATE DATABASE Livraison ;
GO 

USE Livraison ;
GO

--- Creation des tables de la base de données "Livraison"

CREATE TABLE Clients (

  Customer_Id INT IDENTITY (1,1) PRIMARY KEY ,
  nom_du_client VARCHAR(20) NOT NULL ,
  tel_du_client VARCHAR(15) NOT NULL 
);

CREATE TABLE Produits (

   Product_Id INT IDENTITY (1,1) PRIMARY KEY , 
   Prix DECIMAL CHECK (Prix > 0) NOT NULL ,
);

CREATE TABLE Commandes (

   Order_Id INT IDENTITY (1,1) PRIMARY KEY ,
   Customer_Id INT NOT NULL ,
   Product_Id INT NOT NULL ,
   Quantity INT NOT NULL ,
   Total_Amount DECIMAL NOT NULL ,
   CONSTRAINT FK_Commandes_Clients FOREIGN KEY (Customer_Id) REFERENCES Clients(Customer_Id) ,
   CONSTRAINT FK_Commandes_Produits FOREIGN KEY (Product_Id) REFERENCES Produits(Product_Id) 
);
