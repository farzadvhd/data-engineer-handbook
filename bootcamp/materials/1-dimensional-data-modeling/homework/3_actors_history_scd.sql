CREATE TABLE actors_history_scd (
    actorid TEXT,
    actor TEXT,
    films film_stats[],
    quality_class quality_class,
    is_active bool,
    start_date INTEGER,
    end_date INTEGER,
    PRIMARY KEY (actorid, start_date)
);
