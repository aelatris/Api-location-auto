
DROP SCHEMA IF EXISTS `service_livraison` ;
CREATE SCHEMA IF NOT EXISTS `service_livraison` DEFAULT CHARACTER SET utf8 ;
USE `service_livraison` ;



CREATE TABLE Role_utilisateur (
    utilisateur_code VARCHAR(255) NOT NULL,
    role SET('client', 'livreur', 'gérant') NOT NULL,
    horodatage TIMESTAMP NOT NULL,
    PRIMARY KEY (utilisateur_code, role),
    FOREIGN KEY (Role_utilisateur) REFERENCES Utilisateur (code)
);


CREATE TABLE livraison (
    code VARCHAR(255) PRIMARY KEY,
    commande_code VARCHAR(255) NOT NULL,
    utilisateur_code VARCHAR(255) NOT NULL,
    adresse_id INT NOT NULL,
    FOREIGN KEY (livraison) REFERENCES Utilisateur (code),
    FOREIGN KEY (livraison) REFERENCES Comande (code),
    FOREIGN KEY (livraison) REFERENCES Adresse (code)
);



CREATE TABLE livraison_état (
    livraison_code VARCHAR(255) NOT NULL,
    état_code SET('créée', 'acceptée', 'en route', 'livrée') NOT NULL,
    horodatage TIMESTAMP NOT NULL,
    PRIMARY KEY (livraison_code, utilisateur_code, adresse_id),
    FOREIGN KEY (livraison_code) REFERENCES Livraison (code)
);



CREATE TABLE `commande` (
  `code` varchar(255) NOT NULL,
  `utilisateur_code` varchar(255) NOT NULL,
  `restaurant_code` varchar(255) NOT NULL,
  PRIMARY KEY (`code`),
  FOREIGN KEY (utilisateur_code) references Utilisateur,
  FOREIGN KEY (restaurant_code) references Restaurant
);


CREATE TABLE `commande_item` (
  `code_commande` varchar(255) NOT NULL,
  `code_item` varchar(255) NOT NULL,
  `quantité` int NOT NULL,
  PRIMARY KEY (`code_commande`,`code_item`),
  FOREIGN KEY (code_commande) references Commande,
  FOREIGN KEY (code_item) references Item
);

CREATE TABLE `commande_état` ( 
  `commande_code` varchar(255) NOT NULL,
  `état` set('créée','acceptée','en préparation','prête','ramassée') NOT NULL,
  `horodatage` timestamp NOT NULL,
  PRIMARY KEY (`commande_code`,`état_code`,`horodatage`),
  FOREIGN KEY (commande_code) references Commande 
  ) ;


Create Table Utilisateur (
code VARCHAR(255) NOT NULL, 
nom VARCHAR(255) NOT NULL, 
prénom VARCHAR(255) NOT NULL,
courriel VARCHAR(255) NOT NULL UNIQUE,
adresse_id int NOT NULL, 
téléphone VARCHAR(255) NOT NULL,
id_auth0 VARCHAR(255) NOT NULL,
PRIMARY KEY (code),
FOREIGN KEY (adress_id) references Adresse
);

Create Table Adresse (id int Auto_Increment,
appartement VARCHAR(255),
numéro_municipal VARCHAR(255) NOT NULL,
rue VARCHAR(255) NOT NULL,
ville VARCHAR(255) NOT NULL,
province char(2),
code_postal VARCHAR(255) NOT NULL,
pays char(2) NOT NULL,
PRIMARY KEY (id));

Create Table restaurant_utilisateur(utilisateur_code VARCHAR(255) NOT NULL,
restaurant_code VARCHAR(255),
FOREIGN KEY (utilisateur_code) references Utilisateur,
FOREIGN KEY (restaurant_code) references Restaurant)

CREATE TABLE IF NOT EXISTS `service_livraison`.`restaurant` (
  `code` INT NOT NULL,
  `nom` VARCHAR(255) NOT NULL,
  `description` VARCHAR (255)NOT NULL,
  `addresse_id` INT NOT NULL,
  PRIMARY KEY (`code`))
  ENGINE = InnoBD;

DROP TABLE IF EXISTS `service_livraison`.`menu`;

CREATE TABLE IF NOT EXISTS `service_livraison`.`menu`(
`id` INT NOT NULL,
`restaurant_code` VARCHAR (255) ,
`nom` VARCHAR (255),
PRIMARY KEY (`id`),
FOREIGN KEY (`restaurant_code`)
	REFERENCES `restaurant`(`code`))
    ENGINE = InnoBD;

DROP TABLE IF EXISTS `service_livraison`.`item`;

CREATE TABLE IF NOT EXISTS `service_livraison`.`item`(
`code` VARCHAR (255) NOT NULL,
`nom` VARCHAR (255) NOT NULL,
`description` TEXT,
`prix` INT NOT NULL,
PRIMARY KEY (`id`))
ENGINE = InnoBD;



