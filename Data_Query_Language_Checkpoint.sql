1)
  SELECT c.nom_du_client , SUM(p.Prix*co.Quantity) AS "coût total"
  FROM Clients c 
  INNER JOIN Commandes co ON c.Customer_Id = co.Customer_Id
  INNER JOIN Produits p ON co.Product_Id = p.Product_Id
  WHERE co.Product_Id IN(1,2)
  GROUP BY  c.nom_du_client
  HAVING COUNT(DISTINCT p.Product_Id) = 2   /* Ceci afin d'etre rassurer que les noms respecterons la condition qui est à la fois deux produits */

2)
  SELECT c.nom_du_client , SUM(p.Prix*co.Quantity) AS "coût total"
  FROM Clients c 
  INNER JOIN Commandes co ON c.Customer_Id = co.Customer_Id
  INNER JOIN Produits p ON co.Product_Id = p.Product_Id
  WHERE co.Product_Id = 2
  GROUP BY c.nom_du_client

3)
  SELECT c.nom_du_client , SUM(p.Prix*co.Quantity) AS "coût total"
  FROM Clients c 
  INNER JOIN Commandes co ON c.Customer_Id = co.Customer_Id
  INNER JOIN Produits p ON co.Product_Id = p.Product_Id
  WHERE co.Product_Id = 5
  GROUP BY  c.nom_du_client

4)  
SELECT 
  co.Customer_Id,
  SUM(CASE WHEN co.Product_Id = 1 THEN co.Quantity ELSE 0 END) AS "Nombre de biscuits commandés",
  SUM(CASE WHEN co.Product_Id = 2 THEN co.Quantity ELSE 0 END) AS "Nombre de bonbons commandés",
  SUM(CASE WHEN co.Product_Id = 1 THEN p.Prix * co.Quantity ELSE 0 END) AS "Coût total biscuits",
  SUM(CASE WHEN co.Product_Id = 2 THEN p.Prix * co.Quantity ELSE 0 END) AS "Coût total bonbons",
  SUM(p.Prix * co.Quantity) AS "Coût total global"
FROM Commandes co
INNER JOIN Produits p  
  ON co.Product_Id = p.Product_Id
WHERE co.Product_Id IN (1, 2)
GROUP BY co.Customer_Id;

5) 
  WITH Nombre_commande_parclient AS (

  SELECT c.nom_du_client , COUNT(co.Order_Id) AS "Nombre_de_commandes"
  FROM Clients c 
  LEFT JOIN Commandes co ON c.Customer_Id = co.Customer_Id 
  GROUP BY c.nom_du_client 
  
  )

SELECT nom_du_client , Nombre_de_commandes AS "Commande _Max"
FROM Nombre_commande_parclient
WHERE Nombre_de_commandes = ( SELECT MAX(Nombre_de_commandes)
      FROM Nombre_commande_parclient
      );
  
6)
  WITH Produits_Commander AS (
SELECT p.Names , COUNT(co.Product_Id) AS "Nombre_commande" , SUM(co.Quantity) AS "Quantité_Totale_commander" 
FROM Commandes co
INNER JOIN Produits p ON co.Product_Id = p.Product_Id
GROUP BY co.Product_Id , p.Names
)

SELECT Names , Quantité_Totale_commander
FROM Produits_Commander
WHERE Nombre_commande = (SELECT MAX(Nombre_commande)
       FROM Produits_Commander
	   );

7)
  WITH Commandes_Par_Jour AS (
  SELECT 
    co.Customer_Id,
    DATEPART(dw,co.Order_date) AS Jour_Semaine,
    COUNT(co.Order_Id) AS Nombre_Commandes_Par_Jour
  FROM Commandes co
  GROUP BY co.Customer_Id, DATEPART(dw,co.Order_date)
),
  Clients_Tous_Jours AS (
  SELECT 
    Customer_Id
  FROM Commandes_Par_Jour
  GROUP BY Customer_Id
  HAVING COUNT(DISTINCT Jour_Semaine) = 7
)
  SELECT 
    c.nom_du_client ,
    COUNT(co.Order_Id) AS Nombre_Total_Commandes
  FROM Clients c
  INNER JOIN Commandes co ON c.Customer_Id = co.Customer_Id
  WHERE c.Customer_Id IN (SELECT Customer_Id FROM Clients_Tous_Jours)
  GROUP BY c.Customer_Id, c.nom_du_client;









