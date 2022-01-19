CREATE OR REPLACE VIEW vue_exemplaires AS
SELECT 
    ex.id, eu.usure as etat,
    ex.id_edition , ed.isbn, e.nom as editeur,
    o.titre,
    CONCAT_WS(' ', a.prenom, a.nom) as auteur,
    g.genre,
    o.id as id_ouvrage
FROM exemplaires as ex
JOIN etats_usure as eu ON eu.id = ex.id_usure
JOIN editions as ed ON ed.id = ex.id_edition
JOIN editeurs as e ON e.id = ed.id_editeur
JOIN ouvrages as o ON o.id = ed.id_ouvrage
JOIN auteurs as a ON a.id = o.id_auteur
JOIN genres as g ON g.id = o.id_genre;

CREATE OR REPLACE VIEW vue_emprunts AS
SELECT e.id_exemplaire, e.date_emprunt, vex.titre FROM emprunts as e
JOIN vue_exemplaires as vex ON vex.id = e.id_exemplaire
WHERE date_retour is null;


-- Les livres disponibles
SELECT * FROM vue_exemplaires WHERE id_ouvrage=1 AND id NOT IN (SELECT id_exemplaire FROM vue_emprunts);

SELECT * FROM vue_exemplaires
LEFT JOIN vue_emprunts ON vue_emprunts.id_exemplaire = vue_exemplaires.id
WHERE vue_exemplaires.id_ouvrage=1
AND vue_emprunts.id_exemplaire is null;

-- les emprunts en retard
-- plus de 15 jours au delà de la date d'emprunt

SELECT *, datediff( NOW(), DATE_ADD(date_emprunt, INTERVAL 15 DAY)) as retard 
FROM vue_emprunts as vem 
WHERE NOW() >  DATE_ADD(date_emprunt, INTERVAL 15 DAY);

