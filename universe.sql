CREATE DATABASE universe;

-- 1. CREATE TABLE galaxy

CREATE TABLE galaxy(
	galaxy_id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL UNIQUE,
	galaxy_type TEXT NOT NULL,
	mass TEXT,
	number_of_stars TEXT,
	has_known_stars BOOLEAN
);

-- 2. Insert data into table 'galaxy'
INSERT INTO galaxy (name, galaxy_type, mass, number_of_stars, has_known_stars) VALUES
	('The Milky Way Galaxy', 'barred spiral galaxy', '1.15×10 ** 12', '100–500 billion', True),
	('The Andromeda Galaxy', 'barred spiral galaxy', '(1.5±0.5)×10 ** 12', '~1 trillion', True),
	('The Large Magellanic Cloud', 'Magellanic spiral', '1×10 ** 10', '20 billion', 'True'),
	('The Triangulum Galaxy', 'spiral galaxy', '5×10 ** 10', '40 billion', 'True'),
	('Barnard''s Galaxy', 'barred irregular galaxy', 'NULL', 'NULL', 'True'),
	('Sextans A', 'dwarf irregular galaxy', 'NULL', 'NULL', 'False'),
	('Sextans B', 'irregular galaxy', 'NULL', 'NULL', 'False');

-- 3. CREATE TABLE constellation
CREATE TABLE constellation(
	constellation_id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL UNIQUE,
	pronunciation TEXT,
	abbreviation TEXT,
	symbolism TEXT,
	quadrant TEXT,
	area TEXT,
	main_stars INT,
	stars_with_planets INT,
	brightest_star TEXT,
	galaxy_id INT REFERENCES galaxy (galaxy_id)
);

