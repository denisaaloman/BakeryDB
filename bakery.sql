use [BAKERY.2];
DROP TABLE IF EXISTS RECIPE_INGREDIENT;
DROP TABLE IF EXISTS ORDER_PRODUCT;
DROP TABLE IF EXISTS [ORDER];
DROP TABLE IF EXISTS [PRODUCT]

DROP TABLE IF EXISTS RECIPE_EQUIPMENT;
DROP TABLE IF EXISTS RECIPE;
DROP TABLE IF EXISTS INGREDIENT;

DROP TABLE IF EXISTS LOYALTY_CARD;
DROP TABLE IF EXISTS CLIENT;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS SUPPLIER;
DROP TABLE IF EXISTS EQUIPMENT;
DROP TABLE IF EXISTS CATEGORY;

CREATE TABLE SUPPLIER(
supplier_id INT PRIMARY KEY,
name_of_supplier VARCHAR(256),
name_of_ingredient VARCHAR(256),
day_for_suppliance INT
);

CREATE TABLE RECIPE(
recipe_id INT PRIMARY KEY,
name_of_recipe VARCHAR(256),
[description] VARCHAR(900) NOT NULL,
time_of_preparation INT
);

CREATE TABLE INGREDIENT(
ingredient_id INT PRIMARY KEY,
name_of_ingredient VARCHAR(256),
date_of_expiration DATE NOT NULL,
supplier_id INT,
FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id)
);

CREATE TABLE RECIPE_INGREDIENT(
recipe_id INT,
ingredient_id INT,
PRIMARY KEY (recipe_id, ingredient_id),
FOREIGN KEY (recipe_id) REFERENCES RECIPE(recipe_id),
FOREIGN KEY (ingredient_id) REFERENCES INGREDIENT(ingredient_id)
);

CREATE TABLE CATEGORY(
category_id INT PRIMARY KEY,
category_name VARCHAR(100)
);

CREATE TABLE [PRODUCT](
prod_id INT PRIMARY KEY,
name_product VARCHAR(256),
quantity INT,
price DECIMAL(10,2),
recipe_id INT UNIQUE,
category_id INT,
FOREIGN KEY (recipe_id) REFERENCES RECIPE(recipe_id),
FOREIGN KEY (category_id) REFERENCES CATEGORY(category_id)
);

CREATE TABLE CLIENT(
client_id INT, PRIMARY KEY(client_id),
[name] VARCHAR(256),
email VARCHAR(256)
);

CREATE TABLE [ORDER](
order_id INT PRIMARY KEY,
client_id INT,
quantity INT,
--total_price DECIMAL(10,2),
FOREIGN KEY (client_id) REFERENCES CLIENT(client_id)
);

CREATE TABLE ORDER_PRODUCT(
prod_id INT,
order_id INT,
PRIMARY KEY (order_id, prod_id),
FOREIGN KEY (order_id) REFERENCES [ORDER](order_id),
FOREIGN KEY (prod_id) REFERENCES [PRODUCT](prod_id)

);

CREATE TABLE LOYALTY_CARD(
card_id INT NOT NULL,
points INT,
client_id INT UNIQUE,
FOREIGN KEY (client_id) REFERENCES CLIENT(client_id)
);

CREATE TABLE EMPLOYEE(
employee_id INT PRIMARY KEY,
name_of_employee VARCHAR(256),
salary INT,
hire_date DATE,
category_id INT,
FOREIGN KEY (category_id) REFERENCES CATEGORY(category_id)
);

CREATE TABLE EQUIPMENT (
equipment_id INT PRIMARY KEY,
equipment_name VARCHAR(100),
type_of_equipment VARCHAR(50)
);
CREATE TABLE RECIPE_EQUIPMENT(
recipe_id INT,
equipment_id INT,
PRIMARY KEY (recipe_id, equipment_id),
FOREIGN KEY (recipe_id) REFERENCES RECIPE(recipe_id),
FOREIGN KEY (equipment_id) REFERENCES EQUIPMENT(equipment_id)
);

GO
--Insert data into SUPPLIER
INSERT INTO SUPPLIER (supplier_id, name_of_supplier, name_of_ingredient, day_for_suppliance)
VALUES
(1,'SweetSource','Sugar',12),
(2,'Golden Grain','Flour',15),
(3,'MilkyWay Dairy','Butter',4);

