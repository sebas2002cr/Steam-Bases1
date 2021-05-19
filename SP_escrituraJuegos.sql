


-- -------------------------------------------------------
-- STORE PROCEDURE, INSERTAR JUEGOS
-- -------------------------------------------------------

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
IN Checksum varbinary(300),
IN IpAddress varbinary(32),
IN Username varchar(64),
IN IdPlatform int
)
BEGIN
INSERT INTO Games (`name`, `description`,iconURL, URL,enabled, ESRB_ClasificationId, idGenderType )
VALUES(Game_name,Descriptiom,IconUrl,Url, ESRB, IdGenderType ); 
INSERT INTO GameSaleInfo(Gameid,publisherId,retailPrice,currencySymbol,discount,publisher_percentage,isCurrentRunning,posttime,checksum,ipAddress,username)
VALUES(IdGame,Idpublisher, Price, Currency, Discount, PuPercentage, Running, Posttime, Checksum, IpAddress , Username);
INSERT INTO Game_Platforms (Gameid, idPlatformType) 
VALUES(IdGame, IdPlatform);

END//


DELIMITER ;
