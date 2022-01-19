SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE adresses;
INSERT INTO adresses (rue, code_postal, ville)
VALUES
('3 rue des mésanges', '39000', 'Arbois'),
('5 rue des merles', '39000', 'Arbois'),
('3 rue des maquareux', '25440', 'Quingey');

TRUNCATE etats_usure;
INSERT INTO etats_usure(usure)
VALUES ('neuf'), ('Très bon état'), ('usagé'), ('mauvais état'), ('H.S');

TRUNCATE csp;
INSERT INTO csp(csp)
VALUES ('ouvier'), ('Employé'), ('cadre'), ('retraité'), ('étudiant'), ('enfant');

TRUNCATE clients;
INSERT INTO clients(prenom, nom, id_adresse, id_csp)
VALUES 
('Isabelle', 'Allende', 1, 3),
('Paul', 'Auster', 2, 4),
('Pierre', 'de Ronsard', 2, 2),
('Oliver', 'Twist', 3, 3);

TRUNCATE auteurs;
INSERT INTO auteurs (prenom, nom)
VALUES 
('Kent', 'Beck'),
('Martin', 'Fowler'),
('Joe', 'Celko'),
('Isidore', 'Ducasse'),
('Sophie', 'Calle'),
('Imgogen', 'Cunningham'),
('Diane', 'Arbus');

TRUNCATE editeurs;
INSERT INTO editeurs(nom)
VALUES ('Hachette'),('Grasset'),('PUF'),('O''Reilly');

TRUNCATE genres;
INSERT INTO genres(genre) 
VALUES ('Informatique') , ('Roman'), ('Essai');

TRUNCATE ouvrages;
INSERT INTO ouvrages (titre, id_auteur, id_genre)
VALUES
('La compétence, essai sur un attracteur étrange', 1, 3),
('Code Complete', 2, 1),
('SQL For Smarties', 3, 1),
('Les misèrables', 5, 2);

TRUNCATE editions;
INSERT INTO editions (id_ouvrage, id_editeur, isbn)
VALUES
(1,1, '000001'),
(1,2, '000002'),
(2,3, '000003'),
(3,4, '000004'),
(3,1, '000005'),
(4,3, '000006');

TRUNCATE exemplaires;
INSERT INTO exemplaires  (id_edition, id_usure, date_achat)
VALUES
(1, 1, '2020-01-10'),
(2, 1, '2020-01-10'),
(3, 1, '2020-01-10'),
(1, 4, '2005-01-10'),
(4, 1, '2020-01-10'),
(5, 2, '2010-01-10'),
(6, 2, '2010-01-10');

TRUNCATE emprunts;
INSERT INTO emprunts (id_client, id_exemplaire, date_emprunt, date_retour)
VALUES
(1,1,'2020-01-10','2020-2-10'),
(1,2,'2006-01-10','2006-02-10'),
(2,3,'2007-01-10',NULL)
;

INSERT INTO auteurs VALUES (SELECT nom, prenom FROM auteurs_temp); --faux

SET FOREIGN_KEY_CHECKS = 1;

LOAD LOCAL DATA INFILE
'E:/Code/SQL/auteurs.csv'
INTO TABLE auteurs_temp
FIELDS
    TERMINATED BY ';'
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\r\n'
IGNORE 1 LINES
(nom, prenom);