-- 4. Insert data into table 'constellation'
INSERT INTO constellation 
(name, pronunciation, abbreviation, symbolism, quadrant, area, main_stars, stars_with_planets, brightest_star, galaxy_id)
VALUES
	('Does not have one.', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', 1, 1, 'The Sun', 1),
	('Ophiuchus', '[ɒˈfjuːkəs]', 'Oph', 'the serpent-bearer', 'SQ3', '948 sq. deg.', 10, 15, 'α Oph', 1),
	('Centaurus', '[senˈtɔːrəs]', 'Cen', 'the Centaur', 'SQ3', '1060 sq. deg.', 11, 15, 'α Cen ', 1),
	('Canis Major', '[ˌkeɪnɪs ˈmeɪdʒər]', 'CMa', 'the greater dog', 'SQ2', '380 sq. deg.', 8, 7, 'Sirius (α CMa)', 1),
	('Orion', '[əˈraɪən]', 'Ori', 'Orion, the Hunter', 'NQ1', '594 sq. deg.', 7, 10, 'Rigel (β Ori)', 1),
	('Leo', '[ˈliːou]', 'Leo', 'the Lion', 'NQ2', '947 sq. deg.', 9, 13, 'Regulus (α Leo)', 1);

-- 5. CREATE TABLE star
CREATE TABLE star(
	star_id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL UNIQUE,
	another_name VARCHAR DEFAULT NULL,
	evolutionary_stage TEXT NOT NULL,
	spectral_type TEXT NOT NULL,
	mass TEXT,
	constellation_id INT REFERENCES constellation (constellation_id),
	number_of_planets INT,
	interesting_facts TEXT,
	galaxy_id INT REFERENCES galaxy (galaxy_id)
);

-- 6. Insert data into table 'star'
INSERT INTO star
(name, another_name, evolutionary_stage, spectral_type, mass, constellation_id, number_of_planets, interesting_facts, galaxy_id) 
VALUES
	('The Sun', 'NULL', 'yellow dwarf', 'G2V', '1.9885×10 ** 30 kg', 1, 8, 'Does not belong to any constellation.', 1),
	('Sirius A', 'NULL', 'main sequence', 'A0mA1 Va', '2.063±0.023', 4, 0, 'Sirius is the brightest star in the night sky.', 1),
	('Sirius B', 'NULL', 'white dwarf', 'DA2', '1.018 ± 0.011', 4, 0, 'NULL', 1),
	('Alpha Centauri A', 'Rigil Kentaurus', 'yellow dwarf', 'G2V', '1.0788±0.0029', 3, 0, 'NULL', 1),
	('Alpha Centauri B', 'Toliman', 'orange dwarf', 'K1V', '0.9092±0.0025', 3, 0, 'NULL', 1),
	('Alpha Centauri C', 'Proxima Centauri', 'red dwarf', 'M5.5 Ve', 'NULL', 3, 1, 'Proxima Centauri is  the closest star to the Sun at 4.2465 light-years (1.3020 pc).', 1),
	('Betelgeuse', 'NULL', 'red supergiant', 'M1-2', '16.5-19.0', 5, 0, 'Betelgeuse is generally considered to be a single isolated star and a runaway star, not currently associated with any cluster or star-forming region, although its birthplace is unclear.', 1);

-- 7. CREATE TABLE planet
CREATE TABLE planet(
	planet_id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL UNIQUE,
	planet_type TEXT,
	planet_mass NUMERIC,
	surface_temperature TEXT,
	distance_from_earth TEXT,
	gravity NUMERIC,
	habitable BOOLEAN,
	star_id INT
);

-- 8. Insert data into table 'planet'
INSERT INTO planet 
	(name, planet_type, planet_mass, surface_temperature, distance_from_earth, gravity, habitable, star_id)
VALUES
	('Mercury', 'terrestrial', 0.055, 'from −190 to +430°C', 'from 82 to 217 m.km.', 3.7, True, 1),
	('Venus', 'terrestrial', 0.815, '462°C', 'from 38 to 261 m.km.', 8.870, False, 1),
	('Earth', 'terrestrial', 1.0, 'from −89,2 to +56,7°C', '0', 9.8, False, 1),
	('Mars', 'terrestrial', 0.107, 'from −153 to +20°C', 'from 55,76 to 401 m.km.', 3.711, False, 1),
	('Jupiter', 'Jovian', 317.8, 'from 930 to +1330°C', '591,292 m.km.', 24.79, False, 1),
	('Saturn', 'Jovian', 95.0, 'from −173 to −113°C', 'from 1195 to 1660 m.km.', 10.44, False, 1),
	('Uranus', 'Jovian', 14.54, '−224°C', 'from 2,6 to 3,15 b.km.', 11.15, False, 1),
	('Neptune', 'Jovian', 17.147, 'from −221,4 to −201,15 °C', 'from 4,3 to 4,3 b.km.', 8.87, False, 1),
	('Gliese 581 c', 'terrestrial', 5.36, '−3 °C', '20.42 light years', 4.92, False, 2),
	('J1407b', 'Jovian', 0.9, '70°C', '433.8 light years', NULL, False, 2),
	('Gliese 1214 b', 'ocean', 6.55, 'from 120 to 282 °C', '40 light years', 0.91, False, 4),
	('Gliese 436 b', 'solid water', 21.36, '300°C', '33.01 light years', 11.57, False, 3);

-- 9. CREATE TABLE moon
CREATE TABLE moon(
	moon_id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL UNIQUE,
	discovered_by TEXT NOT NULL,
	discovery_date TEXT NOT NULL,
	volume TEXT,
	planet_id INT REFERENCES planet(planet_id)
);

-- 10. Insert data into table 'moon'
INSERT INTO moon
	(name, discovered_by, discovery_date, volume, planet_id)
VALUES
	('The Moon', 'People', 'Always known', '2.1958×1010 km3', 3),
	('Deimos', 'Asaph Hall', '12 August 1877', '999.78 km3', 4),
	('Phobos', 'Asaph Hall', '18 August 1877', '5783.61 km3', 4),
	('Io', 'Galileo Galilei', '8 January 1610', NULL, 5),
	('Europa', 'Galileo Galilei', '8 January 1610', '1.593×1010 km3', 5),
	('Ganymede', 'Galileo Galilei', '7 January 1610', '7.66×1010 km3', 5),
	('Callisto', 'Galileo Galilei', '7 January 1610', '5.9×1010 km3', 5),
	('Amalthea', 'E. E. Barnard', '9 September 1892', '(2.43±0.22)×106 km3', 5),
	('Himalia', 'Charles D. Perrine', '3 December 1904', NULL, 5),
	('Elara', 'Charles D. Perrine', '5 January 1905', NULL, 5),
	('Pasiphae', 'Philibert J. Melotte', '27 January 1908', NULL, 5),
	('Sinope', 'Seth B. Nicholson', '21 July 1914', NULL, 5),
	('Lysithea', 'Seth B. Nicholson', '6 July 1938', NULL, 5),
	('Carme', 'Seth B. Nicholson', '30 July 1938', NULL, 5),
	('Ananke', 'Seth B. Nicholson', '28 September 1951', NULL, 5),
	('Leda', 'Charles T. Kowal', '14 September 1974', NULL, 5),
	('Titan', 'Christiaan Huygens', 'March 25, 1655', '7.16×1010 km3', 6),
	('Iapetus', 'G. D. Cassini', 'October 25, 1671', NULL, 6),
	('Rhea', 'G. D. Cassini', 'December 23, 1672', NULL, 6),
	('Tethys', 'G. D. Cassini', '11 March 1684', NULL, 6);





