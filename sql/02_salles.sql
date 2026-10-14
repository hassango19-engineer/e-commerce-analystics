
--TRUNCATE TABLE payments, orders, products CASCADE;
--SELECT COUNT(*) FROM products;
--SELECT * FROM products ORDER BY product_id;SELECT
--KPI1:
  SELECT   SUM( o.quantity * p.price ) AS total_revenue

FROM orders o

JOIN products p
ON o.product_id = p.product_id;
--KPI2

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;
--KPI3
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM orders;
--KPI4
SELECT
    SUM(quantity) AS total_quantity
FROM orders;
--KPI5
SELECT
    ROUND(
        SUM(o.quantity * p.price)
        /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_basket

FROM orders o

JOIN products p
ON o.product_id = p.product_id;
--Calcul de CA 
SELECT
    p.category,
    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;


SELECT
    customer_id,
    name,
    age,

    CASE

        WHEN age <= 25
            THEN '18-25'

        WHEN age <= 35
            THEN '26-35'

        WHEN age <= 45
            THEN '36-45'

        WHEN age <= 60
            THEN '46-60'

        ELSE '60+'

    END AS age_group

FROM customers;
-- ============================================================
-- PROJET E-COMMERCE DATA ANALYSIS
-- SEANCE 2 : ANALYSE SQL DES VENTES
-- Base : ecommerce_db
-- Tables :
--   customers
--   products
--   orders
--   payments
-- ============================================================



-- ============================================================
-- 1. VERIFICATION DES TABLES
-- ============================================================

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_products
FROM products;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_payments
FROM payments;



-- ============================================================
-- 2. AFFICHER QUELQUES DONNEES
-- ============================================================

SELECT *
FROM customers
LIMIT 10;

SELECT *
FROM products
LIMIT 10;

SELECT *
FROM orders
LIMIT 10;

SELECT *
FROM payments
LIMIT 10;



-- ============================================================
-- 3. PREMIER JOIN : COMMANDES + CLIENTS
-- ============================================================

SELECT
    o.order_id,
    o.order_date,
    o.quantity,
    c.customer_id,
    c.name,
    c.age,
    c.city
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
LIMIT 10;



-- ============================================================
-- 4. COMMANDES + CLIENTS + PRODUITS
-- ============================================================

SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    c.name,
    c.city,
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    o.quantity
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
LIMIT 10;



-- ============================================================
-- 5. JOIN DES 4 TABLES
-- ============================================================

SELECT
    o.order_id,
    o.order_date,

    c.customer_id,
    c.name,
    c.age,
    c.city,

    p.product_id,
    p.product_name,
    p.category,
    p.price,

    o.quantity,

    pay.payment_method,
    pay.payment_status

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

JOIN payments pay
    ON o.order_id = pay.order_id

LIMIT 20;



-- ============================================================
-- 6. CALCUL DU CHIFFRE D'AFFAIRES PAR COMMANDE
-- revenue = quantity * price
-- ============================================================

SELECT
    o.order_id,
    p.product_name,
    o.quantity,
    p.price,

    ROUND(
        o.quantity * p.price,
        2
    ) AS revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

LIMIT 20;



-- ============================================================
-- 7. TABLE LOGIQUE SALES COMPLETE
-- ============================================================

SELECT
    o.order_id,
    o.order_date,

    c.customer_id,
    c.name,
    c.age,
    c.city,

    p.product_id,
    p.product_name,
    p.category,
    p.price,

    o.quantity,

    pay.payment_method,
    pay.payment_status,

    ROUND(
        o.quantity * p.price,
        2
    ) AS revenue

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

JOIN payments pay
    ON o.order_id = pay.order_id

ORDER BY o.order_id;



-- ============================================================
-- 8. KPI : CHIFFRE D'AFFAIRES TOTAL
-- ============================================================

SELECT
    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS total_revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id;



-- ============================================================
-- 9. KPI : NOMBRE TOTAL DE COMMANDES
-- ============================================================

SELECT
    COUNT(
        DISTINCT order_id
    ) AS total_orders

FROM orders;



-- ============================================================
-- 10. KPI : NOMBRE DE CLIENTS AYANT COMMANDE
-- ============================================================

SELECT
    COUNT(
        DISTINCT customer_id
    ) AS total_customers

FROM orders;



-- ============================================================
-- 11. KPI : QUANTITE TOTALE VENDUE
-- ============================================================

SELECT
    SUM(quantity) AS total_quantity

FROM orders;



-- ============================================================
-- 12. KPI : PANIER MOYEN
-- ============================================================

SELECT
    ROUND(
        SUM(o.quantity * p.price)
        /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_basket

FROM orders o

JOIN products p
    ON o.product_id = p.product_id;



-- ============================================================
-- 13. TOUS LES KPI DANS UNE SEULE REQUETE
-- ============================================================

SELECT

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS total_revenue,

    COUNT(
        DISTINCT o.order_id
    ) AS total_orders,

    COUNT(
        DISTINCT o.customer_id
    ) AS total_customers,

    SUM(
        o.quantity
    ) AS total_quantity,

    ROUND(
        SUM(o.quantity * p.price)
        /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_basket

FROM orders o

JOIN products p
    ON o.product_id = p.product_id;



-- ============================================================
-- 14. CHIFFRE D'AFFAIRES PAR CATEGORIE
-- ============================================================

SELECT
    p.category,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.category

ORDER BY revenue DESC;



-- ============================================================
-- 15. CHIFFRE D'AFFAIRES PAR VILLE
-- ============================================================

SELECT
    c.city,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

GROUP BY c.city

ORDER BY revenue DESC;



-- ============================================================
-- 16. TOP 10 PRODUITS LES PLUS VENDUS
-- ============================================================

SELECT
    p.product_name,

    SUM(
        o.quantity
    ) AS quantity_sold

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.product_name

ORDER BY quantity_sold DESC

LIMIT 10;



-- ============================================================
-- 17. TOP 10 PRODUITS PAR CHIFFRE D'AFFAIRES
-- ============================================================

SELECT
    p.product_name,

    SUM(
        o.quantity
    ) AS quantity_sold,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.product_name

ORDER BY revenue DESC

LIMIT 10;



-- ============================================================
-- 18. TOP 10 CLIENTS
-- ============================================================

SELECT
    c.customer_id,
    c.name,
    c.city,

    COUNT(
        DISTINCT o.order_id
    ) AS total_orders,

    SUM(
        o.quantity
    ) AS total_quantity,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

GROUP BY
    c.customer_id,
    c.name,
    c.city

ORDER BY revenue DESC

LIMIT 10;



-- ============================================================
-- 19. NOMBRE DE COMMANDES PAR VILLE
-- ============================================================

SELECT
    c.city,

    COUNT(
        DISTINCT o.order_id
    ) AS total_orders

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

GROUP BY c.city

ORDER BY total_orders DESC;



-- ============================================================
-- 20. MOYEN DE PAIEMENT LE PLUS UTILISE
-- ============================================================

SELECT
    payment_method,
    COUNT(*) AS total_payments

FROM payments

GROUP BY payment_method

ORDER BY total_payments DESC;



-- ============================================================
-- 21. CHIFFRE D'AFFAIRES PAR MOYEN DE PAIEMENT
-- ============================================================

SELECT
    pay.payment_method,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

JOIN payments pay
    ON o.order_id = pay.order_id

GROUP BY pay.payment_method

ORDER BY revenue DESC;



-- ============================================================
-- 22. ANALYSE DES STATUTS DE PAIEMENT
-- ============================================================

SELECT
    payment_status,
    COUNT(*) AS total_payments

FROM payments

GROUP BY payment_status

ORDER BY total_payments DESC;



-- ============================================================
-- 23. CASE WHEN : RESULTAT DU PAIEMENT
-- ============================================================

SELECT
    order_id,
    payment_status,

    CASE

        WHEN payment_status = 'Paid'
            THEN 'Successful'

        WHEN payment_status = 'Pending'
            THEN 'Waiting'

        WHEN payment_status = 'Failed'
            THEN 'Failed'

        ELSE 'Unknown'

    END AS payment_result

FROM payments

LIMIT 30;



-- ============================================================
-- 24. TAUX DE PAIEMENT REUSSI
-- ============================================================

SELECT

    ROUND(

        100.0 *

        SUM(
            CASE
                WHEN payment_status = 'Paid'
                    THEN 1
                ELSE 0
            END
        )

        /

        COUNT(*),

        2

    ) AS payment_success_rate

FROM payments;



-- ============================================================
-- 25. VALEUR DES TRANSACTIONS AVEC PAIEMENT ECHOUE
-- ============================================================

SELECT

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS failed_payment_value

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

JOIN payments pay
    ON o.order_id = pay.order_id

WHERE pay.payment_status = 'Failed';



-- ============================================================
-- 26. NOMBRE DE COMMANDES PAR MOIS
-- ============================================================

SELECT

    DATE_TRUNC(
        'month',
        order_date
    ) AS month,

    COUNT(
        DISTINCT order_id
    ) AS total_orders

FROM orders

GROUP BY month

ORDER BY month;



-- ============================================================
-- 27. CHIFFRE D'AFFAIRES PAR MOIS
-- ============================================================

SELECT

    DATE_TRUNC(
        'month',
        o.order_date
    ) AS month,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY month

ORDER BY month;



-- ============================================================
-- 28. MEILLEUR MOIS EN CHIFFRE D'AFFAIRES
-- ============================================================

SELECT

    DATE_TRUNC(
        'month',
        o.order_date
    ) AS month,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY month

ORDER BY revenue DESC

LIMIT 1;



-- ============================================================
-- 29. NOMBRE DE COMMANDES PAR JOUR DE LA SEMAINE
-- ============================================================

SELECT

    TRIM(
        TO_CHAR(
            order_date,
            'Day'
        )
    ) AS day_name,

    COUNT(*) AS total_orders

FROM orders

GROUP BY day_name

ORDER BY total_orders DESC;



-- ============================================================
-- 30. CHIFFRE D'AFFAIRES PAR JOUR DE LA SEMAINE
-- ============================================================

SELECT

    TRIM(
        TO_CHAR(
            o.order_date,
            'Day'
        )
    ) AS day_name,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY day_name

ORDER BY revenue DESC;



-- ============================================================
-- 31. HAVING
-- VILLES AVEC PLUS DE 15 COMMANDES
-- ============================================================

SELECT
    c.city,

    COUNT(
        DISTINCT o.order_id
    ) AS total_orders

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

GROUP BY c.city

HAVING COUNT(
    DISTINCT o.order_id
) > 15

ORDER BY total_orders DESC;



-- ============================================================
-- 32. CREATION DE TRANCHES D'AGE AVEC CASE WHEN
-- ============================================================

SELECT
    customer_id,
    name,
    age,

    CASE

        WHEN age BETWEEN 18 AND 25
            THEN '18-25'

        WHEN age BETWEEN 26 AND 35
            THEN '26-35'

        WHEN age BETWEEN 36 AND 45
            THEN '36-45'

        WHEN age BETWEEN 46 AND 60
            THEN '46-60'

        ELSE '60+'

    END AS age_group

FROM customers

ORDER BY age;



-- ============================================================
-- 33. CHIFFRE D'AFFAIRES PAR TRANCHE D'AGE
-- ============================================================

SELECT

    CASE

        WHEN c.age BETWEEN 18 AND 25
            THEN '18-25'

        WHEN c.age BETWEEN 26 AND 35
            THEN '26-35'

        WHEN c.age BETWEEN 36 AND 45
            THEN '36-45'

        WHEN c.age BETWEEN 46 AND 60
            THEN '46-60'

        ELSE '60+'

    END AS age_group,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

GROUP BY age_group

ORDER BY revenue DESC;



-- ============================================================
-- 34. CATEGORIE DU MONTANT DE LA COMMANDE
-- ============================================================

SELECT
    o.order_id,

    ROUND(
        o.quantity * p.price,
        2
    ) AS revenue,

    CASE

        WHEN o.quantity * p.price <= 100
            THEN 'Low'

        WHEN o.quantity * p.price <= 500
            THEN 'Medium'

        WHEN o.quantity * p.price <= 1000
            THEN 'High'

        ELSE 'Very High'

    END AS order_value_category

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

ORDER BY revenue DESC;



-- ============================================================
-- 35. NOMBRE DE COMMANDES PAR CATEGORIE DE MONTANT
-- ============================================================

SELECT

    CASE

        WHEN o.quantity * p.price <= 100
            THEN 'Low'

        WHEN o.quantity * p.price <= 500
            THEN 'Medium'

        WHEN o.quantity * p.price <= 1000
            THEN 'High'

        ELSE 'Very High'

    END AS order_value_category,

    COUNT(*) AS total_orders

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY order_value_category

ORDER BY total_orders DESC;



-- ============================================================
-- 36. ANALYSE VILLE + CATEGORIE
-- ============================================================

SELECT
    c.city,
    p.category,

    COUNT(
        DISTINCT o.order_id
    ) AS total_orders,

    SUM(
        o.quantity
    ) AS quantity_sold,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

GROUP BY
    c.city,
    p.category

ORDER BY revenue DESC;



-- ============================================================
-- 37. PRODUIT QUI RAPPORTE LE PLUS
-- ============================================================

SELECT
    p.product_name,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.product_name

ORDER BY revenue DESC

LIMIT 1;



-- ============================================================
-- 38. PRODUIT LE PLUS VENDU EN QUANTITE
-- ============================================================

SELECT
    p.product_name,

    SUM(
        o.quantity
    ) AS quantity_sold

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.product_name

ORDER BY quantity_sold DESC

LIMIT 1;



-- ============================================================
-- 39. CLIENT QUI DEPENSE LE PLUS
-- ============================================================

SELECT
    c.customer_id,
    c.name,
    c.city,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS total_spent

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

GROUP BY
    c.customer_id,
    c.name,
    c.city

ORDER BY total_spent DESC

LIMIT 1;



-- ============================================================
-- 40. VILLE QUI RAPPORTE LE PLUS
-- ============================================================

SELECT
    c.city,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

GROUP BY c.city

ORDER BY revenue DESC

LIMIT 1;



-- ============================================================
-- 41. CATEGORIE QUI RAPPORTE LE PLUS
-- ============================================================

SELECT
    p.category,

    ROUND(
        SUM(o.quantity * p.price),
        2
    ) AS revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.category

ORDER BY revenue DESC

LIMIT 1;



-- ============================================================
-- 42. MOYEN DE PAIEMENT LE PLUS UTILISE
-- ============================================================

SELECT
    payment_method,
    COUNT(*) AS total_usage

FROM payments

GROUP BY payment_method

ORDER BY total_usage DESC

LIMIT 1;



-- ============================================================
-- 43. MOIS AVEC LE PLUS DE COMMANDES
-- ============================================================

SELECT

    DATE_TRUNC(
        'month',
        order_date
    ) AS month,

    COUNT(*) AS total_orders

FROM orders

GROUP BY month

ORDER BY total_orders DESC

LIMIT 1;



-- ============================================================
-- FIN DE LA SEANCE 2 SQL
-- ============================================================
















