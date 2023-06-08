WITH trains_next_24h AS (
    SELECT t.train_number
    FROM "trains_sheme"."train" t
    JOIN "trains_sheme"."shedule" s ON t.route_number = s.route_number
    WHERE t.depature_date >= CURRENT_DATE
        AND t.depature_date < CURRENT_DATE + INTERVAL '1 day'
        AND s.depature_point = (SELECT stop_number FROM "trains_sheme"."stop" WHERE name = 'SPB')
)

SELECT 
    t.train_number, 
    c.carriage_number, 
    s.seat_number, 
    s.seat_number_carriage
FROM "trains_sheme"."seat" s
JOIN "trains_sheme"."carriage" c ON s.carriage_number = c.carriage_number
JOIN trains_next_24h t ON c.train_number = t.train_number
WHERE s.status = 'free'
ORDER BY t.train_number, c.carriage_number, s.seat_number;


WITH moscow_trains AS (
    SELECT t.train_number
    FROM "trains_sheme"."train" t
    JOIN "trains_sheme"."shedule" s ON t.route_number = s.route_number
    WHERE t.depature_date >= CURRENT_DATE - INTERVAL '1 day'
        AND t.depature_date < CURRENT_DATE
        AND s.destination = (SELECT stop_number FROM "trains_sheme"."stop" WHERE name = 'Москва')
)

SELECT DISTINCT
    p.passenger_id,
    p.surname,
    p.name,
    p.middle_name
FROM "trains_sheme"."ticket" tk
JOIN "trains_sheme"."passenger" p ON tk.passenger_id = p.passenger_id
JOIN moscow_trains t ON tk.destination = (SELECT stop_number FROM "trains_sheme"."stop" WHERE name = 'MSC')
WHERE tk.status = 'paid'
ORDER BY p.surname, p.name, p.middle_name;


WITH trains_next_24h AS (
    SELECT t.train_number, COUNT(s.seat_number) AS total_seats
    FROM "trains_sheme"."train" t
    JOIN "trains_sheme"."carriage" c ON t.train_number = c.train_number
    JOIN "trains_sheme"."seat" s ON c.carriage_number = s.carriage_number
    WHERE t.depature_date >= CURRENT_DATE
        AND t.depature_date < CURRENT_DATE + INTERVAL '1 day'
    GROUP BY t.train_number
),
sold_tickets AS (
    SELECT t.train_number, COUNT(tk.ticket_id) AS sold_tickets_count
    FROM "trains_sheme"."ticket" tk
    JOIN "trains_sheme"."train" t ON tk.depature_point = (SELECT stop_number FROM "trains_sheme"."stop" WHERE name = 'SPB')
    WHERE t.depature_date >= CURRENT_DATE
        AND t.depature_date < CURRENT_DATE + INTERVAL '1 day'
        AND tk.status = 'paid'
    GROUP BY t.train_number
)

SELECT t.train_number
FROM trains_next_24h t
JOIN sold_tickets st ON t.train_number = st.train_number
WHERE t.total_seats = st.sold_tickets_count
ORDER BY t.train_number;


WITH moscow_trains_today AS (
    SELECT t.train_number
    FROM "trains_sheme"."train" t
    JOIN "trains_sheme"."shedule" s ON t.route_number = s.route_number
    WHERE t.depature_date = CURRENT_DATE
        AND s.destination = (SELECT stop_number FROM "trains_sheme"."stop" WHERE name = 'MSC')
)

SELECT 
    t.train_number, 
    c.carriage_number, 
    s.seat_number, 
    s.seat_number_carriage
FROM "trains_sheme"."seat" s
JOIN "trains_sheme"."carriage" c ON s.carriage_number = c.carriage_number
JOIN moscow_trains_today t ON c.train_number = t.train_number
WHERE s.status = 'free' AND c.type = 'coupe'
ORDER BY t.train_number, c.carriage_number, s.seat_number;


SELECT SUM(t.price) as total_revenue
FROM "trains_sheme"."ticket" t
JOIN "trains_sheme"."shedule" s ON t."depature_point" = s."depature_point"
JOIN "trains_sheme"."train" tr ON tr."route_number" = s."route_number"
WHERE t."status" = 'paid'
AND tr."depature_date" + s."depature_time" >= NOW() - INTERVAL '1 day'
AND tr."depature_date" + s."depature_time" < NOW();

	
SELECT COUNT(tk.ticket_id) AS total_sv_tickets_sold
FROM "trains_sheme"."ticket" tk
JOIN "trains_sheme"."seat" s ON tk.seat_number = s.seat_number
JOIN "trains_sheme"."carriage" c ON s.carriage_number = c.carriage_number
WHERE c.type = 'SV' AND tk.status = 'paid';


WITH trains_past_24h AS (
    SELECT t.train_number, t.train_name
    FROM "trains_sheme"."train" t
    WHERE t.depature_date >= CURRENT_DATE - INTERVAL '1 day'
        AND t.depature_date < CURRENT_DATE
),
carriage_capacity AS (
    SELECT 
        c.train_number, 
        c.carriage_number,
        COUNT(s.seat_number) AS total_seats
    FROM "trains_sheme"."carriage" c
    JOIN "trains_sheme"."seat" s ON c.carriage_number = s.carriage_number
    GROUP BY c.train_number, c.carriage_number
),
carriage_sold_tickets AS (
    SELECT
        t.train_number,
        c.carriage_number,
        COUNT(tk.ticket_id) AS sold_tickets_count
    FROM "trains_sheme"."ticket" tk
    JOIN "trains_sheme"."seat" s ON tk.seat_number = s.seat_number
    JOIN "trains_sheme"."carriage" c ON s.carriage_number = c.carriage_number
    JOIN trains_past_24h t ON c.train_number = t.train_number
    WHERE tk.status = 'paid'
    GROUP BY t.train_number, c.carriage_number
),
carriage_stats AS (
    SELECT
        cc.train_number,
        cc.carriage_number,
        cc.total_seats,
        COALESCE(cst.sold_tickets_count, 0) AS sold_tickets_count
    FROM carriage_capacity cc
    LEFT JOIN carriage_sold_tickets cst ON cc.train_number = cst.train_number AND cc.carriage_number = cst.carriage_number
)

SELECT 
    tp.train_number,
    tp.train_name
FROM trains_past_24h tp
WHERE NOT EXISTS (
    SELECT 1
    FROM carriage_stats cs
    WHERE cs.train_number = tp.train_number AND cs.sold_tickets_count >= (cs.total_seats / 2)
)
ORDER BY tp.train_number;



