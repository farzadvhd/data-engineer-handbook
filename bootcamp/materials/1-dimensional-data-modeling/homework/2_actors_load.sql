INSERT INTO actors
SELECT
    actorid AS actor_id,
    actor AS actor_name,
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
    END AS is_active
FROM actor_films
GROUP BY actorid, actor;
