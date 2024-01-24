-- Represent all 88 constellations on the night sky
CREATE TABLE `constellation` (
    `id` INT AUTO_INCREMENT,
    `constellation` VARCHAR(30) NOT NULL UNIQUE,
    `iau_abbreviation` CHAR(3) NOT NULL UNIQUE,
    `nasa_abbreviation` CHAR(4) NOT NULL UNIQUE,
    `discoverer` VARCHAR(30) NOT NULL DEFAULT 'Ptolemy',
    `origin` VARCHAR(7) NOT NULL DEFAULT 'ancient',
    `symbolism` VARCHAR(60) NOT NULL,
    PRIMARY KEY(`id`)
);

-- Represent characteristics of the constellations on the night sky
CREATE TABLE `constellation_characteristics` (
    `id` INT AUTO_INCREMENT,
    `constellation_id` INT,
    `right_ascension` DOUBLE NOT NULL,
    `declination` DOUBLE NOT NULL,
    `hemisphere` ENUM('northern', 'southern') NOT NULL,
    `seasonal_visibility` ENUM('winter', 'spring', 'summer', 'autumn') NOT NULL,
    `zodiac` ENUM('yes', 'no') NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`constellation_id`) REFERENCES `constellation`(`id`)
);

-- Represent constellation stars on the night sky
CREATE TABLE `star` (
    `id` INT AUTO_INCREMENT,
    `constellation_id` INT,
    `star` VARCHAR(60) NOT NULL UNIQUE,
    `bayer_designation` VARCHAR(60) NOT NULL UNIQUE,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`constellation_id`) REFERENCES `constellation`(`id`)
);

-- Represent characteristics of the stars in the constellations
CREATE TABLE `star_characteristics` (
    `id` INT AUTO_INCREMENT,
    `star_id` INT,
    `right_ascension` DOUBLE NOT NULL,
    `declination` DOUBLE NOT NULL,
    `distance` DOUBLE NOT NULL,
    `spectral_type` ENUM('O', 'B', 'A', 'F', 'G', 'K', 'M') NOT NULL,
    `mass` DOUBLE NOT NULL,
    `radius` DOUBLE NOT NULL,
    `luminosity` DOUBLE NOT NULL,
    `luminosity_class` ENUM('supergiant', 'bright giant', 'giant', 'subgiant', 'main sequence', 'subdwarf', 'white dwarf') NOT NULL,
    `brightness` DOUBLE NOT NULL,
    `temperature` INT NOT NULL,
    `color` SET('white', 'blue', 'yellow', 'orange', 'red') NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`star_id`) REFERENCES `star`(`id`)
);

-- Create indexes to speed up common searches
CREATE INDEX `constellation_name` ON `constellation`(`constellation`);
CREATE INDEX `star_name` ON `star`(`star`);
CREATE INDEX `hemispheres` ON `constellation_characteristics`(`hemisphere`);
CREATE INDEX `distances` ON `star_characteristics`(`distance`);

-- Create views to optimize common searches
CREATE VIEW `northern_hemisphere_constellations` AS
SELECT *
FROM `constellation`
WHERE `id` IN (
    SELECT `constellation_id`
    FROM `constellation_characteristics`
    WHERE `hemisphere` = 'northern'
);

CREATE VIEW `southern_hemisphere_constellations` AS
SELECT *
FROM `constellation`
WHERE `id` IN (
    SELECT `constellation_id`
    FROM `constellation_characteristics`
    WHERE `hemisphere` = 'southern'
);

CREATE VIEW `zodiac_constellations` AS
SELECT *
FROM `constellation`
WHERE `id` IN (
    SELECT `constellation_id`
    FROM `constellation_characteristics`
    WHERE `zodiac` = 'yes'
);
