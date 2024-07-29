/* galaxy

                                            Table "public.galaxy"
+-----------------+-----------------------+-----------+----------+-------------------------------------------+
|     Column      |         Type          | Collation | Nullable |                  Default                  |
+-----------------+-----------------------+-----------+----------+-------------------------------------------+
| galaxy_id       | integer               |           | not null | nextval('galaxy_galaxy_id_seq'::regclass) |
| name            | character varying(50) |           | not null |                                           |
| description     | text                  |           |          |                                           |
| galaxy_type     | character varying(30) |           |          |                                           |
| number_of_stars | bigint                |           |          |                                           |
+-----------------+-----------------------+-----------+----------+-------------------------------------------+
Indexes:
    "galaxy_pkey" PRIMARY KEY, btree (galaxy_id)
    "galaxy_name_key" UNIQUE CONSTRAINT, btree (name)
Referenced by:
    TABLE "star" CONSTRAINT "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

*/

INSERT INTO galaxy (name, description, galaxy_type, number_of_stars) VALUES
('Milky Way', 'The Milky Way is the galaxy that contains our Solar System. It is a barred spiral galaxy with several arms.', 'Barred Spiral', 100000000000),
('Andromeda', 'The Andromeda Galaxy is the nearest spiral galaxy to the Milky Way and is on a collision course with it.', 'Spiral', 1000000000000),
('Triangulum', 'The Triangulum Galaxy is a member of the Local Group and the third-largest galaxy in that group.', 'Spiral', 40000000000),
('Whirlpool', 'The Whirlpool Galaxy is a classic spiral galaxy with well-defined spiral arms, located in the constellation Canes Venatici.', 'Spiral', 100000000000),
('Sombrero', 'The Sombrero Galaxy is an unbarred spiral galaxy in the constellation Virgo, known for its bright nucleus and large central bulge.', 'Unbarred Spiral', 80000000000);


--universe=> SELECT galaxy_id, name FROM galaxy;
+-----------+------------+
| galaxy_id |    name    |
+-----------+------------+
|         1 | Milky Way  |
|         2 | Andromeda  |
|         3 | Triangulum |
|         4 | Whirlpool  |
|         5 | Sombrero   |
|         6 | Messier 87 |
+-----------+------------+

INSERT INTO galaxy (name, description, galaxy_type, number_of_stars) VALUES ('Messier 87', 'Messier 87 is a giant elliptical galaxy in the Virgo Cluster, known for its large size and powerful radio emissions.', 'Elliptical', 1200000000000);

/* star

                                         Table "public.star"
+-------------+-----------------------+-----------+----------+---------------------------------------+
|   Column    |         Type          | Collation | Nullable |                Default                |
+-------------+-----------------------+-----------+----------+---------------------------------------+
| star_id     | integer               |           | not null | nextval('star_star_id_seq'::regclass) |
| name        | character varying(50) |           | not null |                                       |
| galaxy_id   | integer               |           |          |                                       |
| description | text                  |           |          |                                       |
| star_type   | text                  |           |          |                                       |
| age         | bigint                |           |          |                                       |
+-------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "star_pkey" PRIMARY KEY, btree (star_id)
    "star_name_key" UNIQUE CONSTRAINT, btree (name)
Foreign-key constraints:
    "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
Referenced by:
    TABLE "planet" CONSTRAINT "planet_star_id_fkey" FOREIGN KEY (star_id) REFERENCES star(star_id)
	
*/

INSERT INTO star (name, galaxy_id, description, star_type, age) VALUES
('Sun', 1, 'The Sun is the star at the center of the Solar System.', 'G-type Main-Sequence', 4600000000),
('Betelgeuse', 1, 'Betelgeuse is a red supergiant star in the Milky Way.', 'Red Supergiant', 8000000),
('Proxima Centauri', 2, 'Proxima Centauri is the closest known star to the Sun, part of the Alpha Centauri star system.', 'Red Dwarf', 4500000000),
('Alpha Centauri A', 2, 'Alpha Centauri A is the primary star in the Alpha Centauri system, located in the constellation Centaurus.', 'G-type Main-Sequence', 5500000000),
('M33 X-7', 3, 'M33 X-7 is a binary star system containing a black hole in the Triangulum Galaxy.', 'Binary System', 240000000),
('WR 104', 3, 'WR 104 is a Wolf-Rayet star known for its spiral dust plume.', 'Wolf-Rayet', 8000000),
('Eta Carinae', 4, 'Eta Carinae is a highly luminous hypergiant star in the Whirlpool Galaxy.', 'Hypergiant', 3000000),
('NGC 5194-V1', 4, 'NGC 5194-V1 is a variable star in the Whirlpool Galaxy.', 'Variable Star', 10000000),
('NGC 4594-V1', 5, 'NGC 4594-V1 is a Cepheid variable star in the Sombrero Galaxy.', 'Cepheid Variable', 30000000),
('NGC 4594-RSG1', 5, 'NGC 4594-RSG1 is a red supergiant star in the Sombrero Galaxy.', 'Red Supergiant', 20000000),
('M87 Star', 6, 'A star in the giant elliptical galaxy M87.', 'Giant Star', 7000000000),
('M87-V1', 6, 'M87-V1 is a variable star in the elliptical galaxy M87.', 'Variable Star', 5000000000);