--Insert data into INGREDIENT
INSERT INTO INGREDIENT (ingredient_id, name_of_ingredient, date_of_expiration, supplier_id)
VALUES
(1,'Flour','2025-12-11',2),
(2,'Butter','2025-11-20',3),
(3,'Sugar','2025-11-30',1),
(4,'Eggs','2025-12-07',3);

/*
--Referential integrity violation (supplier_id=4 doesNT exist)
INSERT INTO INGREDIENT (ingredient_id, name_of_ingredient, date_of_expiration, supplier_id)
VALUES
(5,'Chocolate','2025-08-15',4);
*/

--Insert data into RECEPIE
INSERT INTO RECIPE (recipe_id, name_of_recipe, [description], time_of_preparation)
VALUES
(1,'Chocolate Cake Recepie','Put a simple dough (made with 5 tablespoons of cocoa) in the oven.The glaze is also made of chocolate.',90),
(2,'Croissant Recepie','Roll them and put in the oven. You can also add some sparkles after. So easy!!',60),
(3,'Pistachio Roll','Whisk eggs and sugar, fold in flour; layer cream, roll, chill, slice, serve.',100),
(4,'Homemade Dark Chocolate','Melt cocoa butter, mix cocoa powder and sugar, pour into molds, cool, set, enjoy.',100),
(5,'Cookie with Vanilla','Cream butter and sugar, mix in flour and chocolate chips, scoop, bake, cool.',20),
(6,'Cake with Vanilla and Raspberry Cream','Mix some whipp cream. Put it in the fridge for 12 hours.Put raspberries in it. Serve cold!',100),
(7,'Blueberry pudding','500 grams of blueberries mixed with some pudding powder. Add gelatine. Leave in the fridge for 12 hours.',15),
(8,'Vanilla Cupcake (Hawaian)','Mix flour, sugar, butter, eggs, vanilla; bake 20 minutes at 350°F; frost as desired',45),
(9,'Raspberry with Chocolate Donut','Flour, Salt Bake Bake Bake.',50);

INSERT INTO RECIPE_INGREDIENT (recipe_id,ingredient_id)
VALUES
(1,4),
(1,1),
(1,3),
(2,2),
(2,4),
(8,1),
(8,2),
(8,3),
(8,4);

--Insert data into CATEGORY
INSERT INTO CATEGORY (category_id, category_name)
VALUES
(1,'Cakes'),
(2,'Pastries'),
(3,'Cookies'),
(4,'Chocolate'),
(5,'Donuts'),
(6,'Ice Cream'),
(7,'Cupcakes'),
(8,'Muffins'),
(9,'Macarons'),
(10,'Puddings');

--Insert data into PRODUCT
INSERT INTO [PRODUCT] (prod_id, name_product, quantity, price, recipe_id, category_id)
VALUES
(1,'Chocolate Cake Slice',20,20.00,1,1),
(2,'Butter Croissant',30,5.00,2,2),
(3,'Pistachio Roll',20,31.00,3,2),
(4,'Vanilla Cookie',100,15.50,5,3),
(5,'Raspberry and Vanilla Cake Slice',20,19.00,6,1),
(6,'Local Dark Chocolate',50,32.00,4,4),
(7,'Hawaii Cupcake',35,18.00,8,7),
(8,'R&C Donut',20,19.00,9,5),
(9,'Blueberry Pudding Dream',15,14.00,7,10);

--Insert data into CLIENT
INSERT INTO CLIENT (client_id, [name], email)
VALUES
(1,'Ana-Maria Pop','anamariapop@gmail.com'),
(2,'Georgiana Ionescu','georgiionesc@yahoo.com'),
(3,'Andrei Mihai Popa','popaandrei2006@yahoo.com');

--Insert data into ORDER
INSERT INTO [ORDER] (order_id, client_id, quantity)
VALUES
(1,2,2), 
(2,1,10),
(3,2,1);

