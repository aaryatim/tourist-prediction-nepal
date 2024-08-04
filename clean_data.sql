#View all the columns

SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE, COLUMN_DEFAULT, COLUMN_KEY, EXTRA
FROM information_schema.columns
WHERE TABLE_SCHEMA = 'tourist_project'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

#Filter null rows from all the tables in the database

#Generate delete statements
SELECT CONCAT(
    'DELETE FROM `', table_name, 
    '` WHERE ', 
    GROUP_CONCAT(CONCAT('`', column_name, '` IS NULL') SEPARATOR ' AND '), 
    ';'
) AS delete_statement
FROM information_schema.columns
WHERE table_schema = 'tourist_project'
GROUP BY table_name;

#Execute these delete_statements

DELETE FROM `age` WHERE `0_15` IS NULL AND `16_30` IS NULL AND `31_45` IS NULL AND `46_60` IS NULL AND `60+` IS NULL AND `Not_Sp_` IS NULL AND `total` IS NULL AND `year` IS NULL;
DELETE FROM `indian_tourist_arrival_month` WHERE `Apr_` IS NULL AND `Aug_` IS NULL AND `Dec_` IS NULL AND `Feb_` IS NULL AND `Jan_` IS NULL AND `July` IS NULL AND `Jun_` IS NULL AND `Mar_` IS NULL AND `May` IS NULL AND `Nov_` IS NULL AND `Oct_` IS NULL AND `Sep_` IS NULL AND `Total` IS NULL AND `Year` IS NULL;
DELETE FROM `nationality` WHERE `2013` IS NULL AND `2014` IS NULL AND `2015` IS NULL AND `2016` IS NULL AND `2017` IS NULL AND `2018` IS NULL AND `2019` IS NULL AND `2020` IS NULL AND `2021` IS NULL AND `2022` IS NULL AND `Nationality` IS NULL;
DELETE FROM `nationality_monthly` WHERE `Apr_` IS NULL AND `Aug_` IS NULL AND `Dec_` IS NULL AND `Extra` IS NULL AND `Feb_` IS NULL AND `Jan_` IS NULL AND `Jul_` IS NULL AND `Jun_` IS NULL AND `Mar_` IS NULL AND `May` IS NULL AND `Nationality` IS NULL AND `Nov_` IS NULL AND `Oct_` IS NULL AND `Sep_` IS NULL AND `Total` IS NULL AND `Year` IS NULL;
DELETE FROM `purpose` WHERE `Business` IS NULL AND `Conv_/_Conf_` IS NULL AND `Holiday_Pleasure` IS NULL AND `Not_Specified` IS NULL AND `Official` IS NULL AND `Others` IS NULL AND `Pilgrimage` IS NULL AND `Total` IS NULL AND `Trekking_&_Mountaineering` IS NULL AND `Year` IS NULL;
DELETE FROM `sex` WHERE `Female` IS NULL AND `Male` IS NULL AND `Total` IS NULL AND `year` IS NULL;
DELETE FROM `total_tourist_arrival` WHERE `Indian` IS NULL AND `Third_Country` IS NULL AND `Total` IS NULL AND `Year` IS NULL;
DELETE FROM `tourist_arrival_length` WHERE `Annual_Growth_rate` IS NULL AND `avg_length_of_stay` IS NULL AND `Number_air` IS NULL AND `Number_land` IS NULL AND `Number_total` IS NULL AND `Percent_air` IS NULL AND `Percent_land` IS NULL AND `year` IS NULL;
DELETE FROM `tourist_arrival_month` WHERE `Apr_` IS NULL AND `Aug_` IS NULL AND `Dec_` IS NULL AND `Feb_` IS NULL AND `Jan_` IS NULL AND `Jul_` IS NULL AND `Jun_` IS NULL AND `Mar_` IS NULL AND `May` IS NULL AND `Nov_` IS NULL AND `Oct_` IS NULL AND `Sep_` IS NULL AND `Total` IS NULL AND `Year` IS NULL;

#Check all the tables 
select * from age
select * from indian_tourist_arrival_month
select * from nationality
select * from nationality_monthly
select * from purpose
select * from sex
select * from total_tourist_arrival
select * from tourist_arrival_length
select * from tourist_arrival_month

#Identify missing values at once from all the tables

-- Set the group_concat_max_len to a larger value
SET SESSION group_concat_max_len = 1000000;

-- Prepare a variable to store the dynamic SQL
SET @sql = NULL;

