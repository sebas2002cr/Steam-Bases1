-- -------------------------------------------------------
-- STORE PROCEDURE, INSERTAR JUEGOS
-- -------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_InsertGames;

DELIMITER // 

CREATE PROCEDURE sp_InsertGames
(
IN Game_name VARCHAR(64),
IN Descriptiom VARCHAR(2048),
IN IconUrl VARCHAR(128),
IN Url VARCHAR(128),
IN ESRB tinyint,
IN IdGenderType int,
IN IdGame int,
IN Idpublisher int,
IN Price double(12,2),
IN Currency varchar(5),
IN Discount DOUBLE(3,2),
IN PuPercentage DOUBLE(3,2),
IN Running BIT(1),
IN Posttime datetime,
IN `Checksum` varbinary(300),
IN IpAddress varbinary(32),
IN Username varchar(64),
IN IdPlatform int
)
BEGIN
	SET autocommit = 0;
	START TRANSACTION;
    
		INSERT INTO Games (`name`, `description`,iconURL, URL,enabled, ESRB_ClasificationId, idGenderType )
		VALUES(Game_name,Descriptiom,IconUrl,Url, ESRB, IdGenderType ); 
		INSERT INTO GameSaleInfo(Gameid,publisherId,retailPrice,currencySymbol,discount,publisher_percentage,isCurrentRunning,posttime,checksum,ipAddress,username)
		VALUES(IdGame,Idpublisher, Price, Currency, Discount, PuPercentage, Running, Posttime, Checksum, IpAddress , Username);
		INSERT INTO Game_Platforms (Gameid, idPlatformType) 
		VALUES(IdGame, IdPlatform);

	COMMIT;

END//

DELIMITER ;

CALL sp_InsertGames();

-- ------------------------------------------------------------------------

-- -------------------------------------------------------
-- STORE PROCEDURE, Insercion de paymentAttempt (exitoso), 
-- purchaseOrder, Transaction. Game-User
-- -------------------------------------------------------

                                                        
SET @pIpAddress = '181.21.23.35';
SET @pUsername = 'User';
SET @pComputerName = 'Compu';
SET @pPosttime = current_time();
SET @pItem_Category = 1;
SET @pDescription = 'Game Purchase';
SELECT @pThePaymentAttempt :=   MAX(paymentAttemptId)+1 FROM PaymentsAttempts ;    -- Aqui, hay que fijarse cual sera el id del nuevo ...
SELECT @pThePurchaseOrder := MAX(idPurchaseOrder)+1 FROM PurchaseOrder  ; 
SELECT pPriceDefault =  retailPrice FROM GameSaleInfo WHERE Gameid=IdGame; -- Obtiene el precio normal
SELECT pDiscount = discount FROM GameSaleInfo WHERE Gameid=IdGame;		-- Obtiene el descuento activo
SET pPrice = @pPriceDefault * (1-@pDiscount);

SELECT * FROM PurchaseOrder;
DROP PROCEDURE IF EXISTS sp_Payments;

DELIMITER //


CREATE PROCEDURE sp_Payments
(
IN IdGame INT,
IN Descriptiom VARCHAR(2048),
IN IdUser int,
IN Mail VARCHAR(128),
IN Currency varchar(5),
IN Username varchar(64),
IN ReferenceNumber BIGINT,
IN ArticleTransNumber BIGINT
)

BEGIN
		
	SET AUTOCOMMIT = 0;
    
    START TRANSACTION;
    
			
		INSERT INTO PaymentsAttempts (posttime, amount, currencySymbol, referenceNumber,
		errorNumber, articleTransNumber, `description`, username, ipAddress, `checksum`,
		computerName, idToPay, merchantId, item_category_Id, idPaymentStatus, userid)
		VALUES
		(@pPosttime, @pPrice, Currency , ReferenceNumber,
		NULL, ArticleTransNumber, @pDescription, @pUsername, @pIpAddress,
		SHA2(CONCAT(CAST(@pPrice AS CHAR(12)),' ',Currency,' ',@pIpAddress),256),
		@pComputerName, IdGame, 1, @pItem_Category, 1, IdUser);


		INSERT INTO PurchaseOrder (amount, quantity, mail, `date`,
		item_category_Id, idForOrder, buyerId, itemForId)
		VALUES
		(@pPrice, 1, Mail, @pPosttime,
		@pItem_Category, IdGame , IdUser, IdUser);


		INSERT INTO Transactions (amount, posttime, `description`, transTypeId ,
		username, computerName, ipAddress, `checksum`,
		idPurchaseOrder, paymentAttemptId)
		VALUES
		(@pPrice, @pPosttime, @pDescription, 1, @pUsername, @pComputerName, @pIpAddress,
		SHA2(CONCAT(CAST(@pPrice AS CHAR(12)),' ',@pIpAddress,' ',@pUsername),256),
		@pThePurchaseOrder, @pThePaymentAttempt);
			
    COMMIT;

END//

DELIMITER ;


CALL sp_Payments();