--Insert data into ORDER_PRODUCT
INSERT INTO ORDER_PRODUCT (order_id, prod_id)
VALUES
(1,2),
(2,1),
(2,3);
-- EQUIPMENT
INSERT INTO EQUIPMENT (equipment_id,equipment_name,type_of_equipment)
VALUES
(1,'Oven','Electric'),
(2,'Mixer','Metal'),
(3,'Refrigerator','Electric'),
(4,'Rolling Pin','Wood');
--Insert data into RECIPE_EQUIPMENT
INSERT INTO RECIPE_EQUIPMENT (recipe_id,equipment_id)
VALUES
(1,1),
(2,1),
(6,1),
(3,2),
(4,2),
(5,2),
(7,2),
(7,3),
(1,2),
(6,3),
(2,3);

--EMPLOYEE
INSERT INTO EMPLOYEE (employee_id,name_of_employee,salary,hire_date,category_id)
VALUES
(1,'John Wiliams',9000,'2000-01-24',2),
(2,'Lily Smith',4000,'2024-10-02',1),
(3,'Anna Jones',12500,'1996-06-06',9),
(4,'Michael Pop',7200,'2015-03-14',3),
(5,'Sophia Jones',8500,'1999-09-10',9),
(6,'Taylor Smith',5600,'2020-11-22',5),
(7,'Olivia Davis',6700,'2019-05-30',4),
(8,'Charlie Miller',9800,'2012-02-18',1),
(9,'Emma Garcia',4300,'2023-04-12',9),
(10,'Benjamin Lee',8900,'2010-06-25',10),
(11,'Mia Rodriguez',6400,'2017-07-03',5),
(12,'Ethan Hernandez',7800,'2014-08-19',1),
(13,'Charlotte Lopez',10200,'1980-11-11',7),
(14,'Noah Gonzalez',5800,'2022-01-16',1),
(15,'Amelia Wilson',9600,'2011-10-07',8),
(16,'Lucas Anderson',7500,'2016-09-20',9),
(17,'Isabella Thomas',4200,'2023-03-09',6),
(18,'Henry Moore',8700,'2009-12-29',7),
(19,'Ava Martin',6900,'2021-02-15', 6),
(20,'Daniel Thompson',15435,'1990-08-23',8);

--Update 

UPDATE [PRODUCT] 
SET price=25.50
WHERE price>=20 AND category_id=1; --cakes

UPDATE RECIPE
SET time_of_preparation=59
WHERE [description] IS NOT NULL AND name_of_recipe LIKE '%Vanilla%';

UPDATE SUPPLIER SET day_for_suppliance=2
WHERE supplier_id IN (1,2,3) AND day_for_suppliance<=10;

--Delete
DELETE FROM ORDER_PRODUCT
WHERE order_id IN (
    SELECT O.order_id
    FROM [ORDER] O
    WHERE O.quantity BETWEEN 1 AND 7
);

DELETE FROM RECIPE_INGREDIENT
WHERE ingredient_id IN (
    SELECT I.ingredient_id
    FROM INGREDIENT I
    WHERE I.date_of_expiration NOT BETWEEN '2025-12-01' AND '2025-12-31')


--UNION 
-- Select all product names where the product is a pastry (category 2) or has a time prep less than 60 min.

SELECT P.name_product
FROM [PRODUCT] P
WHERE P.category_id=2
UNION
SELECT P.name_product
FROM [PRODUCT] P, RECIPE R
WHERE R.recipe_id=P.recipe_id AND R.time_of_preparation<60;

--OR 
SELECT R.recipe_id, R.name_of_recipe
FROM RECIPE R
WHERE (R.name_of_recipe LIKE '%CAKE%' OR R.time_of_preparation>=100)

--
--INTERSECT
SELECT R.recipe_id, R.name_of_recipe
FROM RECIPE R
WHERE R.description LIKE '%flour%'
INTERSECT
SELECT R.recipe_id, R.name_of_recipe
FROM RECIPE R
WHERE R.time_of_preparation<>100

--IN
SELECT P.name_product 
FROM [PRODUCT] P
WHERE P.prod_id IN (SELECT P2.prod_id 
                    FROM [PRODUCT] P2 
                    WHERE P2.price > 20);
--
--EXCEPT 
--products not ordered (the id)
SELECT P.prod_id
FROM [PRODUCT] P
EXCEPT
SELECT OP.prod_id
FROM ORDER_PRODUCT OP;


