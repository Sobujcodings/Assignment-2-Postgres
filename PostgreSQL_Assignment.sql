-- Active: 1747604834830@@127.0.0.1@5432@conservation_db
-- assignment 2

CREATE DATABASE conservation_db;

-- table 1
SELECT * FROM rangers;
-- DROP TABLE rangers;
CREATE Table rangers(
    ranger_id SERIAL UNIQUE PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);

INSERT INTO rangers VALUES
    (1, 'Alice Green', 'Northern Hills'),
    (2, 'Bob White', 'River Delta'),
    (3, 'Carol King', 'Mountain Range');


-- table 2
SELECT * FROM species ;
DROP TABLE species ;
CREATE Table species (
    species_id SERIAL UNIQUE PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date  DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
  ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
  ('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
  ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
  ('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

 

-- table 3
SELECT * FROM sightings ;
DROP TABLE sightings ;
CREATE Table sightings (
    sighting_id  SERIAL UNIQUE PRIMARY KEY,
    species_id INTEGER REFERENCES species(species_id),
    ranger_id INTEGER REFERENCES rangers(ranger_id),
    location TEXT NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT
);
INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);





-- Problem-1
INSERT INTO rangers (ranger_id,name,region) VALUES(4,'Derek Fox', 'Coastal Plains');


-- Problem-2



-- Problem-3 (sightings r location e "%%Pass%%" thakte hobe)
SELECT * FROM sightings 
    WHERE location LIKE '%Pass%';




-- Problem-7 ( update all species b4 1800 to status 'Historic')
UPDATE species
    set conservation_status = 'Historic'
    WHERE EXTRACT(year FROM discovery_date) < 1800;


-- problem-8
SELECT sighting_id, 
   CASE
   WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
   WHEN EXTRACT(HOUR FROM sighting_time) >= 12 AND EXTRACT(HOUR FROM sighting_time) <= 17 THEN 'Afternoon'
   ELSE 'Evening'
   END as time_of_day 
FROM sightings;


-- problem-4 (rangers id k group kore aksateh kore count ber koro from sighting table join kore nam dekhao)
SELECT name, count(*) as total_sightings FROM sightings
    JOIN rangers on sightings.ranger_id = rangers.ranger_id
    GROUP BY rangers.name
    ORDER BY rangers.name ASC;



-- prblm-5
SELECT common_name FROM species
    LEFT JOIN sightings on species.species_id = sightings.species_id 
    WHERE sightings.species_id IS NULL;  



-- prblm-9 (delete rangers who have never sighted any)
-- DELETE FROM rangers;

