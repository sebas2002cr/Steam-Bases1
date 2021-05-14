-- -----------------------------------
-- Script #1 - Andres
-- 14/05/2021
-- Summary:
-- Insercion de plataformas
-- Insercion de ESRB
-- Insercion de Countries
-- Insercion de Publishers
-- Insercion de Algunos usuarios
-- Insercion de Generos
-- Insercion de Badges Levels
-- Insercion de Friends Types
-- Insercion de Wish States
-- Insercion de Actions
-- Insercion del Merchant
-- Insercion de Item_Category
-- Payment Status
-- Anniadimos algunos pictures y las ligamos con su usuario
-- ------------------------------------

-- -------------------------------
-- Insercion de plataformas
-- -------------------------------

INSERT INTO PlatformsType(platform)
VALUES ('Windows Vista'),('Windows 7'),
('Windows 8'), ('Windows 10'),
('macOS X 10'), ('macOS 11'),
('Linux');

-- -------------------------------
-- Insercion de ESRB
-- -------------------------------

INSERT INTO ESRB_Clasification (ageBegin, description)
VALUES (0,'Everyone'), (10,'Everyone 10+'), (13,'Teen'),
(17,'Mature 17+'), (18,'Adults Only 18+'), (0, 'Raiting Pending');

-- -------------------------------
-- Insercion de Countries
-- -------------------------------

INSERT INTO Countries(name)
VALUES ('United States'), ('Costa Rica'),
('Argentina'), ('Spain'), ('United Kingdom'),
('Germany'), ('Netherlands'), ('Rusia'),
('Vietnam'), ('India'), ('China'), ('Japan'),
('South Africa'), ('Egypt'), ('Australia');

-- -------------------------------
-- Insercion de Publishers
-- -------------------------------

SELECT * FROM Publishers;

INSERT INTO 
Publishers (name, company_name, countryId, mail, webSiteURL)
VALUES
('TEC Games','Tecnology Games CR',2,'service@tecnologygames.cr','www.tecnologygames.cr'),
('Desarrollos La Coruña','Sociedad de videojuegos ltd',4,'about@vjltd.com','www.desarrolloslacoruna.com'),
('Deutschland Spiele','DVS Bayer',6,'info@dvsbayer.com','www.deutschspiele86.com'),
('Grizzly run','The Grizzly comp',8,'us@grizzlyrun.com','www.thegrizzlycomp.ru'),
('Savanna Devs','Savanna enterprise',13,'contact@savanna.com','www.savannadevs.com');

-- ejemplo de inner join
SELECT P.publisherId, P.name, C.name
FROM Publishers P
INNER JOIN Countries C ON P.countryId = C.countryId;

-- -------------------------------
-- Insercion de Algunos usuarios
-- -------------------------------

INSERT INTO Users(name, lastname, password, mail, birthdate, countryId)
VALUES
('Andrés','Arias',SHA2('AndresArias3',256), 'andres.arias@esitcr.com','1998-01-01',2),
('Josué', 'Navarro', SHA2('JosueNavarro6',256), 'josue.navarro@esitcr.com', '2001-09-15', 2),
('Sebastián','Obando',SHA2('SebastianObando8',256),'sebastian.obando@esitcr.com','2001-12-31',2),
('George','Washington',SHA2('GeorgeWashington6',256),'george.washington@indepency.us','1965-05-13',1),
('Gurgen','Miller',SHA2('GurgenMiller86',256),'gurgen.miller@germany.com','1986-08-24',6),
('Yuri','Markov',SHA2('YuriMarkov15',256),'yuri.markov@onemail,com','1979-12-05',8),
('Tse','Liang',SHA2('TseLian21',256),'tse.lian@mailch.com','2005-01-10',11);

-- -------------------------------
-- Insercion de Generos
-- -------------------------------

INSERT INTO GenderType(type) VALUES
('action'), ('adventure'), ('arcade'), ('indie'), ('races'), ('role'),
('shooters'), ('simulator'), ('sports'), ('suspense'), ('tematic');

-- -------------------------------
-- Insercion de Badges Levels
-- -------------------------------

INSERT INTO Badges_Levels (badge_levelId, name)
VALUES
(1, 'Diamond'), (2, 'Platinum'), (3, 'Gold'), (4, 'Silver'), (5, 'Bronze');

-- ----------------------------
-- Insercion de Friends Types
-- ---------------------------

INSERT INTO RelationshipTypes(name) VALUES
('Friend'), ('Mentor');

-- ----------------------------
-- Insercion Wish States
-- ----------------------------
INSERT INTO Wish_States(name) VALUES ('For Me'), ('For Friend');

-- ----------------------------
-- Insercion de Actions
-- ----------------------------

INSERT INTO Actions(name) VALUES
('Start'), ('Stop'), ('Pause'), ('Play'), ('Abort');

-- ----------------------------
-- Insercion del Merchant
-- ----------------------------

-- En este caso, el merchant es paypal
INSERT INTO Merchants(name, URL, enabled, iconURL) VALUES
('PayPal', 'www.paypal.com/connectivity', 1, 'www.img.com/paypallogo');


-- ------------------------------
-- Insercion de Item_Category
-- ------------------------------

INSERT INTO item_category (name) VALUES
('games');

-- --------------------------
-- Payment Status
-- --------------------------

SELECT * FROM PaymentStatus;
INSERT INTO PaymentStatus(name) VALUES
('Completed'), ('Pending'), ('Canceled'), ('Denied'), ('Failed'), ('Refunded');

-- --------------------------------------------------------
-- Anniadimos algunos pictures y las ligamos con su usuario
-- --------------------------------------------------------

SELECT * FROM pictures;

-- estas imagenes seran del usuario 1
INSERT INTO pictures(pictureURL, deleted) VALUES
('www.img.com/u1ph1', 0), ('www.img.com/u1ph2', 1), ('www.img.com/u1ph3', 0);

-- estas imagenes seran del juego 1
INSERT INTO pictures(pictureURL, deleted) VALUES
('www.img.com/g1ph1', 0), ('www.img.com/g1ph2', 1);

-- salvandolas en picturesPerPerson
INSERT INTO picturePerPerson(`default`, postTime, pictureId, userid)
VALUES (0, '2021-05-14 22:09:15', 1, 1);

INSERT INTO picturePerPerson(`default`, postTime, pictureId, userid)
VALUES (0, '2021-05-14 22:10:59', 2, 1);

INSERT INTO picturePerPerson(`default`, postTime, pictureId, userid)
VALUES (1, '2021-05-14 22:11:12', 3, 1);

-- -----------------------------
-- Creacion de un juego (Desarrollo)
-- -----------------------------

SELECT * FROM Games;

SELECT * FROM ESRB_Clasification;

SELECT * FROM GenderType;

SELECT * FROM Publishers;
