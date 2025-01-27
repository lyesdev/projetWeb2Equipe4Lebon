CREATE TABLE IF NOT EXISTS `chassis` (
  `idChassis` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `chassisfr` varchar(100) NOT NULL,
  `chassisen` varchar(100) DEFAULT NULL,
  `chassisStatut` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idChassis`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `typeCarburant` (
  `idTypeCarburant` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `typeCarburantfr` varchar(100) NOT NULL,
  `typeCarburanten` varchar(100) DEFAULT NULL,
  `tcStatut` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idTypeCarburant`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `groupeMotopropulseur` (
  `idGroupeMotopropulseur` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `groupeMotopropulseur` varchar(100) NOT NULL,
  `gmpStatut` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idGroupeMotopropulseur`)
) ENGINE=InnoDB;

CREATE TABLE fabricant (
	idFabricant TINYINT UNSIGNED AUTO_INCREMENT, 
	fabricant VARCHAR(100) NOT NULL,
	`fabricantStatut` int(11) NOT NULL DEFAULT '1',
	PRIMARY KEY (idFabricant)
)ENGINE=InnoDB;
CREATE TABLE marque (
	idMarque TINYINT UNSIGNED AUTO_INCREMENT, 
	idFabricant TINYINT UNSIGNED NOT NULL,
	marque VARCHAR(100) NOT NULL,
	`marqueStatut` int(11) NOT NULL DEFAULT '1',
	PRIMARY KEY (idMarque),
	FOREIGN KEY (idFabricant) REFERENCES fabricant(idFabricant)
)ENGINE=InnoDB;
CREATE TABLE modele (
	idModele SMALLINT UNSIGNED AUTO_INCREMENT, 
	idMarque TINYINT UNSIGNED NOT NULL, 	
	modele VARCHAR(100) NOT NULL,
	modeleStatut int(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (idModele),	
	FOREIGN KEY (idMarque) REFERENCES marque(idMarque)
)ENGINE=InnoDB;
CREATE TABLE transmission (
	idTransmission TINYINT UNSIGNED AUTO_INCREMENT, 
	transmissionfr VARCHAR(100) NOT NULL,
	transmissionen VARCHAR(100),
	PRIMARY KEY (idTransmission)
)ENGINE=InnoDB;	
CREATE TABLE statut (
	idStatut TINYINT UNSIGNED AUTO_INCREMENT, 
	statutfr VARCHAR(100) NOT NULL,
	statuten VARCHAR(100),
	PRIMARY KEY (idStatut)
)ENGINE=InnoDB;
CREATE TABLE voiture (
	idVoiture SMALLINT UNSIGNED AUTO_INCREMENT,
	vin VARCHAR(50) NOT NULL,
	prixVente MEDIUMINT NOT NULL, 
	annee SMALLINT UNSIGNED NOT NULL,
	dateArrivee DATE NOT NULL,
	prixPaye MEDIUMINT NOT NULL, 
	km MEDIUMINT NOT NULL, 
	couleurfr VARCHAR(50) NOT NULL,
	couleuren VARCHAR(50) NOT NULL,
	vedette int(1) NOT NULL DEFAULT 0,
	idGroupeMotopropulseur TINYINT UNSIGNED NOT NULL,
	idTypeCarburant TINYINT UNSIGNED NOT NULL,
	idChassis TINYINT UNSIGNED NOT NULL,
	idModele SMALLINT UNSIGNED NOT NULL, 
	idTransmission TINYINT UNSIGNED NOT NULL,
	idStatut TINYINT UNSIGNED NOT NULL DEFAULT 3,
	PRIMARY KEY (idVoiture),
	FOREIGN KEY (idTypeCarburant) REFERENCES typeCarburant(idTypeCarburant),
	FOREIGN KEY (idModele) REFERENCES modele(idModele),
	FOREIGN KEY (idChassis) REFERENCES chassis(idChassis),
	FOREIGN KEY (idTransmission) REFERENCES transmission(idTransmission),
	FOREIGN KEY (idStatut) REFERENCES statut(idStatut),
	FOREIGN KEY (idGroupeMotopropulseur) REFERENCES groupeMotopropulseur(idGroupeMotopropulseur)
)ENGINE=InnoDB;
CREATE TABLE listeImage (
	idImage SMALLINT UNSIGNED AUTO_INCREMENT, 
	cheminFichier VARCHAR(255) NOT NULL,	
	idVoiture SMALLINT UNSIGNED,
	ordre TINYINT UNSIGNED NOT NULL,
	PRIMARY KEY (idImage),
	FOREIGN KEY (idVoiture) REFERENCES voiture(idVoiture)
)ENGINE=InnoDB;	
CREATE TABLE ville (
	idVille SMALLINT UNSIGNED AUTO_INCREMENT, 
	ville VARCHAR(200) NOT NULL,
	PRIMARY KEY (idVille)
)ENGINE=InnoDB;	
CREATE TABLE province (
	idProvince SMALLINT UNSIGNED AUTO_INCREMENT, 
	province VARCHAR(150) NOT NULL,
	tvp SMALLINT UNSIGNED,
	tvs SMALLINT UNSIGNED,
	tvh SMALLINT UNSIGNED,
	PRIMARY KEY (idProvince)
)ENGINE=InnoDB;
CREATE TABLE typeUtilisateur (
	idTypeUtilisateur TINYINT UNSIGNED AUTO_INCREMENT, 
	typeUtilisateurfr VARCHAR(100) NOT NULL,
	typeUtilisateuren VARCHAR(100),
	PRIMARY KEY (idTypeUtilisateur)
)ENGINE=InnoDB;
CREATE TABLE utilisateur (
	idUtilisateur MEDIUMINT UNSIGNED AUTO_INCREMENT, 
	nomUtilisateur VARCHAR(255) NOT NULL UNIQUE,
	motPasse VARCHAR(255) NOT NULL,
	prenom VARCHAR(255) NOT NULL,
	nomFamille VARCHAR(255) NOT NULL,
	courriel VARCHAR(255) NOT NULL UNIQUE,
	dateNaissance DATE NOT NULL, 
	noCivique SMALLINT UNSIGNED,
	rue VARCHAR(255),
	codePostal VARCHAR(20),
	telephone VARCHAR(20) NOT NULL,
	telephonePortable VARCHAR(20),	
	idTypeUtilisateur TINYINT UNSIGNED NOT NULL DEFAULT 1, 
	idVille SMALLINT UNSIGNED, 
	idProvince SMALLINT UNSIGNED, 
	PRIMARY KEY (idUtilisateur), 
	FOREIGN KEY (idTypeUtilisateur) REFERENCES typeUtilisateur(idTypeUtilisateur),
	FOREIGN KEY (idVille) REFERENCES ville(idVille),
	FOREIGN KEY (idProvince) REFERENCES province(idProvince)
)ENGINE=InnoDB;
CREATE TABLE connexion (
	idConnexion INT UNSIGNED AUTO_INCREMENT, 
	idUtilisateur MEDIUMINT UNSIGNED NOT NULL,
	dateConnexion DATE NOT NULL,
	adresseIP VARCHAR(15) NOT NULL,
	PRIMARY KEY (idConnexion)
)ENGINE=InnoDB;
CREATE TABLE modePaiement (
	idModePaiement TINYINT UNSIGNED AUTO_INCREMENT, 
	modePaiementfr VARCHAR(100) NOT NULL,
	modePaiementen VARCHAR(100),
	PRIMARY KEY (idModePaiement)
)ENGINE=InnoDB;
CREATE TABLE expedition (
	idExpedition TINYINT UNSIGNED AUTO_INCREMENT, 
	expeditionfr VARCHAR(100) NOT NULL,
	expeditionen VARCHAR(100),
	PRIMARY KEY (idExpedition)
)ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS `commande` (
  `idCommande` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dateCommande` date NOT NULL,
  `idUtilisateur` mediumint(8) UNSIGNED NOT NULL,
  `idModePaiement` tinyint(3) UNSIGNED NOT NULL,
  `idExpedition` tinyint(3) UNSIGNED NOT NULL,
  `idStatut` tinyint(3) UNSIGNED NOT NULL,
  `statutPayment` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idCommande`),
  KEY `idUtilisateur` (`idUtilisateur`),
  KEY `idModePaiement` (`idModePaiement`),
  KEY `idExpedition` (`idExpedition`),
  KEY `idStatut` (`idStatut`)
) ENGINE=InnoDB;
CREATE TABLE ligneCommande (
	idCommande INT UNSIGNED NOT NULL AUTO_INCREMENT,	
	idVoiture SMALLINT UNSIGNED NOT NULL,
	quantite TINYINT UNSIGNED NOT NULL,
	PRIMARY KEY (idCommande, idVoiture), 
	FOREIGN KEY (idCommande) REFERENCES commande(idCommande),
	FOREIGN KEY (idVoiture) REFERENCES voiture(idVoiture)
)ENGINE=InnoDB;

CREATE TABLE facture (
	idFacture TINYINT UNSIGNED AUTO_INCREMENT, 
	idCommande INT UNSIGNED NOT NULL,
	PRIMARY KEY (idFacture),
	FOREIGN KEY (idCommande) REFERENCES commande(idCommande)	
)ENGINE=InnoDB;
