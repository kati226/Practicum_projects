
-- Задача 1: Время активности объявлений
-- Определим аномальные значения (выбросы) по значению перцентилей:
-- Задача 1: Время активности объявлений
-- Определим аномальные значения (выбросы) по значению перцентилей:
WITH limits AS (
    SELECT
        PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY total_area) AS total_area_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY rooms) AS rooms_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY balcony) AS balcony_limit,
        PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_h,
        PERCENTILE_CONT(0.01) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_l
    FROM real_estate.flats
),
-- Найдём id объявлений, которые не содержат выбросы, также оставим пропущенные данные:
filtered_id AS(
    SELECT id
    FROM real_estate.flats
    WHERE
        total_area < (SELECT total_area_limit FROM limits)
        AND (rooms < (SELECT rooms_limit FROM limits) OR rooms IS NULL)
        AND (balcony < (SELECT balcony_limit FROM limits) OR balcony IS NULL)
        AND ((ceiling_height < (SELECT ceiling_height_limit_h FROM limits)
            AND ceiling_height > (SELECT ceiling_height_limit_l FROM limits)) OR ceiling_height IS NULL)
    ),
    main AS (
    SELECT
        a.id,
        c.city,
        a.days_exposition,
        a.first_day_exposition,
        fl.total_area,
        fl.rooms,
        fl.balcony,
        a.last_price / NULLIF(fl.total_area, 0) AS price_per_m2,
        fl.floor
    FROM filtered_id as fi
    JOIN real_estate.advertisement as a USING (id)
    JOIN real_estate.flats as fl USING (id)
    JOIN real_estate.city as c ON fl.city_id = c.city_id   
    WHERE a.first_day_exposition BETWEEN DATE '2014-12-31' AND DATE '2019-01-01'
    and type_id = 'F8EM'
),
categorized AS (
    SELECT
        *,
        CASE
            WHEN days_exposition BETWEEN 1 AND 30  THEN '1-30 days'
            WHEN days_exposition BETWEEN 31 AND 90 THEN '31-90 days'
            WHEN days_exposition BETWEEN 91 AND 180 THEN '91-180 days'
            WHEN days_exposition > 180 THEN '181+ days'
            ELSE 'non category'
        END AS period,
        CASE 
            WHEN TRIM(city) = 'Санкт-Петербург' THEN 'SPB'
            ELSE 'LO'
        END AS region
    FROM main
)
SELECT
    period,
    region,
    COUNT(id) AS flats_count,
    AVG(price_per_m2) AS avg_price_per_m2,
    AVG(total_area) AS avg_total_area,
    AVG(rooms) AS avg_rooms,
    AVG(balcony) AS avg_balconies,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY rooms) AS median_rooms,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY floor) AS median_floor,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY balcony) AS median_balcony
FROM categorized
GROUP BY period, region
ORDER BY region, CASE period
        WHEN '1-30 days' THEN 2
        WHEN '31-90 days' THEN 3
        WHEN '91-180 days' THEN 4
        WHEN '181+ days'  THEN 5
        ELSE 1
    END;



-- Задача 2: Сезонность объявлений
-- Определим аномальные значения (выбросы) по значению перцентилей:
-- 1. Рассчитаем границы выбросов по 99 и 1 перцентилям
-- 1. Рассчитаем границы выбросов по 99 и 1 перцентилям
WITH limits AS (
    SELECT
        PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY total_area) AS total_area_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY rooms) AS rooms_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY balcony) AS balcony_limit,
        PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_h,
        PERCENTILE_CONT(0.01) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_l
    FROM real_estate.flats
),
-- 2. Отфильтруем объявления, убрав выбросы (при этом оставляем NULL-значения)
filtered_id AS (
    SELECT *, f.id as flat_id, a.id as a_id
    FROM real_estate.flats f
    LEFT JOIN real_estate.advertisement AS a ON a.id = f.id
    WHERE
        total_area < (SELECT total_area_limit FROM limits)
        AND (rooms < (SELECT rooms_limit FROM limits) OR rooms IS NULL)
        AND (balcony < (SELECT balcony_limit FROM limits) OR balcony IS NULL)
        AND (
            (ceiling_height < (SELECT ceiling_height_limit_h FROM limits)
             AND ceiling_height > (SELECT ceiling_height_limit_l FROM limits))
            OR ceiling_height IS NULL
        )
),
-- 3. Рассчитаем месяцы публикации и снятия (оставим только 2015–2018), а также стоимость 1 метра
flats_dates AS (
    SELECT
        f.a_id, -- Номер объявления
        f.last_price::real / f.total_area AS meter_cost, -- Стоимость одного метра
        f.total_area, -- Площадь недвижимости
        EXTRACT(MONTH FROM f.first_day_exposition::date) AS start_month, -- Месяц публикации
        EXTRACT(MONTH FROM (f.first_day_exposition::date + INTERVAL'1 day' * f.days_exposition)) AS close_motnh -- Месяц снятия
    FROM filtered_id AS f
    WHERE
        type_id = 'F8EM'
        -- Оставляем публикации за 2015 - 2018 годы
        AND EXTRACT(YEAR FROM f.first_day_exposition) BETWEEN 2015 AND 2018
),
-- 4. Статистика по месяцам публикации объявления
pub_stats AS (
    SELECT
        start_month::int AS ad_month,
        COUNT(a_id) AS cnt_pub,
        (COUNT(a_id)::real / SUM(COUNT(a_id)) OVER() * 100)::numeric(4,2) AS cnt_pub_share,
        AVG(meter_cost)::NUMERIC(8,2) AS avg_meter_pub,
        AVG(total_area)::NUMERIC(5,2) AS avg_area_pub
    FROM flats_dates
    GROUP BY ad_month
),
-- 5. Статистика по месяцам снятия объявления
end_stats AS (
    SELECT
        close_motnh::int AS ad_month,
        COUNT(a_id) AS cnt_end,
        (COUNT(a_id)::real / SUM(COUNT(a_id)) OVER() * 100)::numeric(4,2) AS cnt_end_share,
        AVG(meter_cost)::NUMERIC(8,2) AS avg_meter_end,
        AVG(total_area)::NUMERIC(5,2) AS avg_area_end
    FROM flats_dates
    -- Фильтруем объявления без даты снятия - то есть активные
    WHERE close_motnh IS NOT NULL
    GROUP BY ad_month
)
-- 6. Объдиняем данны двух СТЕ
SELECT *
FROM pub_stats JOIN end_stats USING(ad_month)
order by ad_month;
