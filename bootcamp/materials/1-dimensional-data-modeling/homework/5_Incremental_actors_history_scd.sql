INSERT INTO actors_history_scd
SELECT
    a.actorid,
    a.actor,
    a.films,
    a.quality_class,
    a.is_active,
    (SELECT MAX(end_date) FROM actors_history_scd WHERE actorid = a.actorid) + 1 AS start_date,
    NULL AS end_date
FROM actors a
WHERE NOT EXISTS (
    SELECT 1
    FROM actors_history_scd scd
    WHERE scd.actorid = a.actorid AND scd.end_date IS NULL
);