--NOT IN
--Clients with no orders
SELECT C.name
FROM CLIENT C
WHERE C.client_id NOT IN (
    SELECT O.client_id
    FROM [ORDER] O
);

--joins
--emplyees and products in the same category
SELECT P.name_product, E.name_of_employee
FROM [PRODUCT] P
INNER JOIN CATEGORY C ON P.category_id=C.category_id
INNER JOIN EMPLOYEE E ON E.category_id=C.category_id

SELECT RI.recipe_id,RI.ingredient_id, RE.equipment_id
FROM  RECIPE_INGREDIENT RI
LEFT JOIN RECIPE_EQUIPMENT RE ON RI.recipe_id = RE.recipe_id
ORDER BY RI.recipe_id, RI.ingredient_id, RE.equipment_id;


SELECT C.client_id, C.[name], P.name_product
FROM [ORDER] O
RIGHT JOIN CLIENT C ON C.client_id=O.client_id 
RIGHT JOIN ORDER_PRODUCT OP ON OP.order_id=O.order_id
RIGHT JOIN [PRODUCT] P ON P.prod_id=OP.prod_id 

SELECT C.[name], O.order_id
FROM CLIENT C
FULL OUTER JOIN [ORDER] O ON C.client_id = O.client_id;

SELECT P.name_product
FROM [PRODUCT] P
WHERE P.category_id IN (
    SELECT C.category_id
    FROM CATEGORY C
    WHERE C.category_name='Cakes'
);
--client who ordered a product.price>=15
SELECT C.[name]
FROM CLIENT C
WHERE C.client_id IN (
      SELECT O.client_id
      FROM [ORDER] O
      WHERE O.order_id IN (
           SELECT OP.order_id
           FROM ORDER_PRODUCT OP
           WHERE OP.prod_id IN (
               SELECT P.prod_id
               FROM [PRODUCT] P
               WHERE P.price>=15.00
               )
           )
     );
--

SELECT C.email
FROM CLIENT C
WHERE EXISTS (
    SELECT *
    FROM [ORDER] O
    WHERE O.client_id = C.client_id
);

--name of suppl that supply at least one ingr that is used in a recipe
SELECT S.name_of_supplier AS name_supplier
FROM SUPPLIER S
WHERE EXISTS (
      SELECT*
      FROM INGREDIENT I
      WHERE I.supplier_id=S.supplier_id
      AND EXISTS (
         SELECT*
         FROM RECIPE_INGREDIENT RI
         WHERE RI.ingredient_id=I.ingredient_id)
      );  

--
SELECT ordered.name_product, ordered.price
FROM ( 
     SELECT P.category_id, P.price, P.name_product
     FROM [PRODUCT] P
     GROUP BY P.category_id, P.price,P.name_product) AS ordered
WHERE ordered.price >= 19.50


SELECT C.[name],totals.total_spent
FROM (
    SELECT O.client_id, SUM(O.quantity*P.price) AS total_spent
    FROM [ORDER] O
    INNER JOIN ORDER_PRODUCT OP ON O.order_id = OP.order_id
    INNER JOIN [PRODUCT] P ON P.prod_id=OP.prod_id
    WHERE P.price BETWEEN 2.50 AND 200
    GROUP BY O.client_id) AS totals
INNER JOIN CLIENT C ON C.client_id = totals.client_id
ORDER BY totals.total_spent DESC;



SELECT P.category_id, COUNT(*) AS num_products
FROM [PRODUCT] P
GROUP BY P.category_id;

--
SELECT O.client_id, SUM(O.quantity) AS total_quantity
FROM [ORDER] O
GROUP BY O.client_id
HAVING SUM(O.quantity) > 3;

--
SELECT P1.category_id, AVG(P1.price) AS avg_price
FROM [PRODUCT] P1
GROUP BY P1.category_id
HAVING AVG(P1.price) > (
    SELECT AVG(P.price)
    FROM [PRODUCT] P
);

-- (suppliers where :the latest date of expiration > than the earliest date)
SELECT I.supplier_id,MIN(I.date_of_expiration) AS earliest_expiration,MAX(I.date_of_expiration) AS latest_expiration
FROM INGREDIENT I
GROUP BY I.supplier_id
HAVING MAX(I.date_of_expiration) > (
    SELECT MIN(I2.date_of_expiration)
    FROM INGREDIENT I2
    WHERE I2.name_of_ingredient LIKE '_%r'
);



