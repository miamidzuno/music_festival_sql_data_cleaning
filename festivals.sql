DESCRIBE festivals;

SELECT COUNT(*) FROM festivals;

SELECT * FROM festivals
LIMIT 10;


SELECT 
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_nulls,
    SUM(CASE WHEN attendance_age IS NULL THEN 1 ELSE 0 END) AS attendance_nulls,
    SUM(CASE WHEN visitor_type IS NULL THEN 1 ELSE 0 END) AS visitor_nulls,
    SUM(CASE WHEN economic_impact IS NULL THEN 1 ELSE 0 END) AS economic_nulls,
    SUM(CASE WHEN music_genre IS NULL THEN 1 ELSE 0 END) AS genre_nulls
FROM festivals;


SELECT country, COUNT(*) as count
FROM festivals
GROUP BY country
ORDER BY count DESC;

CREATE TABLE festivals_backup AS SELECT * FROM festivals;

SELECT COUNT(*) FROM festivals_backup;

--------------------------------------------------------------------------------------

ALTER TABLE festivals
RENAME COLUMN attendance_age TO age_range;

SELECT * FROM festivals LIMIT 5;

-------------------------------------------------------------------------------------

SELECT DISTINCT 
    LEFT(economic_impact, 5) as currency_prefix,
    COUNT(*) as count
FROM festivals
GROUP BY currency_prefix
ORDER BY count DESC;


ALTER TABLE festivals
ADD COLUMN currency VARCHAR(10);

SET SQL_SAFE_UPDATES = 0;

UPDATE festivals
SET currency = 
    CASE 
        WHEN economic_impact LIKE 'USD%' THEN 'USD'
        WHEN economic_impact LIKE 'BJ%' THEN 'GBP'
        WHEN economic_impact LIKE 'DKK%' THEN 'DKK'
        WHEN economic_impact LIKE 'AU$%' THEN 'AUD'
        WHEN economic_impact LIKE 'в,¬%' THEN 'EUR'
        ELSE 'Unknown'
    END;

SET SQL_SAFE_UPDATES = 1;


SELECT currency, COUNT(*) as count
FROM festivals
GROUP BY currency
ORDER BY count DESC;


SELECT economic_impact, HEX(LEFT(economic_impact, 3))
FROM festivals
LIMIT 5;


SET SQL_SAFE_UPDATES = 0;

UPDATE festivals
SET currency = 
    CASE 
        WHEN economic_impact LIKE 'USD%' THEN 'USD'
        WHEN economic_impact LIKE 'DKK%' THEN 'DKK'
        WHEN economic_impact LIKE 'AU$%' THEN 'AUD'
        WHEN HEX(LEFT(economic_impact, 2)) = 'D092' THEN 'GBP'
        WHEN HEX(LEFT(economic_impact, 3)) = 'D0B2E2' THEN 'EUR'
        ELSE 'Unknown'
    END;

SET SQL_SAFE_UPDATES = 1;


SELECT currency, COUNT(*) as count
FROM festivals
GROUP BY currency
ORDER BY count DESC;


SET SQL_SAFE_UPDATES = 0;

UPDATE festivals
SET currency = 'EUR'
WHERE HEX(LEFT(economic_impact, 6)) = 'D0B2E2809A';

UPDATE festivals
SET currency = 'GBP'
WHERE HEX(LEFT(economic_impact, 4)) = 'D092D0';

SET SQL_SAFE_UPDATES = 1;


SELECT currency, COUNT(*) as count
FROM festivals
GROUP BY currency
ORDER BY count DESC;


SELECT LEFT(economic_impact, 10), COUNT(*)
FROM festivals
WHERE currency = 'Unknown'
GROUP BY LEFT(economic_impact, 10)
LIMIT 10;



SET SQL_SAFE_UPDATES = 0;

UPDATE festivals
SET currency = 'GBP'
WHERE economic_impact LIKE CONCAT(CHAR(0xD0), CHAR(0x92), '%');

UPDATE festivals
SET currency = 'EUR'
WHERE economic_impact LIKE CONCAT(CHAR(0xD0), CHAR(0xB2), '%');

SET SQL_SAFE_UPDATES = 1;


SELECT currency, COUNT(*) as count
FROM festivals
GROUP BY currency
ORDER BY count DESC;


SET SQL_SAFE_UPDATES = 0;

UPDATE festivals
SET currency = 'GBP'
WHERE economic_impact LIKE CONCAT(CHAR(0xD0), CHAR(0x92), '%')
OR economic_impact LIKE 'BJ%';

SET SQL_SAFE_UPDATES = 1;


SELECT currency, COUNT(*) as count
FROM festivals
GROUP BY currency
ORDER BY count DESC;

SET SQL_SAFE_UPDATES = 0;

UPDATE festivals
SET currency = 'GBP'
WHERE currency = 'Unknown';

SET SQL_SAFE_UPDATES = 1;

SELECT currency, COUNT(*) as count
FROM festivals
GROUP BY currency
ORDER BY count DESC;

--------------------------------------------------------------

SELECT economic_impact, currency
FROM festivals
LIMIT 10;


ALTER TABLE festivals
ADD COLUMN amount_millions INT;


SET SQL_SAFE_UPDATES = 0;

UPDATE festivals
SET amount_millions = CAST(
    REGEXP_REPLACE(
        SUBSTRING_INDEX(economic_impact, ' million', 1),
        '[^0-9]', ''
    ) AS UNSIGNED
);

SET SQL_SAFE_UPDATES = 1;


SELECT economic_impact, currency, amount_millions
FROM festivals
LIMIT 10;

ALTER TABLE festivals
DROP COLUMN economic_impact;

-------------------------------------------------------------------------

SELECT * FROM festivals LIMIT 10;