--universe=> SELECT star_id, name, galaxy_id FROM star;
+---------+------------------+-----------+
| star_id |       name       | galaxy_id |
+---------+------------------+-----------+
|       1 | Sun              |         1 |
|       2 | Betelgeuse       |         1 |
|       3 | Proxima Centauri |         2 |
|       4 | Alpha Centauri A |         2 |
|       5 | M33 X-7          |         3 |
|       6 | WR 104           |         3 |
|       7 | Eta Carinae      |         4 |
|       8 | NGC 5194-V1      |         4 |
|       9 | NGC 4594-V1      |         5 |
|      10 | NGC 4594-RSG1    |         5 |
|      11 | M87 Star         |         6 |
|      12 | M87-V1           |         6 |
+---------+------------------+-----------+

/* planet

                                              Table "public.planet"
+---------------------+-----------------------+-----------+----------+-------------------------------------------+
|       Column        |         Type          | Collation | Nullable |                  Default                  |
+---------------------+-----------------------+-----------+----------+-------------------------------------------+
| planet_id           | integer               |           | not null | nextval('planet_planet_id_seq'::regclass) |
| name                | character varying(50) |           | not null |                                           |
| star_id             | integer               |           |          |                                           |
| planet_order        | integer               |           |          |                                           |
| star_distance_in_au | numeric(5,2)          |           |          |                                           |
| min_temp_degrees    | integer               |           |          |                                           |
| max_temp_degrees    | integer               |           |          |                                           |
| description         | text                  |           |          |                                           |
| has_landed          | boolean               |           |          |                                           |
+---------------------+-----------------------+-----------+----------+-------------------------------------------+

*/

INSERT INTO planet (name, star_id, planet_order, star_distance_in_au, min_temp_degrees, max_temp_degrees, description, has_landed) VALUES
('Mercury', 1, 1, 0.39, -173, 427, 'The closest planet to the Sun and the smallest in the Solar System.', false),
('Venus', 1, 2, 0.72, 462, 462, 'The second planet from the Sun, known for its thick, toxic atmosphere and extreme heat.', true),
('Earth', 1, 3, 1.00, -88, 58, 'The third planet from the Sun and the only known planet to support life.', true),
('Mars', 1, 4, 1.52, -125, 20, 'The fourth planet from the Sun, known for its red color and potential for past water.', true),
('Jupiter', 1, 5, 5.20, -145, -108, 'The fifth planet from the Sun and the largest in the Solar System.', false),
('Saturn', 1, 6, 9.58, -178, -178, 'The sixth planet from the Sun, known for its prominent ring system.', false),
('Betelgeuse I', 2, 1, 0.84, -180, 430, 'A hypothetical planet in the vicinity of Betelgeuse.', false),
('Betelgeuse II', 2, 2, 1.76, -160, 450, 'A second hypothetical planet orbiting Betelgeuse.', false),
('Proxima b', 3, 1, 0.05, -39, 30, 'A planet in the habitable zone of Proxima Centauri, similar in size to Earth.', false),
('Proxima c', 3, 2, 1.5, -150, -100, 'A super-Earth exoplanet orbiting Proxima Centauri.', false),
('Proxima d', 3, 3, 0.03, -40, 25, 'A small planet very close to Proxima Centauri.', false),
('Proxima e', 3, 4, 0.08, -50, 20, 'A hypothetical planet orbiting Proxima Centauri.', false);

--universe=> SELECT planet_id, name, star_id FROM planet;
+-----------+---------------+---------+
| planet_id |     name      | star_id |
+-----------+---------------+---------+
|         1 | Mercury       |       1 |
|         2 | Venus         |       1 |
|         3 | Earth         |       1 |
|         4 | Mars          |       1 |
|         5 | Jupiter       |       1 |
|         6 | Saturn        |       1 |
|         7 | Betelgeuse I  |       2 |
|         8 | Betelgeuse II |       2 |
|         9 | Proxima b     |       3 |
|        10 | Proxima c     |       3 |
|        11 | Proxima d     |       3 |
|        12 | Proxima e     |       3 |
+-----------+---------------+---------+


/* moon

                                            Table "public.moon"
+------------------+-----------------------+-----------+----------+---------------------------------------+
|      Column      |         Type          | Collation | Nullable |                Default                |
+------------------+-----------------------+-----------+----------+---------------------------------------+
| moon_id          | integer               |           | not null | nextval('moon_moon_id_seq'::regclass) |
| name             | character varying(50) |           | not null |                                       |
| planet_id        | integer               |           |          |                                       |
| description      | text                  |           |          |                                       |
| has_landed       | boolean               |           |          |                                       |
| moon_order       | integer               |           |          |                                       |
| min_temp_degrees | integer               |           |          |                                       |
| max_temp_degrees | integer               |           |          |                                       |
+------------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "moon_pkey" PRIMARY KEY, btree (moon_id)
    "moon_name_key" UNIQUE CONSTRAINT, btree (name)
Foreign-key constraints:
    "moon_planet_id_fkey" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
	
*/

