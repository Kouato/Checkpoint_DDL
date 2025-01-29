1)/* A la question 1 il serait preferable de commencer d'abord par crr�er les tables avec les scripts existants ensuite
    passer aux contraintes au bas de la page et enfin les insertions des valeurs et les mises � jour avec les UPDATES .
  */

2) --La question 2 ram�ne � la question 3 jusqu'� la question 11

3)
  
 SELECT EMPLOYEE_NUMBER AS "Num�ro d'employ�" ,
        LAST_NAME AS "PRENOM" ,
		FIRST_NAME AS "NOM" ,
		DATEDIFF(YEAR, BIRTH_DATE, GETDATE()) AS "Age"  ,
		DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS "Anci�nnet�"
 FROM EMPLOYEES 
 WHERE (ISNULL(SALARY,0)+ISNULL(COMMISSION,0)) > 8000 AND TITLE IN ('Dr.','Mr.','Mrs.')
 ORDER BY DATEDIFF(YEAR, HIRE_DATE, GETDATE()) DESC

4)
 SELECT PRODUCT_REF AS "Num�ro du produit" ,
       PRODUCT_NAME AS "Nom du produit " ,
	   SUPPLIER_NUMBER AS "Num�ro du fournisseur" ,
	   UNITS_ON_ORDER AS "Unit�s command�es" ,
	   UNIT_PRICE AS "Prix unitaire"

  FROM PRODUCTS 

  WHERE QUANTITY LIKE '%bottles%'
        AND SUBSTRING(PRODUCT_NAME, 3, 1) IN ('t', 'T') -- Verification des caract�res t OU T 
	    AND SUPPLIER_NUMBER IN (1,2,3)
	    AND UNIT_PRICE BETWEEN 70 AND 200
	    AND UNITS_ON_ORDER IS NOT NULL

5) 

SELECT * 
FROM CUSTOMERS 
WHERE SUBSTRING(POSTAL_CODE, LEN(POSTAL_CODE)-2,3) IN (SELECT SUBSTRING(POSTAL_CODE, LEN(POSTAL_CODE)-2,3) -- Condition sur les trois derniers caract�res
FROM SUPPLIERS
WHERE SUPPLIER_NUMBER = 1 
)
   
 -- Seconde partie 
 
 SELECT  ORDER_NUMBER , (UNIT_PRICE*QUANTITY) AS "Montant_Total",
        
    CASE 
	    WHEN ORDER_NUMBER BETWEEN 10998 AND 11003 THEN 
		  CASE 
	        WHEN UNIT_PRICE*QUANTITY BETWEEN 0 AND 2000 THEN 0
		    WHEN UNIT_PRICE*QUANTITY BETWEEN 2001 AND 10000 THEN 5
		    WHEN UNIT_PRICE*QUANTITY BETWEEN 40001 AND 80000 THEN 10
	        ELSE 20
          END 
	    ELSE NULL 
    END AS "Nouveau taux de remise" ,

	CASE
	
	   WHEN ORDER_NUMBER BETWEEN 10000 AND 10997 THEN 'Appliquer lancien taux de remise'
	   ELSE 'Appliquer le nouveau taux de remise '

	END AS "Message d'application"

FROM ORDER_DETAILS


6) 
   SELECT s.SUPPLIER_NUMBER AS "Numero du fournisseur" , s.COMPANY AS " Soci�t� " , s.ADDRESS AS "Adresse" , s.PHONE AS "Num�ro de t�l�phone"
   FROM CATEGORIES c
   INNER JOIN PRODUCTS p ON c.CATEGORY_CODE = p.CATEGORY_CODE 
   INNER JOIN SUPPLIERS s ON p.SUPPLIER_NUMBER = s.SUPPLIER_NUMBER
   WHERE c.CATEGORY_NAME = 'Beverages'

