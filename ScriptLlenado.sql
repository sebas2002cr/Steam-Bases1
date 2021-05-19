

-- -----------------------------------
-- Script #1 - Andres-Sebastian
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

-- INSERT INTO PlatformsType(platform)
-- VALUES ('Windows Vista'),('Windows 7'),
-- ('Windows 8'), ('Windows 10'),
-- ('macOS X 10'), ('macOS 11'),
-- ('Linux');

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
('Savanna Devs','Savanna enterprise',13,'contact@savanna.com','www.savannadevs.com'),
-- Nuevos-----------------------
('Epic Games','Epic Games INC',1,'security@epicgames.com','www.epicgames.com'),
('EA Sports','Electronic Arts',1,'customerservive@easports.com','www.ea.com/sports'), 
('Blizzard Entertainment','Blizzard',1,'customerservive@blizzard.com','www.blizzard.com');
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
('Tse','Liang',SHA2('TseLian21',256),'tse.lian@mailch.com','2005-01-10',11),
-- ---------------------- Sebastian (Nuevos)
('Alejandro','Ruiz',SHA2('Ale2021cr',256),'aleRuiz05@gmail.com','2005-07-12',3),
('Javier','Fuentes',SHA2('Jafu1723',256),'jafu1968@gmail.com','1968-07-20',4),
('Tatiana','Fuentes',SHA2('Roxxy15',256),'taty2002@yopmail.com','2002-07-15',1),
('Silvia','Paniagua',SHA2('silpaniagua01',256),'silviapaniagua@estudiantec.com','1969-11-10',1),
('Luis','Obando',SHA2('Radu2021',256),'luis.obando@consultek.com','1971-01-9',6),
('Daniel','Castro',SHA2('Castro2021cr',256),'CasDan1975@mailch.com','1975-03-17',4),
('David','Alvarez',SHA2('DaAl1985',256),'david.tico@costarica.com','1985-08-25',1),
('Pedro','Sanchez',SHA2('1776PedroSanchez',256),'pedro1776@hotmail.com','1776-05-23',1),
('Roy','Miller',SHA2('RoyMiller76',256),'roy.miller@yopmail.com','1976-02-21',5),
('Leah','Valvoa',SHA2('Leahvalvoa25',256),'leah.valvoa@gmail,com','1975-12-25',8),
('Yuan','Chang',SHA2('YuanChang22',256),'yuanchang22@china.com','1979-01-22',11),
('Carlos','Alvarado',SHA2('Carlitos30',256),'alvcarlitos@yopmail.com','1968-07-30',1),
('Camila','Chacon',SHA2('Camicha2002',256),'chacamilacr@gmail.com','1999-11-21',1),
('Keylor','Navas',SHA2('Psg2021cr',256),'keylor.navas@psg.com','1979-01-21',6),
('Bryan','Castro',SHA2('CastroBryancr',256),'bryan1995cr@mailch.com','1995-02-27',4),
('Maria','Camacho',SHA2('MariCamacho22',256),'camacho_maria@yopmail.com','1985-02-15',1),
('Andrea','Navarro',SHA2('Andre20cr',256),'navandre20@gmail,com','1965-12-31',8),
('Fernanda','Lee',SHA2('Fercr13',256),'ferleecr@gmail.com','1989-06-13',11),
('Josue','Fernandez',SHA2('FernandezJos',256),'fern.josue@yopmail.com','1982-07-10',1),
('Pepe','Ramirez',SHA2('Rapepe',256),'peperamirez@gmail.com','1974-10-14',1),
('Xinia','Obando',SHA2('Andrecito22',256),'obando.xinia@gmail.com','1979-09-21',6),
('Lorena','Paniagua',SHA2('NachoSando',256),'lorenapaniagua72@mailch.com','1972-02-21',4),
('Maria','Sandoval',SHA2('Sandocr17',256),'sandomar17cr@yopmail.com','1995-05-17',1);


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


-- ------------------------------------------------------------
-- Games
INSERT INTO Games (name, description,iconURL, URL,enabled, ESRB_ClasificationId, idGenderType )
VALUES
('Overwatch', 'Overwatch is a 2016 team-based multiplayer first-person shooter developed and published
 by Blizzard Entertainment. Described as a "hero shooter", Overwatch assigns players into two teams of 
 six, with each player selecting from a large roster of characters, known as "heroes", with unique abilities.'
 , 'www.img.com\overwatchlogo','www.playoverwatch.com', 1, 4, 3 ),

('Fortnite', 'Fortnite is an online video game developed by Epic Games and released 
in 2017. It is available in three distinct game mode versions that otherwise share 
the same general gameplay and game engine', 'www.img.com\fornitelogo',
'www.epicgames.com', 1, 3, 2 ),

('Minecraft', 'Minecraft is a sandbox video game developed by Mojang. The game was
 created by Markus "Notch" Persson in the Java programming language.', 'www.img.com\minecraftlogo',
'www.minecraft.net', 1, 1, 8 ),

