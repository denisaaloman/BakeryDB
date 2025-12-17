DROP TABLE IF EXISTS RECIPE_EQUIPMENT;
DROP TABLE IF EXISTS RECIPE;

CREATE TABLE RECIPE(
recipe_id INT PRIMARY KEY,
nutrition_score INT UNIQUE,
name_of_recipe VARCHAR(256),
[description] VARCHAR(900) NOT NULL,
time_of_preparation INT
);

DROP TABLE IF EXISTS EQUIPMENT;
CREATE TABLE EQUIPMENT(
equipment_id INT PRIMARY KEY,
power_watts INT,
equipment_name VARCHAR(100),
type_of_equipment VARCHAR(50)  
);


CREATE TABLE RECIPE_EQUIPMENT(
recipe_equipment INT PRIMARY KEY,
recipe_id INT,
equipment_id INT,
FOREIGN KEY (recipe_id) REFERENCES RECIPE(recipe_id),
FOREIGN KEY (equipment_id) REFERENCES EQUIPMENT(equipment_id)
);

DROP PROCEDURE IF EXISTS populateRecipe;
GO
CREATE OR ALTER PROCEDURE populateRecipe(@rows INT) AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @i INT = 1;
    
    WHILE @i <= @rows
    BEGIN
        INSERT INTO RECIPE (recipe_id, nutrition_score, name_of_recipe, [description], time_of_preparation)
        VALUES (
            @i,  -- recipe_id unic
            @i*4,  -- nutrition_score unique
            'Recipe_' + CAST(@i AS VARCHAR(10)),
            'Description for recipe ' + CAST(@i AS VARCHAR(10)),
            10 + FLOOR(RAND() * 120)  
        );
        SET @i = @i + 1;
    END
END
GO
DROP PROCEDURE IF EXISTS populateEquipment;
GO
CREATE OR ALTER PROCEDURE populateEquipment(@rows INT) AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;
    DECLARE @types TABLE (type_name VARCHAR(50));
    INSERT INTO @types VALUES ('Plastic'), ('Metal'), ('Curent');

    WHILE @i <= @rows
    BEGIN
        INSERT INTO EQUIPMENT (equipment_id, power_watts, equipment_name, type_of_equipment)
        VALUES (
            @i,  -- equipment_id unic
            50 + FLOOR(RAND() * 50),  -- power_watts between 50 and 100
            'Equipment_' + CAST(@i AS VARCHAR(10)),
            (SELECT TOP 1 type_name FROM @types ORDER BY NEWID())  
        );
        SET @i = @i + 1;
    END
END
GO
DROP PROCEDURE IF EXISTS populateRecipeEquipment;
GO
CREATE OR ALTER PROCEDURE populateRecipeEquipment(@rows INT) AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;
    DECLARE @recipeCount INT = (SELECT COUNT(*) FROM RECIPE);
    DECLARE @equipmentCount INT = (SELECT COUNT(*) FROM EQUIPMENT);

    WHILE @i <= @rows
    BEGIN
        INSERT INTO RECIPE_EQUIPMENT (recipe_equipment, recipe_id, equipment_id)
        VALUES (
            @i,  -- id unic
            1 + FLOOR(RAND() * @recipeCount), 
            1 + FLOOR(RAND() * @equipmentCount) 
        );
        SET @i = @i + 1;
    END
END
GO

DELETE FROM RECIPE_EQUIPMENT;
DELETE FROM RECIPE;
DELETE FROM EQUIPMENT;
EXEC populateRecipe 5000;
EXEC populateEquipment 5000;
EXEC populateRecipeEquipment 5000;


--Clustered index scan
SELECT *
FROM RECIPE
ORDER BY recipe_id DESC;


--cl index seek
SELECT *
FROM RECIPE
WHERE recipe_id>1999;

--ncl index scan
SELECT nutrition_score
FROM RECIPE;

--ncl index seek
SELECT nutrition_score
FROM RECIPE
WHERE nutrition_score > 1200;

--ncl index seek+ key lookup (cl)
SELECT *
FROM RECIPE
WHERE nutrition_score = 400;

--cl idx scan
SELECT power_watts
FROM EQUIPMENT
WHERE power_watts = 100;

--speed the query
GO
CREATE NONCLUSTERED INDEX idx_equip_power ON EQUIPMENT(power_watts);
--now: idx seek (ncl)
SELECT power_watts
FROM EQUIPMENT
WHERE power_watts = 100;


DROP VIEW IF EXISTS myview;
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_equip_power')
 DROP INDEX idx_equip_power ON EQUIPMENT

GO
CREATE VIEW myview AS
   SELECT SUM(a.nutrition_score) AS sumofnutrition
   FROM RECIPE_EQUIPMENT c
   INNER JOIN EQUIPMENT b ON c.equipment_id = b.equipment_id  
   INNER JOIN RECIPE a ON a.recipe_id = c.recipe_id       
   WHERE a.nutrition_score <=1200 AND b.power_watts <= 78
GO

SELECT * FROM myview;
--Speed up
IF EXISTS (SELECT * FROM sys.indexes WHERE name='idx_recipe_equipment')
    DROP INDEX idx_recipe_equipment ON RECIPE_EQUIPMENT;

CREATE NONCLUSTERED INDEX idx_recipe_equipment_equipment
ON RECIPE_EQUIPMENT(equipment_id, recipe_id);

SELECT * FROM myview; 

