use [bakery];
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
client_id INT PRIMARY KEY,
[name] VARCHAR(256),
email VARCHAR(256) UNIQUE
);

CREATE TABLE [ORDER](
order_id INT PRIMARY KEY,
client_id INT,
quantity INT,
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
card_id INT PRIMARY KEY,
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

INSERT INTO CATEGORY (category_id, category_name) VALUES
(1,'Cakes'),
(2,'Pastries'),
(3,'Cookies'),
(4,'Chocolate'),
(5,'Bread'),
(6,'Ice Cream'),
(7,'Cupcakes'),
(8,'Muffins'),
(9,'Macarons'),
(10,'Puddings');

INSERT INTO EQUIPMENT (equipment_id, equipment_name, type_of_equipment) VALUES
(1,'Magnificient Oven','electric'),
(2,'See-through Oven','electric'),
(3,'Slient Mixer','metal'),
(4,'Noisy Mixer','metal'),
(5,'Auch Fryer','metal'),
(6,'Proofer High','plastic'),
(7,'Grill G','metal'),
(8,'Blender','plastic'),
(9,'D&D Rolling Machine','metal'),
(10,'Convection Oven','electric');

INSERT INTO RECIPE (recipe_id, name_of_recipe, [description], time_of_preparation) VALUES
(1,'Chocolate Cake Recepie','Put a simple dough (made with 5 tablespoons of cocoa) in the oven.The glaze is also made of chocolate.',90),
(2,'Croissant Recepie','Roll them and put in the oven. You can also add some sparkles after. So easy!!',60),
(3,'Pistachio Roll','Whisk eggs and sugar, fold in flour; layer cream, roll, chill, slice, serve.',100),
(4,'Homemade Dark Chocolate','Melt cocoa butter, mix cocoa powder and sugar, pour into molds, cool, set, enjoy.',100),
(5,'Cookie with Vanilla','Cream butter and sugar, mix in flour and chocolate chips, scoop, bake, cool.',20),
(6,'Cake with Vanilla and Raspberry Cream','Mix some whipp cream. Put it in the fridge for 12 hours.Put raspberries in it. Serve cold!',100),
(7,'Blueberry pudding','500 grams of blueberries mixed with some pudding powder. Add gelatine. Leave in the fridge for 12 hours.',15),
(8,'Vanilla Cupcake (Hawaian)','Mix flour, sugar, butter, eggs, vanilla; bake 20 minutes at 350°F; frost as desired',45),
(9,'Raspberry with Chocolate Donut','Flour, Salt Bake Bake Bake.',50),
(10,'Bagel','Dense bread ring.',100);

INSERT INTO RECIPE_EQUIPMENT (recipe_id, equipment_id) VALUES
(1,1),(2,1),(2,3),(3,1),(3,3),(4,5),
(5,2),(6,3),(6,4),(7,4),(7,3),(8,2),
(9,8),(10,9),(10,6),(3,6),(5,6),(8,6); --6,7

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
(9,'Blueberry Pudding Dream',15,14.00,7,10),  --5,9
(10,'Bagel',18,2.50,10,6);

INSERT INTO CLIENT (client_id, [name], email) VALUES
(1,'Ana-Maria Pop','anamariapop@gmail.com'),
(2,'Georgiana Ionescu','georgiionesc@yahoo.com'),
(3,'Andrei Mihai Popa','popaandrei2006@yahoo.com'),
(4,'Maria Anghel','maanghel@yahoo.com'),
(5,'Lia Stanis','lia@gmail.com'),
(6,'Denisa Aloman','denisaaloman162@yahoo.com');


INSERT INTO [ORDER] (order_id, client_id, quantity) VALUES 
--the quantity here tells how many units of each product the client wants
--if he wants multiple products with different quantities, then another order under his id will be placed
(1,1,2),
(2,2,5),
(3,3,10),
(4,4,8),
(5,5,15),
(6,6,20),
(7,1,5),
(8,2,3),
(9,3,12),
(10,4,7);

INSERT INTO ORDER_PRODUCT (prod_id, order_id) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),
(1,5),(3,6),(2,7),(4,8),(5,9),(6,10),(7,1),(8,2),(9,3),(10,4);

/*
Find the equipment that is used more often than the average and whose total revenue is higher than the average revenue
sorted by total revenue in descending order.
This query helps the owner to see what equipment is overused and also produces high revenue 
such that he may expect what equipment will break down and not to waste time replacing it and losing huge profit. 
*/

SELECT E.equipment_name,SUM(O.quantity) AS total_usages,SUM(P.price * O.quantity) AS total_revenue
FROM EQUIPMENT E
INNER JOIN RECIPE_EQUIPMENT RE ON E.equipment_id = RE.equipment_id
INNER JOIN RECIPE R ON RE.recipe_id = R.recipe_id
INNER JOIN [PRODUCT] P ON R.recipe_id = P.recipe_id
INNER JOIN ORDER_PRODUCT OP ON P.prod_id = OP.prod_id
INNER JOIN [ORDER] O ON OP.order_id = O.order_id
GROUP BY E.equipment_id, E.equipment_name
HAVING SUM(O.quantity) > (
        SELECT AVG(UsageData.usages)
        FROM (
            SELECT SUM(O2.quantity) AS usages
            FROM EQUIPMENT E2
            INNER JOIN RECIPE_EQUIPMENT RE2 ON E2.equipment_id = RE2.equipment_id
            INNER JOIN RECIPE R2 ON RE2.recipe_id = R2.recipe_id
            INNER JOIN [PRODUCT] P2 ON R2.recipe_id = P2.recipe_id
            INNER JOIN ORDER_PRODUCT OP2 ON P2.prod_id = OP2.prod_id
            INNER JOIN [ORDER] O2 ON OP2.order_id = O2.order_id
            GROUP BY E2.equipment_id
        ) AS UsageData)
AND SUM(P.price*O.quantity) > (
        SELECT AVG(RevenueData.revenue)
        FROM (
            SELECT SUM(P3.price * O3.quantity) AS revenue
            FROM EQUIPMENT E3
            INNER JOIN RECIPE_EQUIPMENT RE3 ON E3.equipment_id = RE3.equipment_id
            INNER JOIN RECIPE R3 ON RE3.recipe_id = R3.recipe_id
            INNER JOIN [PRODUCT] P3 ON R3.recipe_id = P3.recipe_id
            INNER JOIN ORDER_PRODUCT OP3 ON P3.prod_id = OP3.prod_id
            INNER JOIN [ORDER] O3 ON OP3.order_id = O3.order_id
            GROUP BY E3.equipment_id
        ) AS RevenueData)
ORDER BY total_revenue DESC;