('The Last of Us', 'The Last of Us is a 2013 action-adventure game developed by Naughty Dog 
and published by Sony Computer Entertainment. Players control Joel, a smuggler tasked with
 escorting a teenage girl, Ellie, across a post-apocalyptic United States. The Last of Us is
 played from a third-person perspective.', 'www.img.com\theLastOfUslogo',
'www.naughtydog.com', 1, 3, 6 ),

('Among Us', 'Among Us is a 2018 online multiplayer social deduction game developed and 
published by American game studio Innersloth.', 'www.img.com\amongUslogo',
'www.innersloth.com', 1, 1, 1 ),

('Call of Duty: Warzone', 'Call of Duty: Warzone is a free-to-play battle royale video
 game released on March 10, 2020', 'www.img.com\warzonelogo',
'www.callofduty.com', 1, 5, 2 ),

('Counter-Strike', 'Counter-Strike is a first-person shooter video game developed by Valve.
 It was initially developed and released as a Half-Life modification by Minh "Gooseman"
 Le and Jess Cliffe in 1999, before Le and Cliffe were hired and the game intellectual property 
 acquired.', 'www.img.com\counterStrikelogo','https://blog.counter-strike.net', 1, 5, 2 ),
 
 ('Rocket League', 'Rocket League is a vehicular soccer video game developed and published by Psyonix.',
 'www.img.com\rocketLeaguelogo','www.rocketleague.com', 1, 5, 2 ),
 
  ('FIFA 21', 'FIFA 21 is a football simulation video game published by Electronic Arts as part of the
  FIFA series. It is the 28th installment in the FIFA series, and was released on 9 October 2020.',
 'www.img.com\fifa21logo','www.ea.com', 1, 4, 1 ),
 
 ('Tetris', 'Tetris is a tile-matching video game created by Russian software engineer Alexey Pajitnov 
 in 1984 for the Electronika 60 computer. It has been published by several companies, most prominently
 during a dispute over the appropriation of the rights in the late 1980s.', 'www.img.com\amongUslogo',
'www.innersloth.com', 1, 1, 5 ),

('Fallout 3', 'Fallout 3 is a 2008 post-apocalyptic action role-playing open world video game developed 
by Bethesda Game Studios and published by Bethesda Softworks. The third major installment in the Fallout
 series, it is the first game to be created by Bethesda since it bought the franchise from Interplay Entertainment.'
 , 'www.img.com\amongUslogo','www.innersloth.com', 1, 4, 3 );
-- ------------------------------------------------------------




-- SELECTS --------
SELECT * FROM Games;
SELECT * FROM Publishers;
SELECT * FROM ESRB_Clasification;
SELECT * FROM GenderType;
SELECT * FROM GameSaleInfo;
-- -----------------

INSERT INTO 
Publishers (name, company_name, countryId, mail, webSiteURL)
VALUES
('MOJANG Studios','Mojang Studios',7,'service@mojang.com','www.minecraft.net/en-us');


-- ------------------------------------------------------------
-- Gender Types
INSERT INTO GenderType(type)
VALUES
('Real-time strategy '), ('Shooters'), ('Role-playing '), 
('Simulation and sports.'), ('Puzzlers and party games.'), 
('Action-adventure.'), ('Survival and horror'),('SandBox');

-- ------------------------------------------------------------


-- ------------------------------------------------------------
-- Game Sales Info

INSERT INTO GameSaleInfo(Gameid,publisherId,retailPrice,currencySymbol,discount,publisher_percentage,isCurrentRunning,posttime,checksum,ipAddress,username)
VALUES
(1,8 , 39.99, 'USD', 0.00, 0.60, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'Keylor' ),
(2,6 , 0.00, 'USD', 0.00, 0.00, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'Maria' ),
(3,9 , 26.95, 'USD', 0.00, 0.60, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'David' ),
(4,2 , 59.99, 'USD', 0.20, 0.70, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'Alejandro' ),
(5,3 , 12.00, 'USD', 0.00, 0.80, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'Leah' ),
(6,5 , 49.99, 'USD', 0.25, 0.60, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'Yuri' ),
(7,6 , 14.99, 'USD', 0.00, 0.75, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'Luis' ),
(8,7 , 19.99, 'USD', 0.30, 0.60, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'Silvia' ),
(9,7 , 59.99, 'USD', 0.10, 0.70, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'Andres' ),
(10, 4 , 9.99, 'USD', 0.00, 0.60, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'Josue' ),
(11, 8 , 39.99, 'USD', 0.20, 0.55, 1, current_timestamp(), sha2(CONCAT(CURRENT_TIMESTAMP(), ' ' , '121.65.18.64', ' ' ), '121.65.18.64', 'Tatiana');

-- ------------------------------------------------------------

