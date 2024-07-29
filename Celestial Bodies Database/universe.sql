--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    galaxy_type character varying(30),
    number_of_stars bigint,
    local_cluster_id integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: local_cluster; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.local_cluster (
    local_cluster_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text NOT NULL,
    cluster_type character varying(50),
    has_humans boolean
);


ALTER TABLE public.local_cluster OWNER TO freecodecamp;

--
-- Name: local_cluster_local_cluster_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.local_cluster_local_cluster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.local_cluster_local_cluster_id_seq OWNER TO freecodecamp;

--
-- Name: local_cluster_local_cluster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.local_cluster_local_cluster_id_seq OWNED BY public.local_cluster.local_cluster_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(50) NOT NULL,
    planet_id integer,
    description text,
    has_landed boolean,
    moon_order integer,
    min_temp_degrees integer,
    max_temp_degrees integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(50) NOT NULL,
    star_id integer,
    planet_order integer,
    star_distance_in_au numeric(5,2),
    min_temp_degrees integer,
    max_temp_degrees integer,
    description text,
    has_landed boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(50) NOT NULL,
    galaxy_id integer,
    description text,
    star_type text,
    age bigint
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: local_cluster local_cluster_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.local_cluster ALTER COLUMN local_cluster_id SET DEFAULT nextval('public.local_cluster_local_cluster_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'The Milky Way is the galaxy that contains our Solar System. It is a barred spiral galaxy with several arms.', 'Barred Spiral', 100000000000, 1);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'The Andromeda Galaxy is the nearest spiral galaxy to the Milky Way and is on a collision course with it.', 'Spiral', 1000000000000, 1);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'The Triangulum Galaxy is a member of the Local Group and the third-largest galaxy in that group.', 'Spiral', 40000000000, 1);
INSERT INTO public.galaxy VALUES (4, 'Whirlpool', 'The Whirlpool Galaxy is a classic spiral galaxy with well-defined spiral arms, located in the constellation Canes Venatici.', 'Spiral', 100000000000, 1);
INSERT INTO public.galaxy VALUES (5, 'Sombrero', 'The Sombrero Galaxy is an unbarred spiral galaxy in the constellation Virgo, known for its bright nucleus and large central bulge.', 'Unbarred Spiral', 80000000000, 1);
INSERT INTO public.galaxy VALUES (6, 'Messier 87', 'Messier 87 is a giant elliptical galaxy in the Virgo Cluster, known for its large size and powerful radio emissions.', 'Elliptical', 1200000000000, 1);


--
-- Data for Name: local_cluster; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.local_cluster VALUES (1, 'Local Group', 'The galaxy group that includes the Milky Way, Andromeda, and Triangulum galaxies.', 'Galaxy Group', true);
INSERT INTO public.local_cluster VALUES (2, 'Virgo Cluster', 'The closest large galaxy cluster to the Local Group, containing thousands of galaxies.', 'Galaxy Cluster', false);
INSERT INTO public.local_cluster VALUES (3, 'Coma Cluster', 'A large galaxy cluster containing over 1,000 identified galaxies.', 'Galaxy Cluster', false);
INSERT INTO public.local_cluster VALUES (4, 'Fornax Cluster', 'A nearby galaxy cluster located in the Fornax constellation.', 'Galaxy Cluster', false);
INSERT INTO public.local_cluster VALUES (5, 'Perseus Cluster', 'A massive galaxy cluster located in the Perseus constellation.', 'Galaxy Cluster', false);
INSERT INTO public.local_cluster VALUES (6, 'Centaurus Cluster', 'A rich cluster of galaxies located in the Centaurus constellation.', 'Galaxy Cluster', false);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 3, 'The only natural satellite of Earth.', true, 1, -173, 127);
INSERT INTO public.moon VALUES (2, 'Phobos', 4, 'The larger and closer of the two natural satellites of Mars.', false, 1, -112, -4);
INSERT INTO public.moon VALUES (3, 'Deimos', 4, 'The smaller and farther of the two natural satellites of Mars.', false, 2, -112, -4);
INSERT INTO public.moon VALUES (4, 'Io', 5, 'The innermost of the four Galilean moons of Jupiter.', false, 1, -163, -143);
INSERT INTO public.moon VALUES (5, 'Europa', 5, 'The smallest of the four Galilean moons of Jupiter.', false, 2, -160, -160);
INSERT INTO public.moon VALUES (6, 'Ganymede', 5, 'The largest moon in the Solar System.', false, 3, -163, -113);
INSERT INTO public.moon VALUES (7, 'Callisto', 5, 'The second-largest moon of Jupiter.', false, 4, -139, -129);
INSERT INTO public.moon VALUES (8, 'Amalthea', 5, 'A small, irregularly shaped moon of Jupiter.', false, 5, -183, -143);
INSERT INTO public.moon VALUES (9, 'Himalia', 5, 'The largest irregular satellite of Jupiter.', false, 6, -183, -143);
INSERT INTO public.moon VALUES (10, 'Thebe', 5, 'An inner moon of Jupiter.', false, 7, -183, -143);
INSERT INTO public.moon VALUES (11, 'Adrastea', 5, 'A small moon orbiting within Jupiter’s ring system.', false, 8, -183, -143);
INSERT INTO public.moon VALUES (12, 'Metis', 5, 'The innermost moon of Jupiter.', false, 9, -183, -143);
INSERT INTO public.moon VALUES (13, 'Titan', 6, 'The largest moon of Saturn and the second-largest natural satellite in the Solar System.', false, 1, -179, -179);
INSERT INTO public.moon VALUES (14, 'Enceladus', 6, 'A small, icy moon of Saturn with cryovolcanoes.', false, 2, -201, -198);
INSERT INTO public.moon VALUES (15, 'Mimas', 6, 'A small moon of Saturn with a large crater.', false, 3, -209, -209);
INSERT INTO public.moon VALUES (16, 'Tethys', 6, 'A mid-sized moon of Saturn with a large rift valley.', false, 4, -187, -187);
INSERT INTO public.moon VALUES (17, 'Dione', 6, 'A mid-sized moon of Saturn with bright ice cliffs.', false, 5, -186, -186);
INSERT INTO public.moon VALUES (18, 'Rhea', 6, 'The second-largest moon of Saturn.', false, 6, -174, -174);
INSERT INTO public.moon VALUES (19, 'Iapetus', 6, 'A moon of Saturn with a two-tone coloration.', false, 7, -143, -143);
INSERT INTO public.moon VALUES (20, 'Phoebe', 6, 'An irregular satellite of Saturn with a retrograde orbit.', false, 8, -198, -198);
INSERT INTO public.moon VALUES (21, 'Hyperion', 6, 'A moon of Saturn with a chaotic rotation.', false, 9, -180, -180);
INSERT INTO public.moon VALUES (22, 'Ariel', 6, 'One of the larger moons of Uranus.', false, 10, -213, -213);
INSERT INTO public.moon VALUES (23, 'Umbriel', 6, 'A dark moon of Uranus.', false, 11, -214, -214);
INSERT INTO public.moon VALUES (24, 'Titania', 6, 'The largest moon of Uranus.', false, 12, -209, -209);
INSERT INTO public.moon VALUES (25, 'Oberon', 6, 'The second-largest moon of Uranus.', false, 13, -208, -208);
INSERT INTO public.moon VALUES (26, 'Miranda', 6, 'A moon of Uranus with a heavily cratered surface.', false, 14, -187, -187);
INSERT INTO public.moon VALUES (27, 'Triton', 6, 'The largest moon of Neptune, with geysers of nitrogen.', false, 15, -235, -210);
INSERT INTO public.moon VALUES (28, 'Nereid', 6, 'A distant moon of Neptune with a highly elliptical orbit.', false, 16, -235, -210);
INSERT INTO public.moon VALUES (29, 'Charon', 6, 'The largest moon of Pluto.', false, 17, -258, -223);
INSERT INTO public.moon VALUES (30, 'Nix', 6, 'A small moon of Pluto.', false, 18, -258, -223);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 1, 1, 0.39, -173, 427, 'The closest planet to the Sun and the smallest in the Solar System.', false);
INSERT INTO public.planet VALUES (2, 'Venus', 1, 2, 0.72, 462, 462, 'The second planet from the Sun, known for its thick, toxic atmosphere and extreme heat.', true);
INSERT INTO public.planet VALUES (3, 'Earth', 1, 3, 1.00, -88, 58, 'The third planet from the Sun and the only known planet to support life.', true);
INSERT INTO public.planet VALUES (4, 'Mars', 1, 4, 1.52, -125, 20, 'The fourth planet from the Sun, known for its red color and potential for past water.', true);
INSERT INTO public.planet VALUES (5, 'Jupiter', 1, 5, 5.20, -145, -108, 'The fifth planet from the Sun and the largest in the Solar System.', false);
INSERT INTO public.planet VALUES (6, 'Saturn', 1, 6, 9.58, -178, -178, 'The sixth planet from the Sun, known for its prominent ring system.', false);
INSERT INTO public.planet VALUES (7, 'Betelgeuse I', 2, 1, 0.84, -180, 430, 'A hypothetical planet in the vicinity of Betelgeuse.', false);
INSERT INTO public.planet VALUES (8, 'Betelgeuse II', 2, 2, 1.76, -160, 450, 'A second hypothetical planet orbiting Betelgeuse.', false);
INSERT INTO public.planet VALUES (9, 'Proxima b', 3, 1, 0.05, -39, 30, 'A planet in the habitable zone of Proxima Centauri, similar in size to Earth.', false);
INSERT INTO public.planet VALUES (10, 'Proxima c', 3, 2, 1.50, -150, -100, 'A super-Earth exoplanet orbiting Proxima Centauri.', false);
INSERT INTO public.planet VALUES (11, 'Proxima d', 3, 3, 0.03, -40, 25, 'A small planet very close to Proxima Centauri.', false);
INSERT INTO public.planet VALUES (12, 'Proxima e', 3, 4, 0.08, -50, 20, 'A hypothetical planet orbiting Proxima Centauri.', false);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 'The Sun is the star at the center of the Solar System.', 'G-type Main-Sequence', 4600000000);
INSERT INTO public.star VALUES (2, 'Betelgeuse', 1, 'Betelgeuse is a red supergiant star in the Milky Way.', 'Red Supergiant', 8000000);
INSERT INTO public.star VALUES (3, 'Proxima Centauri', 2, 'Proxima Centauri is the closest known star to the Sun, part of the Alpha Centauri star system.', 'Red Dwarf', 4500000000);
INSERT INTO public.star VALUES (4, 'Alpha Centauri A', 2, 'Alpha Centauri A is the primary star in the Alpha Centauri system, located in the constellation Centaurus.', 'G-type Main-Sequence', 5500000000);
INSERT INTO public.star VALUES (5, 'M33 X-7', 3, 'M33 X-7 is a binary star system containing a black hole in the Triangulum Galaxy.', 'Binary System', 240000000);
INSERT INTO public.star VALUES (6, 'WR 104', 3, 'WR 104 is a Wolf-Rayet star known for its spiral dust plume.', 'Wolf-Rayet', 8000000);
INSERT INTO public.star VALUES (7, 'Eta Carinae', 4, 'Eta Carinae is a highly luminous hypergiant star in the Whirlpool Galaxy.', 'Hypergiant', 3000000);
INSERT INTO public.star VALUES (8, 'NGC 5194-V1', 4, 'NGC 5194-V1 is a variable star in the Whirlpool Galaxy.', 'Variable Star', 10000000);
INSERT INTO public.star VALUES (9, 'NGC 4594-V1', 5, 'NGC 4594-V1 is a Cepheid variable star in the Sombrero Galaxy.', 'Cepheid Variable', 30000000);
INSERT INTO public.star VALUES (10, 'NGC 4594-RSG1', 5, 'NGC 4594-RSG1 is a red supergiant star in the Sombrero Galaxy.', 'Red Supergiant', 20000000);
INSERT INTO public.star VALUES (11, 'M87 Star', 6, 'A star in the giant elliptical galaxy M87.', 'Giant Star', 7000000000);
INSERT INTO public.star VALUES (12, 'M87-V1', 6, 'M87-V1 is a variable star in the elliptical galaxy M87.', 'Variable Star', 5000000000);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: local_cluster_local_cluster_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.local_cluster_local_cluster_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 30, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 12, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: local_cluster local_cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.local_cluster
    ADD CONSTRAINT local_cluster_pkey PRIMARY KEY (local_cluster_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: local_cluster unique_name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.local_cluster
    ADD CONSTRAINT unique_name UNIQUE (name);


--
-- Name: galaxy galaxy_local_cluster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_local_cluster_id_fkey FOREIGN KEY (local_cluster_id) REFERENCES public.local_cluster(local_cluster_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

