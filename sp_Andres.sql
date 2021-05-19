-- ----------------------
-- Srcipt #5 - Andres
-- Sp de Lectura
-- Sp de Escritura
-- ----------------------

-- ///////////////////////
-- LECTURA
-- \\\\\\\\\\\\\\\\\\\\\\

-- ----------------------
-- Lectura 1: 
-- SP que muestre los datos de venta de los juegos y condiciones del publisher
-- ordenados por el nombre del publisher
-- ----------------------

DROP PROCEDURE IF EXISTS sp_viewPublisherContracts;

DELIMITER $$
CREATE PROCEDURE sp_viewPublisherContracts()
BEGIN
	SELECT * FROM view_GameSalesPublisher ORDER BY company_name;
END $$
DELIMITER ;

CALL sp_viewPublisherContracts();

-- ----------------------------------------------

-- ----------------------
-- Lectura 2: 
-- SP que muestre la informacion de los juegos comprados por los usuarios
-- ordenado por nombre de user
-- ----------------------

DROP PROCEDURE IF EXISTS sp_viewUserGames;

DELIMITER $$
CREATE PROCEDURE sp_viewUserGames()
BEGIN
	SELECT * FROM view_userGames ORDER BY username;
END $$
DELIMITER ;

CALL sp_viewUserGames();

-- ----------------------------------------------

-- ----------------------
-- Lectura 3:  
-- SP que enlista todos los purchase order hasta el momento
-- ----------------------
SELECT * FROM PurchaseOrder;

DROP PROCEDURE IF EXISTS sp_viewAllPurchase;

DELIMITER $$
CREATE PROCEDURE sp_viewAllPurchase()
BEGIN
	SELECT po.idPurchaseOrder AS `order`, po.amount, po.quantity, po.mail, po.`date`, -- podria ir a view
    ic.`name` AS article, po.idForOrder AS numArticle,
    CONCAT(u.`name`,' ',u.lastname) AS buyer, CONCAT(u1.`name`,' ',u1.lastname) AS receiver FROM PurchaseOrder po
    INNER JOIN item_category ic ON po.item_category_Id = ic.item_category_Id
    INNER JOIN Users u ON po.buyerId = u.userid
    INNER JOIN Users u1 ON po.itemForId = u1.userid;
END $$
DELIMITER ;

CALL sp_viewAllPurchase;

-- ----------------------
-- Lectura 4:  
-- SP que enlista los payments attempts listados por fecha descendente (mas reciente hacia atras)
-- ----------------------

SELECT * FROM PaymentsAttempts;

DROP PROCEDURE IF EXISTS sp_listPaymentsAttempts():

DELIMITER $$
CREATE PROCEDURE sp_listPaymentsAttempts()
BEGIN
	SELECT pa.paymentAttemptId, pa.posttime, pa.referenceNumber, pa.currencySymbol, pa.amount, -- podria ir a view
    m.`name` AS merchant, ps.`name` AS `status`, ic.`name` AS category, pa.idToPay AS articleId, pa.userid FROM PaymentsAttempts pa
    INNER JOIN Merchants m ON pa.merchantId = m.merchantId
    INNER JOIN PaymentStatus ps ON pa.idPaymentStatus = ps.idPaymentStatus
    INNER JOIN item_category ic ON pa.item_category_Id = ic.item_category_Id
    ORDER BY posttime DESC;
END$$
DELIMITER ;

CALL sp_listPaymentsAttempts;