--avg price per category
SELECT DISTINCT TOP(5) P.name_product,P.price-5 AS discounted_price
FROM [PRODUCT] P
WHERE P.price = ANY (
    SELECT AVG(P2.price)
    FROM [PRODUCT] P2
    GROUP BY P2.category_id
)
ORDER BY discounted_price DESC;


SELECT TOP(3) P.name_product, P.price*1.21 AS price_with_tax, P.quantity
FROM [PRODUCT] P
WHERE P.price = ANY (
    SELECT P2.price
    FROM [PRODUCT] P2
    WHERE P2.category_id = 2 OR (P2.quantity>10 AND P2.price<>15.00)
)
ORDER BY P.price;

--rewrite with IN 

SELECT DISTINCT TOP(5) P.name_product,P.price-5 AS discounted_price
FROM [PRODUCT] P
WHERE P.price IN (
    SELECT AVG(P2.price)
    FROM [PRODUCT] P2
    GROUP BY P2.category_id
)
ORDER BY discounted_price DESC;

SELECT TOP(3) P.name_product, P.price*1.21 AS price_with_tax, P.quantity
FROM [PRODUCT] P
WHERE P.price IN (
    SELECT P2.price
    FROM [PRODUCT] P2
     WHERE P2.category_id = 2 OR (P2.quantity>10 AND P2.price<>15.00)
)
ORDER BY P.price;


-- Find products that are more expensive than all products in category 2
SELECT DISTINCT P.name_product, P.price+21.00/100.00
FROM [PRODUCT] P
WHERE P.price > ALL (
    SELECT P2.price+21.00/100.00
    FROM [PRODUCT] P2
    WHERE NOT(P2.category_id <> 2) 
);

-- Find clients whose total orders quantity is greater than all orders quantity of client 2
SELECT O.client_id, O.quantity
FROM [ORDER] O
WHERE O.quantity > ALL (
    SELECT O2.quantity
    FROM [ORDER] O2
    WHERE O2.client_id = 2 );

--rewrite
SELECT DISTINCT P.name_product, P.price+21.00/100.00
FROM [PRODUCT] P
WHERE P.price > (
    SELECT MAX(P2.price)+21.00/100.00
    FROM [PRODUCT] P2
    WHERE NOT(P2.category_id <> 2)
);

SELECT O.client_id, O.quantity
FROM [ORDER] O
WHERE O.quantity > (
    SELECT MAX(O2.quantity)
    FROM [ORDER] O2
    WHERE O2.client_id = 2
);

--
-- modify type of column
GO
CREATE OR ALTER PROCEDURE changeRecipeNameFromVartoNVar AS
BEGIN
  ALTER TABLE RECIPE ALTER COLUMN name_of_recipe NVARCHAR(256)
END

--undo
GO
CREATE OR ALTER PROCEDURE revertRecipeNameFromNVarToVar AS
BEGIN
 ALTER TABLE RECIPE ALTER COLUMN name_of_recipe VARCHAR(256)
END

-- add/remove column
GO
CREATE OR ALTER PROCEDURE addContractYearInSupplier AS
BEGIN
  ALTER TABLE SUPPLIER ADD year_of_contract INT
END

GO
CREATE OR ALTER PROCEDURE removeContractYearInSupplier AS
BEGIN
  ALTER TABLE SUPPLIER DROP COLUMN year_of_contract
END

-- add. remove default constraint
GO
CREATE OR ALTER PROCEDURE addDefaultConstraint AS
BEGIN
  ALTER TABLE LOYALTY_CARD ADD CONSTRAINT LoyaltyCard_Points DEFAULT 0 FOR points
END

GO
CREATE OR ALTER PROCEDURE removeDefaultConstraint AS
BEGIN
  ALTER TABLE LOYALTY_CARD DROP CONSTRAINT LoyaltyCard_Points
END
GO

-- add/remove a primary key
CREATE OR ALTER PROCEDURE addPKLoyaltyCard AS
BEGIN
   ALTER TABLE LOYALTY_CARD ADD CONSTRAINT PK_LYCARD PRIMARY KEY(card_id)
