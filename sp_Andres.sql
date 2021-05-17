-- ----------------------
-- Srcipt #4 - Andrés
-- Sp de Lectura
-- Sp de Escritura
-- ----------------------

-- ----------------------
-- Lectura 1: 
-- SP que muestre los datos de venta de los juegos que ofrece un publisher
-- ----------------------

DROP PROCEDURE IF EXISTS viewPublisherContracts;

DELIMITER $$
CREATE PROCEDURE viewPublisherContracts(pCompany_name NVARCHAR(256))
BEGIN
	SELECT * FROM view_GameSalesPublisher WHERE company_name = pCompany_name;
END $$
DELIMITER ;

CALL viewPublisherContracts('Rockstar North');

-- ----------------------------------------------

-- ----------------------
-- Lectura 2: 
-- SP que muestre la informacion de los juegos comprados por el usuario
-- ----------------------

DROP PROCEDURE IF EXISTS viewPublisherContracts;

DELIMITER $$
CREATE PROCEDURE viewUserGames(pUsername NVARCHAR(256))
BEGIN
	SELECT * FROM view_userGames WHERE username = pUsername;
END $$
DELIMITER ;

CALL viewUserGames('Andres Arias');

-- ----------------------------------------------

-- ----------------------
-- Lectura 3:  
-- SP que enlista todos los purchase order hasta el momento
-- ----------------------
SELECT * FROM PurchaseOrder;

DROP PROCEDURE IF EXISTS viewAllPurchase;

DELIMITER $$
CREATE PROCEDURE viewAllPurchase()
BEGIN
	SELECT po.idPurchaseOrder AS `order`, po.amount, po.quantity, po.mail, po.`date`, -- podria ir a view
    ic.`name` AS article, po.idForOrder AS numArticle,
    u.`name` AS buyer, u1.`name` AS receiver FROM PurchaseOrder po
    INNER JOIN item_category ic ON po.item_category_Id = ic.item_category_Id
    INNER JOIN Users u ON po.buyerId = u.userid
    INNER JOIN Users u1 ON po.itemForId = u1.userid;
END $$
DELIMITER ;

-- SELECT u.`name` AS buyer, u1.`name` AS receiver FROM PurchaseOrder po INNER JOIN Users u ON po.buyerId  = u.userid INNER JOIN Users u1 ON po.itemForId = u1.userid;

-- ----------------------
-- Lectura 4:  
-- SP que enlista los payments attempts listados por fecha descendente (mas reciente hacia atras)
-- ----------------------

SELECT * FROM PaymentsAttempts;

DROP PROCEDURE IF EXISTS listPaymentsAttempts():

DELIMITER $$
-- BEGIN
	SELECT pa.paymentAttemptId, pa.posttime, pa.referenceNumber, pa.currencySymbol, pa.amount, -- podria ir a view
    m.`name` AS merchant, ps.`name` AS `status`, ic.`name` AS category, pa.idToPay AS articleId, pa.userid FROM PaymentsAttempts pa
    INNER JOIN Merchants m ON pa.merchantId = m.merchantId
    INNER JOIN PaymentStatus ps ON pa.idPaymentStatus = ps.idPaymentStatus
    INNER JOIN item_category ic ON pa.item_category_Id = ic.item_category_Id
    ORDER BY posttime DESC;
-- END$$
DELIMITER ;

