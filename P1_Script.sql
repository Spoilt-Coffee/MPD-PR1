-- 2. CREATED THE TABLE
CREATE TABLE company(
        id SERIAL PRIMARY KEY,
        name VARCHAR NOT NULL UNIQUE,
        headquarters VARCHAR,
        established_year INTEGER,
        ceo VARCHAR
);

-- 3. ADDED VALUES TO TABLE
INSERT INTO company(name, headquarters, established_year, ceo) VALUES
        ('Apple', 'California, US', 1976, 'Tim Cook'),
        ('Amazon', 'Washington, US', 1994, 'Andy Jassy'),
        ('Alphabet', 'California, US', 2015, 'Sundar Pichai'),
        ('Microsoft', 'Washington, US', 1975, 'Satya Nadella'),
        ('Tencent', 'Shenzhen, China', 1998, 'Ma Huateng'),
        ('Meta', 'California, US', 2004, 'Mark Zuckerberg'),
        ('TSMC', 'Hsinchu, Taiwan', 1987, 'C.C.Wei'),
        ('Nvidia', 'California, US', 1993, 'Jensen Huang'),
        ('Salesforce', 'California, US', 1999, 'Marc Benioff'),
        ('IBM', 'New York, US', 1911, 'Arvind Krishna')
;

-- 5. ADDED NEW COLUMN 'industry' AND SET DEFAULT VALUES TO 'tech'
ALTER TABLE company 
	ADD industry VARCHAR(20) 
	DEFAULT 'tech'
;

-- 6. UPDATED THE INDUSTRY VALUE OF 'Apple' TO 'Consumer electronics'
UPDATE company 
	SET industry = 'Consumer electronics' 
	WHERE name = 'Apple'
;	

-- PRINTS OUT THE TABLE ORDERED BY 'id'
SELECT * FROM company 
	ORDER BY id
;

-- 4. PRINTS OUT THE TABLE ORDERED BY 'established_year' IN DESCENDING ORDER
SELECT * FROM company 
	ORDER BY established_year DESC
;

-- 4. PRINTS OUT THE TABLE [RENAMED 'name' TO 'most_recently_established'] WHERE 'established_year' IS MAX VALUE
SELECT id, name AS most_recently_established, headquarters, established_year, ceo, industry
	FROM company
	WHERE established_year = (SELECT MAX(established_year) FROM company)
;

-- 6. PRINTS OUT THE TABLE WHERE 'name' STARTS WITH 'M', ORDERED BY 'established_year' IN DESCENDING ORDER
SELECT ceo, established_year 
	FROM company 
	WHERE name LIKE 'M%'
	ORDER BY established_year DESC
;

-- 7. PRINTS OUT THE TABLE WHERE COLUMN 'industry' HAS VALUE 'tech' AND HEADQUARTES IN THE US,  ORDERED BY 'established_year' IN ASCENDING ORDER
SELECT name, ceo, established_year 
	FROM company 
	WHERE industry = 'tech' AND headquarters LIKE '%US'
	ORDER BY established_year
;

/*
8. PRINTS OUT COLUMNS 'headquarters' AND ['COUNT(headquarters)' RENAMED TO 'number_of_companies_based_here'], ORDERED BY 'COUNT(headquarters)' IN DESCENDING ORDER, WHERE COLUMN 'industry' HAS VALUE 'tech' AND HEADQUARTES IN THE US. 

WORKS BY: 
	FILTERING FOR RIGHT CONDITIONS.
	GROUPING TOGETHER ROWS WITH THE SAME 'headquarter' VALUE.
	COUNTING THE NUMBER OF DUPLICATES IN EACH GROUP, KEEPING ONLY VALUES GREATER THAN 1.
	OUTPUTS THE 'headquarters' AND 'COUNT(headquarters)' VALUES
*/

SELECT headquarters, COUNT(headquarters) AS number_of_companies_based_here
	FROM company 
	WHERE industry = 'tech' AND headquarters LIKE '%US'
	GROUP BY headquarters
	HAVING COUNT(headquarters) > 1
;

-- 1. DELETES THE TABLE
DROP TABLE company;