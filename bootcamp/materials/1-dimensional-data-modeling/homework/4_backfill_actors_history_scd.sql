INSERT INTO actors_history_scd
SELECT
    actorid,
    actor,
    array_agg(ROW(
        film,
        votes,
        rating,
        filmid
    ):: film_stats) AS films,
    CASE
        WHEN AVG(rating) > 8 THEN 'star'::quality_class
        WHEN AVG(rating) > 7 AND AVG(rating) <= 8 THEN 'good'::quality_class
        WHEN AVG(rating) > 6 AND AVG(rating) <= 7 THEN 'average'::quality_class
        ELSE 'bad'::quality_class
    END AS quality_class,
    CASE
        WHEN MAX(year) = (SELECT MAX(year) FROM actor_films) THEN TRUE
        ELSE FALSE
    END AS is_active,
    MIN(year) AS start_date,
    CASE
        WHEN MAX(year) = (SELECT MAX(year) FROM actor_films) THEN NULL
        ELSE (MIN(year) + 1)
    END AS end_date
FROM actor_films
GROUP BY actorid, actor, year;
