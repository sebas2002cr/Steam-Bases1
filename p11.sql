-- ------------------------------------
-- 11. etorna un listado de los montos y personas,
-- categorizados por annio y mes de aquellos dineros que no se han podido cobrar
-- ------------------------------------

SELECT YEAR(pa.posttime) AS 'Year', MONTH(pa.posttime) AS `Month`, CONCAT(u.`name`,' ',u.lastname) AS `user`,
pa.currencySymbol, pa.amount, m.`name` AS merchant, ps.`name` AS `status` FROM PaymentsAttempts pa
INNER JOIN Users u ON pa.Userid = u.Userid
INNER JOIN Merchants m ON pa.merchantId = m.merchantId
INNER JOIN PaymentStatus ps ON pa.idPaymentStatus = ps.idPaymentStatus
WHERE pa.idPaymentStatus IN (2, 3, 4, 5) 
ORDER BY pa.posttime DESC;
-- pending, canceled, denied, failed
