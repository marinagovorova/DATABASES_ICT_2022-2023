INSERT INTO "trains_sheme"."ticket"("passenger_id", "destination", "depature_point", "seat_number", "status", "price", "in_checkout_or_not", "checkout_number")
SELECT 1, "stop_number", 1, 8, 'paid', 2000, 'yes', 1
FROM "trains_sheme"."stop"
WHERE "name" = 'MSC';

UPDATE "trains_sheme"."ticket"
SET "status" = 'changed', "destination" = (
    SELECT "stop_number"
    FROM "trains_sheme"."stop"
    WHERE "name" = 'SPB'
)
WHERE "ticket_id" = (
    SELECT MIN("ticket_id")
    FROM "trains_sheme"."ticket"
    WHERE "status" = 'paid' AND "destination" = (
        SELECT "stop_number"
        FROM "trains_sheme"."stop"
        WHERE "name" = 'MSC'
    )
);


INSERT INTO "trains_sheme"."checkout"("checkout_number", "locality", "address")
VALUES (9, 'City1', 'Address1');

DELETE FROM "trains_sheme"."checkout"
WHERE "checkout_number" = (
    SELECT MAX("checkout_number")
    FROM "trains_sheme"."checkout"
    WHERE "locality" = 'City1'
);

