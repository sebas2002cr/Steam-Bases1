

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
SELECT @pThePaymentAttempt :=   MAX(paymentAttemptId) FROM PaymentsAttempts ;    -- Aqui, hay que fijarse cual sera el id del nuevo ...
SELECT @pThePurchaseOrder := MAX(idPurchaseOrder) FROM PurchaseOrder  ; 
SELECT pPriceDefault =  retailPrice FROM GameSaleInfo WHERE Gameid=IdGame; -- Obtiene el precio normal
SELECT pDiscount = discount FROM GameSaleInfo WHERE Gameid=IdGame;		-- Obtiene el descuento activo
SET pPrice = @pPriceDefault * (1-@pDiscount);

select * from GameSaleInfo;

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


SELECT * FROM PaymentsAttempts;

