-- -----------------------------------
-- Script #4 - Andres
-- 15/05/2021
-- Summary:
-- Creacion de dos vistas utiles para el sistema
-- -----------------------------------

-- ------------------------------------------
-- 1.view_GameSalesPublisher: Muestra info monetaria de los juegos
-- me dice el juego, precio, comisiones y el publisher
-- seria como una consulta hecha por admins
-- ------------------------------------------

-- DROP VIEW IF EXISTS view_GameSalesPublisher; -- en caso de que ya existiera

CREATE VIEW view_GameSalesPublisher
AS
SELECT g.`name`, g.iconURL, gs.currencySymbol, gs.retailPrice, gs.discount, gs.publisher_percentage, gs.posttime,
p.company_name, p.mail FROM Games g INNER JOIN GameSaleInfo gs ON g.Gameid = gs.Gameid
INNER JOIN Publishers p ON gs.publisherId = p.publisherId;

SELECT * FROM view_GameSalesPublisher;

-- ----------------------------------------------------------------------
-- 2. view_userGames muestra la informacion del usuario y su juego.
-- nombre del usuario, del juego, cuando lo compro y el numero de orden
-- ----------------------------------------------------------------------

-- DROP VIEW IF EXISTS view_GameSalesPublisher; -- en caso de que ya existiera

CREATE VIEW view_userGames
AS
SELECT CONCAT(u.`name`,' ',u.lastname) AS username, g.`name` AS game, gp.`date`, gp.idPurchaseOrder FROM
Users u INNER JOIN GamesPerUser gp ON u.userid = gp.userid
INNER JOIN Games g ON gp.Gameid = g.Gameid;

SELECT * FROM view_userGames;
