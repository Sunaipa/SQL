CREATE DATABASE IF NOT EXISTS bibliotheque_2022 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE bibliotheque_2022;

SET foreign_key_checks = 0;

CREATE TABLE IF NOT EXISTS ouvrages(
    id MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(70) NOT NULL,
    id_auteur MEDIUMINT UNSIGNED NOT NULL,
    id_genre SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT ouvrage_to_auteur FOREIGN KEY(id_auteur) REFERENCES auteurs(id),
    CONSTRAINT ouvrage_to_genre FOREIGN KEY(id_genre) REFERENCES genres(id)
);

CREATE TABLE IF NOT EXISTS auteurs(
    id MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS genres(
    id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    genre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS tags(
    id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    tag VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS ouvrages_tag(
    id_ouvrage MEDIUMINT UNSIGNED,
    id_tag SMALLINT UNSIGNED,
    PRIMARY KEY (id_ouvrage, id_tag)
);

CREATE TABLE IF NOT EXISTS editions(
    id MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    isbn CHAR(13) NOT NULL,
    id_ouvrage MEDIUMINT UNSIGNED NOT NULL,
    id_editeur MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT editions_to_ouvrage FOREIGN KEY(id_ouvrage) REFERENCES ouvrages(id),
    CONSTRAINT editions_to_editeur FOREIGN KEY(id_editeur) REFERENCES editeurs(id)

);

CREATE TABLE IF NOT EXISTS editeurs(
    id MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS exemplaires(
    id MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    date_achat DATE NOT NULL,
    id_edition MEDIUMINT UNSIGNED,
    id_usure TINYINT UNSIGNED NOT NULL,
    CONSTRAINT exemplaire_to_edition FOREIGN KEY(id_edition) REFERENCES editions(id),
    CONSTRAINT exemplaire_to_usure FOREIGN KEY(id_usure) REFERENCES etats_usure(id)
);

CREATE TABLE IF NOT EXISTS etats_usure(
    id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    usure VARCHAR(20) NOT NULL
);


CREATE TABLE IF NOT EXISTS clients(
    id MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    id_adresse MEDIUMINT UNSIGNED NOT NULL,
    id_csp TINYINT UNSIGNED NOT NULL,
    CONSTRAINT client_to_adresse FOREIGN KEY(id_adresse) REFERENCES adresses(id),
    CONSTRAINT client_to_csp FOREIGN KEY(id_csp) REFERENCES csp(id)
);


CREATE TABLE IF NOT EXISTS adresses(
    id MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    rue VARCHAR(38) NOT NULL,
    code_postal CHAR(5) NOT NULL,
    ville VARCHAR(32) NOT NULL
);

CREATE TABLE IF NOT EXISTS csp(
id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
csp VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS emprunts(
    id_client MEDIUMINT UNSIGNED,
    id_exemplaire MEDIUMINT UNSIGNED,
    date_emprunt DATE NOT NULL,
    date_retour DATE,
    CONSTRAINT emprunt_to_client FOREIGN KEY(id_client) REFERENCES clients(id),
    CONSTRAINT emprunt_to_exemplaire FOREIGN KEY(id_exemplaire) REFERENCES exemplaires(id)
);

CREATE TABLE IF NOT EXISTS reservation(
    id_client MEDIUMINT UNSIGNED,
    id_ouvrage MEDIUMINT UNSIGNED,
    date_reservation DATE NOT NULL,
    CONSTRAINT reservation_to_client FOREIGN KEY(id_client) REFERENCES clients(id),
    CONSTRAINT reservation_to_ouvrage FOREIGN KEY(id_ouvrage) REFERENCES ouvrages(id)
);


SET foreign_key_checks = 1;