-- -----------------------------------
-- Script #3 - Andres
-- 15/05/2021
-- Summary:
-- #10. Select con columna dinamica CASE
-- #12. SP cuya consulta retorne union de tres tablas en formato JSON
-- #13. SP que inserta N registros, tomando los datos correctos, de una tabla temporal.
-- -----------------------------------

-- --------------------------------------------------------------------
-- #10. Select con columna dinamica, en este caso, se utiliza el case
-- y va agrupando la cantidad de juegos que tiene una plataforma
-- --------------------------------------------------------------------

SELECT * FROM Game_Platforms;
SELECT 													-- va agrupando y contando
    SUM(CASE
        WHEN idPlatformType=1 THEN 1
        ELSE 0
    END) AS 'win Vista',
    SUM(CASE
        WHEN idPlatformType=2 THEN 1
        ELSE 0
    END) AS 'win 7',
    SUM(CASE
        WHEN idPlatformType=3 THEN 1
        ELSE 0
    END) AS 'win 8',
    SUM(CASE
        WHEN idPlatformType=4 THEN 1
        ELSE 0
    END) AS 'win 10',
    SUM(CASE
        WHEN idPlatformType=5 THEN 1
        ELSE 0
    END) AS 'macOS X 10',
    SUM(CASE
        WHEN idPlatformType=6 THEN 1
        ELSE 0
    END) AS 'macOS 11',
    SUM(CASE
        WHEN idPlatformType=7 THEN 1
        ELSE 0
    END) AS 'Linux'
FROM
    Game_Platforms;
    
-- --------------------------------------------------------------------
-- #12. SP cuya consulta retorne union de tres tablas en formato JSON
-- en este caso me retorna los badges de un juego.
-- Debe trabajar con games, badges, badges_levels
-- --------------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_ListBadgesOf;							-- si ya existia, lo quito

DELIMITER //
CREATE PROCEDURE sp_ListBadgesOf(pName NVARCHAR(64))
BEGIN
	SELECT JSON_OBJECT('game',g.`name`, 'game_iconURL', g.iconURL, 
	'badge',b.`name`, 'description', miniDescription, 'badge_iconURL', b.iconURL, 'level of the badge', bl.`name`)
    AS Badges
	FROM Games g INNER JOIN Badges b ON g.Gameid = b.Gameid
	INNER JOIN Badges_Levels bl ON b.badge_levelId = bl.badge_levelId
    WHERE g.`name` = pName;

END//
DELIMITER ;

CALL sp_ListBadgesOf('Grand Theft Auto V'); -- no recibe id, busca el juego por el nombre

-- --------------------------------------------------------------------
-- #13. SP que inserta N registros, tomando los datos correctos, de una
-- tabla temporal.
-- --------------------------------------------------------------------

-- Game session al cual perteneceran los gamelogs

-- Game_Session a la cual pertenece los logs
SELECT * FROM Game_Sessions;

INSERT INTO Game_Sessions (userid, Gameid, `start`, `finish`, favorite, isPublic, deleted, captureURL)
VALUES (1, 1, '2021-05-18 16:32:20', '2021-05-18 16:32:20', 0, 1, 0, 'www.img.com/gs2');

DROP PROCEDURE IF EXISTS insertNrecords;

-- sp TRANSACCIONAL que inserta todos los gamelogs de un solo
DELIMITER $$
CREATE PROCEDURE insertNrecords(pGroupKey INT) -- el parametro que recibo, es la llave por la que esta agrupado los datos
BEGIN
	SET autocommit = 0;							-- contextual (de la conexion). En 0 apago los commits automaticos
	START TRANSACTION;							-- todo o nada, o inserto los n, o ninguno
		INSERT INTO Game_Logs(posttime, ipAddress, actionId, game_session_id)		-- inserta de la temporal
		SELECT posttime, ipAddress, actionId, game_session_id 
		FROM GameLogsTemp
		WHERE groupkey = pGroupKey;				-- llave de agrupacion para esta insercion
    COMMIT;										-- entre start y commit, debe ser rapido
END$$
DELIMITER ;

 -- definicion de la tabla temporal AQUI VAN LOS N REGISTROS A INSERTAR
CREATE TEMPORARY TABLE GameLogsTemp (
	groupkey INT,					-- agrupar los datos que se van a insertar
    posttime DATETIME,
    ipAddress VARBINARY(32),	
    actionId TINYINT, 
    game_session_id BIGINT			-- estos ultimos son fks, pero se supone que ya estan verificados
    );
    
-- inserto en la tabla temporal. 	-- en este caso tomamos al groupkey 1
INSERT INTO GameLogsTemp(groupkey, posttime, ipAddress, actionId, game_session_id) VALUES
(1024,'2021-05-18 19:32:20', '117.27.82.19', 1, 2),
(1024,'2021-05-18 20:18:46', '117.27.82.19', 2, 2),
(1024,'2021-05-18 20:24:54', '104.35.62.05', 4, 1),
(1024,'2021-05-18 21:46:31', '104.35.62.05', 3, 1),
(1024,'2021-05-18 23:50:08', '104.35.62.05', 2, 1);

SELECT * FROM GameLogsTemp; 	-- verificacion de que se haya insertado en la temporal

								-- Llama al procedimiento, SI INSERTA
CALL insertNrecords(1024);		-- Le paso por parametro, el key que agrupa a los n datos a insertar

SELECT * FROM Game_Logs; 		-- Para comprobar que se insertaron