END

GO
CREATE OR ALTER PROCEDURE removePKLoyaltyCard AS
BEGIN
  ALTER TABLE LOYALTY_CARD DROP CONSTRAINT PK_LYCARD
END


-- add/remove a candidate key
GO
CREATE OR ALTER PROCEDURE addCandidateKey AS
BEGIN
  ALTER TABLE CLIENT ADD CONSTRAINT EmailClientCandidateKey UNIQUE(email)
END

GO
CREATE OR ALTER PROCEDURE removeCandidateKey AS
BEGIN
  ALTER TABLE CLIENT DROP CONSTRAINT EmailClientCandidateKey
END
GO

-- add/remove fk

CREATE OR ALTER PROCEDURE addFKIngrSupplier AS
BEGIN
  ALTER TABLE INGREDIENT ADD CONSTRAINT FK_Ingredient_Supplier FOREIGN KEY(supplier_id) REFERENCES SUPPLIER(supplier_id)
END
GO

CREATE OR ALTER PROCEDURE removeFKIngrSupplier AS
BEGIN
  ALTER TABLE INGREDIENT DROP CONSTRAINT FK_Ingredient_Supplier
END
GO

-- create/drop table
GO
CREATE OR ALTER PROCEDURE createTable AS 
  CREATE TABLE MANAGER_INFORM(
    manager_id INT,
    [name] NVARCHAR(100),
    PRIMARY KEY(manager_id)
    );  
GO

--EXEC createTable
CREATE OR ALTER PROCEDURE dropTable AS
BEGIN
  DROP TABLE IF EXISTS MANAGER_INFORM
END
GO

--EXEC dropTable

DROP TABLE IF EXISTS VERSION_TABLE
GO
CREATE TABLE VERSION_TABLE(
  [version] INT, 
  PRIMARY KEY([version])
  );
INSERT INTO VERSION_TABLE VALUES (0);

DROP TABLE IF EXISTS PROCEDURES_TABLE
GO
CREATE TABLE PROCEDURES_TABLE(
 fromversion INT,
 toversion INT,
 nameproc VARCHAR(100),
 PRIMARY KEY(fromversion,toversion)
);
GO
INSERT INTO PROCEDURES_TABLE(fromversion, toversion, nameproc)  VALUES
(0,1,'changeRecipeNameFromVartoNVar'),
(1,0,'revertRecipeNameFromNVarToVar'),

(1,2,'addContractYearInSupplier'),
(2,1,'removeContractYearInSupplier'),

(2,3,'addDefaultConstraint'),
(3,2,'removeDefaultConstraint'),

(3,4,'addPKLoyaltyCard'),
(4,3,'removePKLoyaltyCard'),

(4,5,'addCandidateKey'),
(5,4,'removeCandidateKey'),

(5,6,'addFKIngrSupplier'),
(6,5,'removeFKIngrSupplier'),

(6,7,'createTable'),
(7,6,'dropTable');
GO
CREATE OR ALTER PROCEDURE gotoVersion(@vers INT) AS
BEGIN
  DECLARE @current INT;
  DECLARE @proc VARCHAR(100)

  SELECT @current=V.[version]
  FROM VERSION_TABLE V

  IF @vers < 0 OR @vers > (SELECT MAX(toversion) FROM PROCEDURES_TABLE)
  BEGIN
    RAISERROR('Invalid Version',16,1);
    RETURN
  END

  WHILE @current < @vers
  BEGIN
    SELECT @proc=nameproc 
    FROM PROCEDURES_TABLE
    WHERE fromversion=@current AND toversion=@current+1;
    EXEC(@proc);
    SET @current=@current+1;
    UPDATE VERSION_TABLE SET [version]=@current;
  END

  WHILE @current > @vers
  BEGIN
   SELECT @proc=nameproc
   FROM PROCEDURES_TABLE
   WHERE fromversion=@current AND toversion=@current-1;
   EXEC(@proc);
   SET @current=@current-1;
   UPDATE VERSION_TABLE SET [version]=@current;
  END
END

GO
EXEC gotoVersion 1;
GO
EXEC gotoVersion 0;
GO
EXEC gotoVersion 3;
GO
EXEC gotoVersion 5;
GO  