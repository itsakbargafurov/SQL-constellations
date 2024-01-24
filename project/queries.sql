-- Find all constellations discovered by Ptolemy
SELECT *
FROM `constellation`
WHERE `discoverer` = 'Ptolemy';

-- Find all constellations visible in spring on the southern night sky
SELECT *
FROM `constellation`
WHERE `id` IN (
    SELECT `constellation_id`
    FROM `constellation_characteristics`
    WHERE `hemisphere` = 'southern'
    AND `seasonal_visibiltiy` = 'spring'
);

-- Find all constellations with NASA abbreviation that starts with A
SELECT *
FROM `constellation`
WHERE `nasa_abbreviation` LIKE 'A%';

-- Find all non-zodiac constellations
SELECT *
FROM `constellation`
WHERE `id` IN (
    SELECT `constellation_id`
    FROM `constellation_characteristics`
    WHERE `zodiac` = 'no'
);

-- Find all stars in Saggitarius constellation
SELECT *
FROM `star`
WHERE `constellation_id` = (
    SELECT `id`
    FROM `constellation`
    WHERE `constellation` = 'Saggitarius'
);

-- Find all stars with spectral type G
SELECT *
FROM `star`
WHERE `id` IN (
    SELECT `star_id`
    FROM `star_characteristics`
    WHERE `spectral_type`= 'G'
);

-- Find all stars in Orion constellation that have temperature higher than 10,000 K, radius greater than 20 solar radius, and mass bigger than 5 solar masses
SELECT `constellation`, `star`, `temperature`, `mass`, `radius`
FROM `star`
JOIN `constellation` ON `stars`.`constellation_id` = `constellations`.`id`
JOIN `star_characteristics` ON `stars`.`id` = `stars_characteristics`.`star_id`
WHERE `temperature` > 10000
AND `radius` > 20
AND `mass` > 5;

-- Add a new constellation
INSERT INTO `constellation` ('constellation', 'iau_abbreviation', 'nasa_abbreviation', 'symbolism')
VALUES ('Taurus', 'Tau', 'Taur', 'bull');

-- Add a new star
INSERT INTO `star` ('star', 'bayer_designation')
VALUES ('Rukbat', 'Alpha Sagittarii');