-- Generate the SQL for checking missing values for each table and column
SELECT GROUP_CONCAT(
    CONCAT(
        'SELECT ''', table_name, ''' AS table_name, ''', column_name, ''' AS column_name, ',
        'COUNT(*) AS total_rows, ',
        'SUM(CASE WHEN `', column_name, '` IS NULL THEN 1 ELSE 0 END) AS null_rows, ',
        'SUM(CASE WHEN `', column_name, '` IS NOT NULL THEN 1 ELSE 0 END) AS non_null_rows ',
        'FROM `', table_name, '`'
    ) SEPARATOR ' UNION ALL '
) INTO @sql
FROM information_schema.columns
WHERE table_schema = 'tourist_project';

-- Check the generated SQL for debugging
SELECT @sql;

-- Execute the generated SQL if not NULL
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

#Check the current data types

SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    DATA_TYPE, 
    COLUMN_TYPE 
FROM 
    information_schema.columns
WHERE 
    table_schema = 'tourist_project'
ORDER BY 
    TABLE_NAME, 
    COLUMN_NAME;
    
#Remove commas from all the tables

#Generate the UPDATE Statements
SELECT CONCAT('UPDATE `', TABLE_NAME, '` SET `', COLUMN_NAME, '` = REPLACE(`', COLUMN_NAME, '`, '','', '''') WHERE `', COLUMN_NAME, '` LIKE ''%,%'';')
FROM information_schema.columns
WHERE table_schema = 'tourist_project';

#Execute the update statements 

UPDATE `age` SET `0_15` = REPLACE(`0_15`, ',', '') WHERE `0_15` LIKE '%,%';
UPDATE `age` SET `16_30` = REPLACE(`16_30`, ',', '') WHERE `16_30` LIKE '%,%';
UPDATE `age` SET `31_45` = REPLACE(`31_45`, ',', '') WHERE `31_45` LIKE '%,%';
UPDATE `age` SET `46_60` = REPLACE(`46_60`, ',', '') WHERE `46_60` LIKE '%,%';
UPDATE `age` SET `60+` = REPLACE(`60+`, ',', '') WHERE `60+` LIKE '%,%';
UPDATE `age` SET `Not_Sp_` = REPLACE(`Not_Sp_`, ',', '') WHERE `Not_Sp_` LIKE '%,%';
UPDATE `age` SET `total` = REPLACE(`total`, ',', '') WHERE `total` LIKE '%,%';
UPDATE `age` SET `year` = REPLACE(`year`, ',', '') WHERE `year` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Apr_` = REPLACE(`Apr_`, ',', '') WHERE `Apr_` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Aug_` = REPLACE(`Aug_`, ',', '') WHERE `Aug_` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Dec_` = REPLACE(`Dec_`, ',', '') WHERE `Dec_` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Feb_` = REPLACE(`Feb_`, ',', '') WHERE `Feb_` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Jan_` = REPLACE(`Jan_`, ',', '') WHERE `Jan_` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `July` = REPLACE(`July`, ',', '') WHERE `July` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Jun_` = REPLACE(`Jun_`, ',', '') WHERE `Jun_` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Mar_` = REPLACE(`Mar_`, ',', '') WHERE `Mar_` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `May` = REPLACE(`May`, ',', '') WHERE `May` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Nov_` = REPLACE(`Nov_`, ',', '') WHERE `Nov_` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Oct_` = REPLACE(`Oct_`, ',', '') WHERE `Oct_` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Sep_` = REPLACE(`Sep_`, ',', '') WHERE `Sep_` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Total` = REPLACE(`Total`, ',', '') WHERE `Total` LIKE '%,%';
UPDATE `indian_tourist_arrival_month` SET `Year` = REPLACE(`Year`, ',', '') WHERE `Year` LIKE '%,%';
UPDATE `nationality` SET `2013` = REPLACE(`2013`, ',', '') WHERE `2013` LIKE '%,%';
UPDATE `nationality` SET `2014` = REPLACE(`2014`, ',', '') WHERE `2014` LIKE '%,%';
UPDATE `nationality` SET `2015` = REPLACE(`2015`, ',', '') WHERE `2015` LIKE '%,%';
UPDATE `nationality` SET `2016` = REPLACE(`2016`, ',', '') WHERE `2016` LIKE '%,%';
UPDATE `nationality` SET `2017` = REPLACE(`2017`, ',', '') WHERE `2017` LIKE '%,%';
UPDATE `nationality` SET `2018` = REPLACE(`2018`, ',', '') WHERE `2018` LIKE '%,%';
UPDATE `nationality` SET `2019` = REPLACE(`2019`, ',', '') WHERE `2019` LIKE '%,%';
UPDATE `nationality` SET `2020` = REPLACE(`2020`, ',', '') WHERE `2020` LIKE '%,%';
UPDATE `nationality` SET `2021` = REPLACE(`2021`, ',', '') WHERE `2021` LIKE '%,%';
UPDATE `nationality` SET `2022` = REPLACE(`2022`, ',', '') WHERE `2022` LIKE '%,%';
UPDATE `nationality` SET `Nationality` = REPLACE(`Nationality`, ',', '') WHERE `Nationality` LIKE '%,%';
UPDATE `nationality_monthly` SET `Apr_` = REPLACE(`Apr_`, ',', '') WHERE `Apr_` LIKE '%,%';
UPDATE `nationality_monthly` SET `Aug_` = REPLACE(`Aug_`, ',', '') WHERE `Aug_` LIKE '%,%';
UPDATE `nationality_monthly` SET `Dec_` = REPLACE(`Dec_`, ',', '') WHERE `Dec_` LIKE '%,%';
UPDATE `nationality_monthly` SET `Extra` = REPLACE(`Extra`, ',', '') WHERE `Extra` LIKE '%,%';
UPDATE `nationality_monthly` SET `Feb_` = REPLACE(`Feb_`, ',', '') WHERE `Feb_` LIKE '%,%';
UPDATE `nationality_monthly` SET `Jan_` = REPLACE(`Jan_`, ',', '') WHERE `Jan_` LIKE '%,%';
UPDATE `nationality_monthly` SET `Jul_` = REPLACE(`Jul_`, ',', '') WHERE `Jul_` LIKE '%,%';
UPDATE `nationality_monthly` SET `Jun_` = REPLACE(`Jun_`, ',', '') WHERE `Jun_` LIKE '%,%';
UPDATE `nationality_monthly` SET `Mar_` = REPLACE(`Mar_`, ',', '') WHERE `Mar_` LIKE '%,%';
UPDATE `nationality_monthly` SET `May` = REPLACE(`May`, ',', '') WHERE `May` LIKE '%,%';
UPDATE `nationality_monthly` SET `Nationality` = REPLACE(`Nationality`, ',', '') WHERE `Nationality` LIKE '%,%';
UPDATE `nationality_monthly` SET `Nov_` = REPLACE(`Nov_`, ',', '') WHERE `Nov_` LIKE '%,%';
UPDATE `nationality_monthly` SET `Oct_` = REPLACE(`Oct_`, ',', '') WHERE `Oct_` LIKE '%,%';
UPDATE `nationality_monthly` SET `Sep_` = REPLACE(`Sep_`, ',', '') WHERE `Sep_` LIKE '%,%';
UPDATE `nationality_monthly` SET `Total` = REPLACE(`Total`, ',', '') WHERE `Total` LIKE '%,%';
UPDATE `nationality_monthly` SET `Year` = REPLACE(`Year`, ',', '') WHERE `Year` LIKE '%,%';
UPDATE `purpose` SET `Business` = REPLACE(`Business`, ',', '') WHERE `Business` LIKE '%,%';
UPDATE `purpose` SET `Conv_/_Conf_` = REPLACE(`Conv_/_Conf_`, ',', '') WHERE `Conv_/_Conf_` LIKE '%,%';
UPDATE `purpose` SET `Holiday_Pleasure` = REPLACE(`Holiday_Pleasure`, ',', '') WHERE `Holiday_Pleasure` LIKE '%,%';
UPDATE `purpose` SET `Not_Specified` = REPLACE(`Not_Specified`, ',', '') WHERE `Not_Specified` LIKE '%,%';
UPDATE `purpose` SET `Official` = REPLACE(`Official`, ',', '') WHERE `Official` LIKE '%,%';
UPDATE `purpose` SET `Others` = REPLACE(`Others`, ',', '') WHERE `Others` LIKE '%,%';
UPDATE `purpose` SET `Pilgrimage` = REPLACE(`Pilgrimage`, ',', '') WHERE `Pilgrimage` LIKE '%,%';
UPDATE `purpose` SET `Total` = REPLACE(`Total`, ',', '') WHERE `Total` LIKE '%,%';
UPDATE `purpose` SET `Trekking_&_Mountaineering` = REPLACE(`Trekking_&_Mountaineering`, ',', '') WHERE `Trekking_&_Mountaineering` LIKE '%,%';
UPDATE `purpose` SET `Year` = REPLACE(`Year`, ',', '') WHERE `Year` LIKE '%,%';
UPDATE `sex` SET `Female` = REPLACE(`Female`, ',', '') WHERE `Female` LIKE '%,%';
UPDATE `sex` SET `Male` = REPLACE(`Male`, ',', '') WHERE `Male` LIKE '%,%';
UPDATE `sex` SET `Total` = REPLACE(`Total`, ',', '') WHERE `Total` LIKE '%,%';
UPDATE `sex` SET `year` = REPLACE(`year`, ',', '') WHERE `year` LIKE '%,%';
UPDATE `total_tourist_arrival` SET `Indian` = REPLACE(`Indian`, ',', '') WHERE `Indian` LIKE '%,%';
UPDATE `total_tourist_arrival` SET `Third_Country` = REPLACE(`Third_Country`, ',', '') WHERE `Third_Country` LIKE '%,%';
UPDATE `total_tourist_arrival` SET `Total` = REPLACE(`Total`, ',', '') WHERE `Total` LIKE '%,%';
UPDATE `total_tourist_arrival` SET `Year` = REPLACE(`Year`, ',', '') WHERE `Year` LIKE '%,%';
UPDATE `tourist_arrival_length` SET `Annual_Growth_rate` = REPLACE(`Annual_Growth_rate`, ',', '') WHERE `Annual_Growth_rate` LIKE '%,%';
UPDATE `tourist_arrival_length` SET `avg_length_of_stay` = REPLACE(`avg_length_of_stay`, ',', '') WHERE `avg_length_of_stay` LIKE '%,%';
UPDATE `tourist_arrival_length` SET `Number_air` = REPLACE(`Number_air`, ',', '') WHERE `Number_air` LIKE '%,%';
UPDATE `tourist_arrival_length` SET `Number_land` = REPLACE(`Number_land`, ',', '') WHERE `Number_land` LIKE '%,%';
UPDATE `tourist_arrival_length` SET `Number_total` = REPLACE(`Number_total`, ',', '') WHERE `Number_total` LIKE '%,%';
UPDATE `tourist_arrival_length` SET `Percent_air` = REPLACE(`Percent_air`, ',', '') WHERE `Percent_air` LIKE '%,%';
UPDATE `tourist_arrival_length` SET `Percent_land` = REPLACE(`Percent_land`, ',', '') WHERE `Percent_land` LIKE '%,%';
UPDATE `tourist_arrival_length` SET `year` = REPLACE(`year`, ',', '') WHERE `year` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Apr_` = REPLACE(`Apr_`, ',', '') WHERE `Apr_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Aug_` = REPLACE(`Aug_`, ',', '') WHERE `Aug_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Dec_` = REPLACE(`Dec_`, ',', '') WHERE `Dec_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Feb_` = REPLACE(`Feb_`, ',', '') WHERE `Feb_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Jan_` = REPLACE(`Jan_`, ',', '') WHERE `Jan_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Jul_` = REPLACE(`Jul_`, ',', '') WHERE `Jul_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Jun_` = REPLACE(`Jun_`, ',', '') WHERE `Jun_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Mar_` = REPLACE(`Mar_`, ',', '') WHERE `Mar_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `May` = REPLACE(`May`, ',', '') WHERE `May` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Nov_` = REPLACE(`Nov_`, ',', '') WHERE `Nov_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Oct_` = REPLACE(`Oct_`, ',', '') WHERE `Oct_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Sep_` = REPLACE(`Sep_`, ',', '') WHERE `Sep_` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Total` = REPLACE(`Total`, ',', '') WHERE `Total` LIKE '%,%';
UPDATE `tourist_arrival_month` SET `Year` = REPLACE(`Year`, ',', '') WHERE `Year` LIKE '%,%';

#Set "na" values to null values in purpose table
UPDATE purpose
SET 
    `Business` = NULLIF(`Business`, 'na'),
    `Official` = NULLIF(`Official`, 'na'),
	`Conv_/_Conf_` = NULLIF(`Conv_/_Conf_`, 'na');    

#Change the data types for all the tables 
-- Generate ALTER TABLE statements to modify column types
SELECT CONCAT(
    'ALTER TABLE `', TABLE_NAME, '` ',
    GROUP_CONCAT(
        CASE 
            WHEN COLUMN_NAME IN ('year', 'Year', 'year_of_entry', 'year_column_name') THEN 
                CONCAT('MODIFY COLUMN `', COLUMN_NAME, '` YEAR')
            ELSE 
                CONCAT('MODIFY COLUMN `', COLUMN_NAME, '` INT')
        END
        SEPARATOR ', '
    ),
    ';'
) AS alter_statement
FROM (
    SELECT DISTINCT TABLE_NAME, COLUMN_NAME
    FROM information_schema.columns
    WHERE table_schema = 'tourist_project' 
) AS subquery
GROUP BY TABLE_NAME;

#Execute the alter statement to modify the data types 
# Alter_statement
ALTER TABLE `age` MODIFY COLUMN `0_15` INT, MODIFY COLUMN `16_30` INT, MODIFY COLUMN `31_45` INT, MODIFY COLUMN `46_60` INT, MODIFY COLUMN `60+` INT, MODIFY COLUMN `Not_Sp_` INT, MODIFY COLUMN `total` INT, MODIFY COLUMN `year` YEAR;
ALTER TABLE `indian_tourist_arrival_month` MODIFY COLUMN `Apr_` INT, MODIFY COLUMN `Aug_` INT, MODIFY COLUMN `Dec_` INT, MODIFY COLUMN `Feb_` INT, MODIFY COLUMN `Jan_` INT, MODIFY COLUMN `July` INT, MODIFY COLUMN `Jun_` INT, MODIFY COLUMN `Mar_` INT, MODIFY COLUMN `May` INT, MODIFY COLUMN `Nov_` INT, MODIFY COLUMN `Oct_` INT, MODIFY COLUMN `Sep_` INT, MODIFY COLUMN `Total` INT, MODIFY COLUMN `Year` YEAR;
ALTER TABLE `nationality` MODIFY COLUMN `2013` INT, MODIFY COLUMN `2014` INT, MODIFY COLUMN `2015` INT, MODIFY COLUMN `2016` INT, MODIFY COLUMN `2017` INT, MODIFY COLUMN `2018` INT, MODIFY COLUMN `2019` INT, MODIFY COLUMN `2020` INT, MODIFY COLUMN `2021` INT, MODIFY COLUMN `2022` INT, MODIFY COLUMN `Nationality` text;
ALTER TABLE `nationality_monthly` MODIFY COLUMN `Apr_` INT, MODIFY COLUMN `Aug_` INT, MODIFY COLUMN `Dec_` INT, MODIFY COLUMN `Extra` text, MODIFY COLUMN `Feb_` INT, MODIFY COLUMN `Jan_` INT, MODIFY COLUMN `Jul_` INT, MODIFY COLUMN `Jun_` INT, MODIFY COLUMN `Mar_` INT, MODIFY COLUMN `May` INT, MODIFY COLUMN `Nationality` text, MODIFY COLUMN `Nov_` INT, MODIFY COLUMN `Oct_` INT, MODIFY COLUMN `Sep_` INT, MODIFY COLUMN `Total` INT, MODIFY COLUMN `Year` YEAR;
ALTER TABLE `purpose` MODIFY COLUMN `Business` INT, MODIFY COLUMN `Conv_/_Conf_` INT, MODIFY COLUMN `Holiday_Pleasure` INT, MODIFY COLUMN `Not_Specified` INT, MODIFY COLUMN `Official` INT, MODIFY COLUMN `Others` INT, MODIFY COLUMN `Pilgrimage` INT, MODIFY COLUMN `Total` INT, MODIFY COLUMN `Trekking_&_Mountaineering` INT, MODIFY COLUMN `Year` YEAR;
ALTER TABLE `sex` MODIFY COLUMN `Female` INT, MODIFY COLUMN `Male` INT, MODIFY COLUMN `Total` INT, MODIFY COLUMN `year` YEAR;
ALTER TABLE `total_tourist_arrival` MODIFY COLUMN `Indian` INT, MODIFY COLUMN `Third_Country` INT, MODIFY COLUMN `Total` INT, MODIFY COLUMN `Year` YEAR;
ALTER TABLE `tourist_arrival_length` MODIFY COLUMN `Annual_Growth_rate` INT, MODIFY COLUMN `avg_length_of_stay` INT, MODIFY COLUMN `Number_air` INT, MODIFY COLUMN `Number_land` INT, MODIFY COLUMN `Number_total` INT, MODIFY COLUMN `Percent_air` INT, MODIFY COLUMN `Percent_land` INT, MODIFY COLUMN `year` YEAR;
ALTER TABLE `tourist_arrival_month` MODIFY COLUMN `Apr_` INT, MODIFY COLUMN `Aug_` INT, MODIFY COLUMN `Dec_` INT, MODIFY COLUMN `Feb_` INT, MODIFY COLUMN `Jan_` INT, MODIFY COLUMN `Jul_` INT, MODIFY COLUMN `Jun_` INT, MODIFY COLUMN `Mar_` INT, MODIFY COLUMN `May` INT, MODIFY COLUMN `Nov_` INT, MODIFY COLUMN `Oct_` INT, MODIFY COLUMN `Sep_` INT, MODIFY COLUMN `Total` INT, MODIFY COLUMN `Year` YEAR;

#Check what the tables look like

select * from age
select * from indian_tourist_arrival_month
select * from nationality
select * from nationality_monthly
select * from purpose
select * from sex
select * from total_tourist_arrival
select * from tourist_arrival_length
select * from tourist_arrival_month

#Pivot the table nationality where the columns are nationality 
CREATE TABLE nationality_wide AS
SELECT
    Year,
    MAX(CASE WHEN Nationality = 'Australia' THEN Value ELSE NULL END) AS Australia,
    MAX(CASE WHEN Nationality = 'Bangladesh' THEN Value ELSE NULL END) AS Bangladesh,
    MAX(CASE WHEN Nationality = 'Canada' THEN Value ELSE NULL END) AS Canada,
    MAX(CASE WHEN Nationality = 'China' THEN Value ELSE NULL END) AS China,
    MAX(CASE WHEN Nationality = 'France' THEN Value ELSE NULL END) AS France,
    MAX(CASE WHEN Nationality = 'Germany' THEN Value ELSE NULL END) AS Germany,
    MAX(CASE WHEN Nationality = 'India' THEN Value ELSE NULL END) AS India,
    MAX(CASE WHEN Nationality = 'Italy' THEN Value ELSE NULL END) AS Italy,
    MAX(CASE WHEN Nationality = 'Japan' THEN Value ELSE NULL END) AS Japan,
    MAX(CASE WHEN Nationality = 'South Korea' THEN Value ELSE NULL END) AS `South Korea`,
    MAX(CASE WHEN Nationality = 'Malaysia' THEN Value ELSE NULL END) AS Malaysia,
    MAX(CASE WHEN Nationality = 'Myanmar' THEN Value ELSE NULL END) AS Myanmar,
    MAX(CASE WHEN Nationality = 'Netherlands' THEN Value ELSE NULL END) AS Netherlands,
    MAX(CASE WHEN Nationality = 'Spain' THEN Value ELSE NULL END) AS Spain,
    MAX(CASE WHEN Nationality = 'Sri Lanka' THEN Value ELSE NULL END) AS `Sri Lanka`,
    MAX(CASE WHEN Nationality = 'Thailand' THEN Value ELSE NULL END) AS Thailand,
    MAX(CASE WHEN Nationality = 'U.S.A.' THEN Value ELSE NULL END) AS `U.S.A.`,
    MAX(CASE WHEN Nationality = 'U.K.' THEN Value ELSE NULL END) AS `U.K.`,
    MAX(CASE WHEN Nationality = 'Others' THEN Value ELSE NULL END) AS Others_nationality,
    MAX(CASE WHEN Nationality = 'Total' THEN Value ELSE NULL END) AS Total_nationality
FROM (
    SELECT '2013' AS Year, Nationality, `2013` AS Value FROM nationality
    UNION ALL
    SELECT '2014' AS Year, Nationality, `2014` AS Value FROM nationality
    UNION ALL
    SELECT '2015' AS Year, Nationality, `2015` AS Value FROM nationality
    UNION ALL
    SELECT '2016' AS Year, Nationality, `2016` AS Value FROM nationality
    UNION ALL
    SELECT '2017' AS Year, Nationality, `2017` AS Value FROM nationality
    UNION ALL
    SELECT '2018' AS Year, Nationality, `2018` AS Value FROM nationality
    UNION ALL
    SELECT '2019' AS Year, Nationality, `2019` AS Value FROM nationality
    UNION ALL
    SELECT '2020' AS Year, Nationality, `2020` AS Value FROM nationality
    UNION ALL
    SELECT '2021' AS Year, Nationality, `2021` AS Value FROM nationality
    UNION ALL
    SELECT '2022' AS Year, Nationality, `2022` AS Value FROM nationality
) AS pivoted
GROUP BY Year
ORDER BY Year;

SELECT * FROM nationality_wide


#Join tables which simulates full join, creates main table, excludes nationality

CREATE TABLE main_table AS
SELECT 
    age.year,
    age.total AS age_total,
    age.`0_15`,
    age.`16_30`,
    age.`31_45`,
    age.`46_60`,
    age.`60+`,
    age.`Not_Sp_` AS Not_Specified_age
FROM 
    age;

ALTER TABLE main_table
ADD COLUMN indian_Jan INT,
ADD COLUMN indian_Feb INT,
ADD COLUMN indian_Mar INT,
ADD COLUMN indian_Apr INT,
ADD COLUMN indian_May INT,
ADD COLUMN indian_Jun INT,
ADD COLUMN indian_July INT,
ADD COLUMN indian_Aug INT,
ADD COLUMN indian_Sep INT,
ADD COLUMN indian_Oct INT,
ADD COLUMN indian_Nov INT,
ADD COLUMN indian_Dec INT,
ADD COLUMN indian_Total INT;

UPDATE main_table
LEFT JOIN indian_tourist_arrival_month ON main_table.year = indian_tourist_arrival_month.Year
SET 
    main_table.indian_Jan = indian_tourist_arrival_month.Jan_,
    main_table.indian_Feb = indian_tourist_arrival_month.Feb_,
    main_table.indian_Mar = indian_tourist_arrival_month.Mar_,
    main_table.indian_Apr = indian_tourist_arrival_month.Apr_,
    main_table.indian_May = indian_tourist_arrival_month.May,
    main_table.indian_Jun = indian_tourist_arrival_month.Jun_,
    main_table.indian_July = indian_tourist_arrival_month.July,
    main_table.indian_Aug = indian_tourist_arrival_month.Aug_,
    main_table.indian_Sep = indian_tourist_arrival_month.Sep_,
    main_table.indian_Oct = indian_tourist_arrival_month.Oct_,
    main_table.indian_Nov = indian_tourist_arrival_month.Nov_,
    main_table.indian_Dec = indian_tourist_arrival_month.Dec_,
    main_table.indian_Total = indian_tourist_arrival_month.Total
WHERE main_table.year IS NOT NULL;

ALTER TABLE main_table
ADD COLUMN Holiday_Pleasure INT,
ADD COLUMN Trekking_Mountaineering INT,
ADD COLUMN Business INT,
ADD COLUMN Pilgrimage INT,
ADD COLUMN Official INT,
ADD COLUMN Conv_Conf INT,
ADD COLUMN Others_purpose INT,
ADD COLUMN Not_Specified_purpose INT,
ADD COLUMN purpose_Total INT;

UPDATE main_table
LEFT JOIN purpose ON main_table.year = purpose.Year
SET 
    main_table.Holiday_Pleasure = purpose.Holiday_Pleasure,
    main_table.Trekking_Mountaineering = purpose.`Trekking_&_Mountaineering`,
    main_table.Business = purpose.Business,
    main_table.Pilgrimage = purpose.Pilgrimage,
    main_table.Official = purpose.Official,
    main_table.Conv_Conf = purpose.`Conv_/_Conf_`,
    main_table.Others_purpose = purpose.Others,
    main_table.Not_Specified_purpose = purpose.Not_Specified,
    main_table.purpose_Total = purpose.Total
WHERE main_table.year IS NOT NULL;

ALTER TABLE main_table
ADD COLUMN Male INT,
ADD COLUMN Female INT,
ADD COLUMN sex_Total INT;

UPDATE main_table
LEFT JOIN sex ON main_table.year = sex.year
SET 
    main_table.Male = sex.Male,
    main_table.Female = sex.Female,
    main_table.sex_Total = sex.Total
WHERE main_table.year IS NOT NULL;

ALTER TABLE main_table
ADD COLUMN Third_Country INT,
ADD COLUMN Indian INT,
ADD COLUMN total_tourist_Total INT;

UPDATE main_table
LEFT JOIN total_tourist_arrival ON main_table.year = total_tourist_arrival.Year
SET 
    main_table.Third_Country = total_tourist_arrival.Third_Country,
    main_table.Indian = total_tourist_arrival.Indian,
    main_table.total_tourist_Total = total_tourist_arrival.Total
WHERE main_table.year IS NOT NULL;

ALTER TABLE main_table
ADD COLUMN total_tourist_modeoftrans INT,
ADD COLUMN Annual_Growth_rate INT,
ADD COLUMN Number_air INT,
ADD COLUMN Percent_air INT,
ADD COLUMN Number_land INT,
ADD COLUMN Percent_land INT,
ADD COLUMN avg_length_of_stay INT;

UPDATE main_table
LEFT JOIN tourist_arrival_length ON main_table.year = tourist_arrival_length.year
SET 
    main_table.total_tourist_modeoftrans = tourist_arrival_length.Number_total,
    main_table.Annual_Growth_rate = tourist_arrival_length.Annual_Growth_rate,
    main_table.Number_air = tourist_arrival_length.Number_air,
    main_table.Percent_air = tourist_arrival_length.Percent_air,
    main_table.Number_land = tourist_arrival_length.Number_land,
    main_table.Percent_land = tourist_arrival_length.Percent_land,
    main_table.avg_length_of_stay = tourist_arrival_length.avg_length_of_stay
WHERE main_table.year IS NOT NULL;

ALTER TABLE main_table
ADD COLUMN tourist_Jan INT,
ADD COLUMN tourist_Feb INT,
ADD COLUMN tourist_Mar INT,
ADD COLUMN tourist_Apr INT,
ADD COLUMN tourist_May INT,
ADD COLUMN tourist_Jun INT,
ADD COLUMN tourist_Jul INT,
ADD COLUMN tourist_Aug INT,
ADD COLUMN tourist_Sep INT,
ADD COLUMN tourist_Oct INT,
ADD COLUMN tourist_Nov INT,
ADD COLUMN tourist_Dec INT,
ADD COLUMN monthly_tourist_Total INT;

UPDATE main_table
LEFT JOIN tourist_arrival_month ON main_table.year = tourist_arrival_month.Year
SET 
    main_table.tourist_Jan = tourist_arrival_month.Jan_,
    main_table.tourist_Feb = tourist_arrival_month.Feb_,
    main_table.tourist_Mar = tourist_arrival_month.Mar_,
    main_table.tourist_Apr = tourist_arrival_month.Apr_,
    main_table.tourist_May = tourist_arrival_month.May,
    main_table.tourist_Jun = tourist_arrival_month.Jun_,
    main_table.tourist_Jul = tourist_arrival_month.Jul_,
    main_table.tourist_Aug = tourist_arrival_month.Aug_,
    main_table.tourist_Sep = tourist_arrival_month.Sep_,
    main_table.tourist_Oct = tourist_arrival_month.Oct_,
    main_table.tourist_Nov = tourist_arrival_month.Nov_,
    main_table.tourist_Dec = tourist_arrival_month.Dec_,
    main_table.monthly_tourist_Total = tourist_arrival_month.Total
WHERE main_table.year IS NOT NULL;

ALTER TABLE main_table
ADD COLUMN Australia INT,
ADD COLUMN Bangladesh INT,
ADD COLUMN Canada INT,
ADD COLUMN China INT,
ADD COLUMN France INT,
ADD COLUMN Germany INT,
ADD COLUMN India INT,
ADD COLUMN Italy INT,
ADD COLUMN Japan INT,
ADD COLUMN `South Korea` INT,
ADD COLUMN Malaysia INT,
ADD COLUMN Myanmar INT,
ADD COLUMN Netherlands INT,
ADD COLUMN Spain INT,
ADD COLUMN `Sri Lanka` INT,
ADD COLUMN Thailand INT,
ADD COLUMN `U.S.A.` INT,
ADD COLUMN `U.K.` INT,
ADD COLUMN Others_nationality INT,
ADD COLUMN Total_nationality INT;

UPDATE main_table
JOIN nationality_wide ON main_table.year = nationality_wide.year
SET 
    main_table.Australia = nationality_wide.Australia,
    main_table.Bangladesh = nationality_wide.Bangladesh,
    main_table.Canada = nationality_wide.Canada,
    main_table.China = nationality_wide.China,
    main_table.France = nationality_wide.France,
    main_table.Germany = nationality_wide.Germany,
    main_table.India = nationality_wide.India,
    main_table.Italy = nationality_wide.Italy,
    main_table.Japan = nationality_wide.Japan,
    main_table.`South Korea` = nationality_wide.`South Korea`,
    main_table.Malaysia = nationality_wide.Malaysia,
    main_table.Myanmar = nationality_wide.Myanmar,
    main_table.Netherlands = nationality_wide.Netherlands,
    main_table.Spain = nationality_wide.Spain,
    main_table.`Sri Lanka` = nationality_wide.`Sri Lanka`,
    main_table.Thailand = nationality_wide.Thailand,
    main_table.`U.S.A.` = nationality_wide.`U.S.A.`,
    main_table.`U.K.` = nationality_wide.`U.K.`,
    main_table.Others_nationality = nationality_wide.Others_nationality,
    main_table.Total_nationality = nationality_wide.Total_nationality;

select * from main_table

