-- Active: 1752557454001@@127.0.0.1@5432@conservation_db
CREATE DATABASE conservation_db;


CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);

CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(60) NOT NULL,
    scientific_name VARCHAR(60) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(30) DEFAULT 'Unknown'
);

CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id),
    species_id INT REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL,
    "location" VARCHAR(50) NOT NULL,
    notes TEXT
);


INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

SELECT * FROM rangers;

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


SELECT * FROM species;

INSERT INTO sightings (species_id, ranger_id, "location", sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

SELECT * FROM sightings;


-- problem 1
INSERT INTO rangers (name, region) VALUES
('Derek Fox', 'Coastal Plains');

SELECT * FROM rangers;

--problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count
from sightings;


--problem 3
SELECT * FROM sightings
WHERE location LIKE '%Pass%';

-- problem 4
SELECT r.name, count(s.sighting_id) as total_sightings FROM rangers r
join sightings s on r.ranger_id = s.ranger_id 
GROUP BY r.name;

--  problem 5
SELECT common_name FROM species
WHERE species_id Not In(
    SELECT DISTINCT species_id FROM sightings
);

--problem 6
SELECT sp.common_name, s.sighting_time, r.name from sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;


--problem 7
UPDATE species SET conservation_status = 'Historic'
WHERE EXTRACT(YEAR FROM discovery_date) < 1800;

SELECT * FROM species;


--problem 8
SELECT sighting_id, CASE 
    WHEN EXTRACT(hour from sighting_time)<12  THEN 'Morning'
    When EXTRACT(hour from sighting_time) BETWEEN 12 and 17 THEN 'Afternoon'  
    ELSE  'Evening'
END as time_of_day
FROM sightings;

--problem 9
DELETE from rangers
where ranger_id not in(
    SELECT DISTINCT ranger_id FROM sightings
);

SELECT * FROM rangers;