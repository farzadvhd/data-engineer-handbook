
CREATE TYPE film_stats AS (
	film TEXT,
	votes INTEGER,
	rating FLOAT,
	filmid TEXT
);

CREATE TYPE quality_class AS 
	ENUM('star','good','average','bad');

CREATE TABLE actors(
	actorid TEXT,
	actor TEXT,
	films film_stats[],
	quality_class quality_class,
	is_active bool,
	primary key (actorid)
);