7) 
   SELECT cu.CUSTOMER_CODE AS "Code client" , cu.CITY AS " Ville " , c.CATEGORY_NAME AS " Type produit " , od.QUANTITY AS "Quantit� command�"
   FROM CATEGORIES c
   INNER JOIN PRODUCTS p ON c.CATEGORY_CODE = p.CATEGORY_CODE 
   INNER JOIN ORDER_DETAILS od ON p.PRODUCT_REF = od.PRODUCT_REF
   INNER JOIN ORDERS o ON od.ORDER_NUMBER = o.ORDER_NUMBER
   INNER JOIN CUSTOMERS cu ON o.CUSTOMER_CODE = cu.CUSTOMER_CODE
   WHERE c.CATEGORY_NAME = 'Desserts' AND od.QUANTITY IN (0,1) 
         AND cu.CITY = 'Berlin'


8)

SELECT
    c.CUSTOMER_CODE AS "Num�ro client ",
	c.COMPANY AS "Nom de la soci�t�" ,
	c.PHONE AS "Numero de telephone ",
	SUM(od.UNIT_PRICE*QUANTITY) AS "Montant Total ",
	c.COUNTRY AS "Pays",
    CONVERT(DATE, ORDER_DATE) AS "Date pr�cise",
    DATENAME(WEEKDAY, o.ORDER_DATE) AS "Jour correspondant"
FROM ORDERS o
LEFT JOIN CUSTOMERS c ON o.CUSTOMER_CODE = c.CUSTOMER_CODE
LEFT JOIN ORDER_DETAILS od ON o.ORDER_NUMBER = od.ORDER_NUMBER

WHERE 
    o.ORDER_DATE >= '1998-04-01' AND o.ORDER_DATE <= '1998-04-30' -- Filtre pour le mois d'avril 1998
    AND DATENAME(WEEKDAY, o.ORDER_DATE) = 'Monday' -- Filtre pour les lundis
	AND c.COUNTRY = 'France'
GROUP BY 
    CONVERT(DATE, o.ORDER_DATE), -- Grouper par date pour le total pour chaque lundi
    DATENAME(WEEKDAY, o.ORDER_DATE),
	c.CUSTOMER_CODE,
	c.COMPANY,
	c.PHONE,
	c.COUNTRY


9)

SELECT c.CUSTOMER_CODE AS "Code client",
       c.COMPANY AS "Nom de la soci�t�",
	   c.PHONE AS "Numero de telephone",
       COUNT(DISTINCT od.PRODUCT_REF)AS "Nombre de produits command�s"
FROM CUSTOMERS c 
INNER JOIN ORDERS o ON c.CUSTOMER_CODE = o.CUSTOMER_CODE 
INNER JOIN ORDER_DETAILS od ON o.ORDER_NUMBER = od.ORDER_NUMBER
GROUP BY 
    c.CUSTOMER_CODE,
	c.COMPANY,
	c.PHONE
HAVING 
    COUNT(DISTINCT od.PRODUCT_REF) = (SELECT COUNT(*) FROM Products);

10)

SELECT c.CUSTOMER_CODE AS " Code client " ,
       COUNT(DISTINCT od.ORDER_NUMBER) AS "Nombre totale de commandes "
FROM CUSTOMERS c 
INNER JOIN ORDERS o ON c.CUSTOMER_CODE = o.CUSTOMER_CODE
INNER JOIN ORDER_DETAILS od ON o.ORDER_NUMBER = od.ORDER_NUMBER
WHERE c.COUNTRY = 'France'
GROUP BY c.CUSTOMER_CODE
  
11) 

SELECT 
    COUNT(CASE WHEN YEAR(ORDER_DATE) = 1996 THEN 1 END) AS " commandes en 1996 ", -- Nombre de commandes en 1996
    COUNT(CASE WHEN YEAR(ORDER_DATE) = 1997 THEN 1 END) AS "commandes en 1997", -- Nombre de commandes en 1997
    COUNT(CASE WHEN YEAR(ORDER_DATE) = 1997 THEN 1 END) - COUNT(CASE WHEN YEAR(ORDER_DATE) = 1996 THEN 1 END) AS "difference" -- Diff�rence entre les deux
FROM Orders  