INSERT INTO moon (name, planet_id, description, has_landed, moon_order, min_temp_degrees, max_temp_degrees) VALUES
('Moon', 3, 'The only natural satellite of Earth.', true, 1, -173, 127),
('Phobos', 4, 'The larger and closer of the two natural satellites of Mars.', false, 1, -112, -4),
('Deimos', 4, 'The smaller and farther of the two natural satellites of Mars.', false, 2, -112, -4),
('Io', 5, 'The innermost of the four Galilean moons of Jupiter.', false, 1, -163, -143),
('Europa', 5, 'The smallest of the four Galilean moons of Jupiter.', false, 2, -160, -160),
('Ganymede', 5, 'The largest moon in the Solar System.', false, 3, -163, -113),
('Callisto', 5, 'The second-largest moon of Jupiter.', false, 4, -139, -129),
('Amalthea', 5, 'A small, irregularly shaped moon of Jupiter.', false, 5, -183, -143),
('Himalia', 5, 'The largest irregular satellite of Jupiter.', false, 6, -183, -143),
('Thebe', 5, 'An inner moon of Jupiter.', false, 7, -183, -143),
('Adrastea', 5, 'A small moon orbiting within Jupiter’s ring system.', false, 8, -183, -143),
('Metis', 5, 'The innermost moon of Jupiter.', false, 9, -183, -143),
('Titan', 6, 'The largest moon of Saturn and the second-largest natural satellite in the Solar System.', false, 1, -179, -179),
('Enceladus', 6, 'A small, icy moon of Saturn with cryovolcanoes.', false, 2, -201, -198),
('Mimas', 6, 'A small moon of Saturn with a large crater.', false, 3, -209, -209),
('Tethys', 6, 'A mid-sized moon of Saturn with a large rift valley.', false, 4, -187, -187),
('Dione', 6, 'A mid-sized moon of Saturn with bright ice cliffs.', false, 5, -186, -186),
('Rhea', 6, 'The second-largest moon of Saturn.', false, 6, -174, -174),
('Iapetus', 6, 'A moon of Saturn with a two-tone coloration.', false, 7, -143, -143),
('Phoebe', 6, 'An irregular satellite of Saturn with a retrograde orbit.', false, 8, -198, -198),
('Hyperion', 6, 'A moon of Saturn with a chaotic rotation.', false, 9, -180, -180),
('Ariel', 6, 'One of the larger moons of Uranus.', false, 10, -213, -213),
('Umbriel', 6, 'A dark moon of Uranus.', false, 11, -214, -214),
('Titania', 6, 'The largest moon of Uranus.', false, 12, -209, -209),
('Oberon', 6, 'The second-largest moon of Uranus.', false, 13, -208, -208),
('Miranda', 6, 'A moon of Uranus with a heavily cratered surface.', false, 14, -187, -187),
('Triton', 6, 'The largest moon of Neptune, with geysers of nitrogen.', false, 15, -235, -210),
('Nereid', 6, 'A distant moon of Neptune with a highly elliptical orbit.', false, 16, -235, -210),
('Charon', 6, 'The largest moon of Pluto.', false, 17, -258, -223),
('Nix', 6, 'A small moon of Pluto.', false, 18, -258, -223);

/*
                                                Table "public.local_cluster"
+------------------+-----------------------+-----------+----------+---------------------------------------------------------+
|      Column      |         Type          | Collation | Nullable |                         Default                         |
+------------------+-----------------------+-----------+----------+---------------------------------------------------------+
| local_cluster_id | integer               |           | not null | nextval('local_cluster_local_cluster_id_seq'::regclass) |
| name             | character varying(50) |           |          |                                                         |
| description      | text                  |           |          |                                                         |
| cluster_type     | character varying(50) |           |          |                                                         |
| has_humans       | boolean               |           |          |                                                         |
+------------------+-----------------------+-----------+----------+---------------------------------------------------------+
Indexes:
    "local_cluster_pkey" PRIMARY KEY, btree (local_cluster_id)
	
*/

INSERT INTO local_cluster (name, description, cluster_type, has_humans) VALUES
('Local Group', 'The galaxy group that includes the Milky Way, Andromeda, and Triangulum galaxies.', 'Galaxy Group', true),
('Virgo Cluster', 'The closest large galaxy cluster to the Local Group, containing thousands of galaxies.', 'Galaxy Cluster', false),
('Coma Cluster', 'A large galaxy cluster containing over 1,000 identified galaxies.', 'Galaxy Cluster', false),
('Fornax Cluster', 'A nearby galaxy cluster located in the Fornax constellation.', 'Galaxy Cluster', false),
('Perseus Cluster', 'A massive galaxy cluster located in the Perseus constellation.', 'Galaxy Cluster', false),
('Centaurus Cluster', 'A rich cluster of galaxies located in the Centaurus constellation.', 'Galaxy Cluster', false);