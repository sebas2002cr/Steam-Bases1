-- -----------------------------------
-- Script #2 - Andres
-- 14/05/2021
-- Summary:
-- 15.A Cursor
-- 15.B Trigger
-- 15.C Substring
-- ------------------------------------

-- ------------------------------------
-- 15.A Cursor
-- Contexto: Recorre a todos los usuarios, e indica el
-- year de su nacimiento
-- ------------------------------------

DROP PROCEDURE IF EXISTS spCursor;

DELIMITER $$
CREATE PROCEDURE spCursor()
BEGIN
	DECLARE done INT DEFAULT FALSE;  	-- para el done
    DECLARE output TEXT DEFAULT '';		-- done es una bandera para saber si ya el cursor llego al final
	DECLARE theUserId BIGINT;
    DECLARE theName NVARCHAR(64);
    DECLARE theBirthdate DATE;
    
	DECLARE curPrue CURSOR FOR							-- declaro el cursor dentro del sp
    SELECT userId, `name`, birthdate FROM Users;		-- esto es sobre lo que va a ir trabajando el cursor
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;		-- necesario
    
    OPEN curPrue;						-- abre el cursor previamente definido
    theLoop : LOOP						-- inicia el recorrido, donde va haciendo los fetch
		FETCH curPrue INTO theUserId, theName, theBirthdate;
        IF done THEN
			LEAVE theLoop;
		END IF;
        SET output = CONCAT(' (',theUserId,') ',theName,' born in ',YEAR(theBirthdate));	-- monta la salida
        SELECT output;						
	END LOOP;
    CLOSE curPrue;						-- cierra el cursor

END$$									-- fin del sp
DELIMITER ;

CALL spCursor();						-- llama al cursor

-- -------------------------------
-- 15.B Trigger
-- Cuando inserto la imagen, inmediatamente deberia insertarlo
-- en imagenes por usuario
-- -------------------------------
SET @ownerUser = 3;
INSERT INTO pictures(pictureURL, deleted) VALUES ('www.img.com/u3ph1',0);

DELIMITER //
CREATE TRIGGER TR_PicturesUser_afterInsert AFTER INSERT	-- creacion, le debo indicar un momento
ON pictures FOR EACH ROW
	INSERT INTO picturePerPerson(`default`, postTime, pictureId, userId)	-- cuando ocurre el momento, se dispara la accion
	VALUES (0,CURRENT_TIME(),NEW.pictureId,@ownerUser);
//
DELIMITER ;

SELECT * FROM pictures;
SELECT * FROM picturePerPerson;

-- -------------------------------
-- 15.C Substring
-- Suponga que se quiere listar de manera resumida,
-- las plataformas, de la siguiente manera:
-- Windows Vista/7/8/10, macOS X 10/ 11, Linux
-- -------------------------------

SET @wVista = (SELECT platform FROM PlatformsType WHERE idPlatformType = 1);

SET @w7 = (SELECT platform FROM PlatformsType WHERE idPlatformType = 2);

SET @w8 = (SELECT platform FROM PlatformsType WHERE idPlatformType = 3);

SET @w10 = (SELECT platform FROM PlatformsType WHERE idPlatformType = 4);

SET @mac10 = (SELECT platform FROM PlatformsType WHERE idPlatformType = 5);

SET @mac11 = (SELECT platform FROM PlatformsType WHERE idPlatformType = 6);

SET @lin = (SELECT platform FROM PlatformsType WHERE idPlatformType = 7);


-- este seria el total, aca se muestra el ejemplo del SUBSTRING
-- @allPlatforms = Windows Vista/7/8/0; macOS X 10/11; Linux
SET @allPlatforms = CONCAT(@wVista,'/',SUBSTRING(@w7,-1),'/',SUBSTRING(@w8,-1),'/',SUBSTRING(@w10,-2),'; ',
@mac10,'/',SUBSTRING(@mac11,-2),'; ',@lin);
SELECT @allPlatforms;