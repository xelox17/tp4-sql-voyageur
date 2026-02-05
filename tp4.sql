
-- 1) Afficher tous les voyageurs.
SELECT *
FROM Voyageur;

-- 2) Afficher le nom et la région de tous les voyageurs vivant en Corse.
SELECT nom, region
FROM Voyageur
WHERE region = 'Corse';

-- 3) Afficher les logements situés dans les Alpes.
SELECT *
FROM Logement
WHERE lieu = 'Alpes';

-- 4) Afficher le nom (code) et le type des logements ayant une capacité > 30.
SELECT codeLogement, type
FROM Logement
WHERE capacite > 30;

-- 5) Afficher les logements dont le type est Hôtel ou Gîte.
SELECT *
FROM Logement
WHERE type IN ('Hôtel', 'Gîte');

-- 6) Afficher les voyageurs dont la région n’est pas Bretagne.
SELECT *
FROM Voyageur
WHERE region <> 'Bretagne';

-- 7) Afficher les séjours commençant avant le jour 20.
SELECT *
FROM Sejour
WHERE debut < 20;

-- 8) Afficher les activités dont la description contient le mot "dériveur".
SELECT *
FROM Activite
WHERE description LIKE '%dériveur%';

-- 9) Afficher les voyageurs triés par nom alphabétique.
SELECT *
FROM Voyageur
ORDER BY nom ASC;

-- 10) Afficher les logements triés par capacité décroissante.
SELECT *
FROM Logement
ORDER BY capacite DESC;

-- 11) Afficher les 2 logements ayant la plus grande capacité.
SELECT *
FROM Logement
ORDER BY capacite DESC
LIMIT 2;


-- 12) Afficher les voyageurs habitant Corse ou Bretagne.
SELECT *
FROM Voyageur
WHERE region IN ('Corse', 'Bretagne');

-- 13) Afficher les logements situés en Corse et de type Gîte.
SELECT *
FROM Logement
WHERE lieu = 'Corse'
  AND type = 'Gîte';

-- 14) Afficher les logements non situés en Alpes.
SELECT *
FROM Logement
WHERE lieu <> 'Alpes';

-- 15) Afficher les séjours ayant un début > 15 et une fin < 23.
SELECT *
FROM Sejour
WHERE debut > 15
  AND fin < 23;



-- 16) Nom des voyageurs + nom (code) du logement de chacun de leurs séjours.
SELECT v.nom, v.prenom, s.codeLogement
FROM Voyageur v
JOIN Sejour s ON v.idVoyageur = s.idVoyageur;

-- 17) Voyageurs ayant séjourné en Corse.
SELECT DISTINCT v.*
FROM Voyageur v
JOIN Sejour s   ON v.idVoyageur = s.idVoyageur
JOIN Logement l ON l.codeLogement = s.codeLogement
WHERE l.lieu = 'Corse';

-- 18) Voyageurs ayant séjourné dans les Alpes.
SELECT DISTINCT v.*
FROM Voyageur v
JOIN Sejour s   ON v.idVoyageur = s.idVoyageur
JOIN Logement l ON l.codeLogement = s.codeLogement
WHERE l.lieu = 'Alpes';

-- 19) Type et lieu des logements visités par Nicolas Bouvier.
SELECT DISTINCT l.type, l.lieu
FROM Voyageur v
JOIN Sejour s   ON v.idVoyageur = s.idVoyageur
JOIN Logement l ON l.codeLogement = s.codeLogement
WHERE v.prenom = 'Nicolas'
  AND v.nom = 'Bouvier';

-- 20) Activités proposées dans les logements où Phileas Fogg a séjourné.
SELECT DISTINCT a.*
FROM Voyageur v
JOIN Sejour s    ON v.idVoyageur = s.idVoyageur
JOIN Propose p   ON p.codeLogement = s.codeLogement
JOIN Activite a  ON a.idActivite = p.idActivite
WHERE v.prenom = 'Phileas'
  AND v.nom = 'Fogg';

-- 21) Séjours avec nom du voyageur + lieu du logement associé.
SELECT s.*, v.nom, v.prenom, l.lieu
FROM Sejour s
JOIN Voyageur v ON v.idVoyageur = s.idVoyageur
JOIN Logement l ON l.codeLogement = s.codeLogement;

-- 22) Nom des voyageurs ayant effectué au moins un séjour + identifiant du séjour.
SELECT v.nom, v.prenom, s.idSejour
FROM Voyageur v
JOIN Sejour s ON v.idVoyageur = s.idVoyageur;

-- 23) Nom voyageurs + nom (code) logements uniquement pour les séjours existants (INNER JOIN).
SELECT v.nom, v.prenom, l.codeLogement
FROM Voyageur v
JOIN Sejour s   ON v.idVoyageur = s.idVoyageur
JOIN Logement l ON l.codeLogement = s.codeLogement;

-- 24) Tous les voyageurs + leurs séjours s’ils existent (LEFT JOIN).
SELECT v.*, s.*
FROM Voyageur v
LEFT JOIN Sejour s ON v.idVoyageur = s.idVoyageur;

-- 25) Voyageurs n’ayant effectué aucun séjour.
SELECT v.*
FROM Voyageur v
LEFT JOIN Sejour s ON v.idVoyageur = s.idVoyageur
WHERE s.idSejour IS NULL;

-- 26) Tous les logements + activités proposées si elles existent.
SELECT l.*, a.*
FROM Logement l
LEFT JOIN Propose p  ON p.codeLogement = l.codeLogement
LEFT JOIN Activite a ON a.idActivite = p.idActivite;

-- 27) Tous les séjours, même si le logement associé n’existe pas.
SELECT s.*, l.*
FROM Sejour s
LEFT JOIN Logement l ON l.codeLogement = s.codeLogement;

-- 28) Tous les voyageurs et tous les séjours, y compris ceux sans correspondance.
-- Version standard (PostgreSQL / SQL Server / Oracle) :
SELECT v.*, s.*
FROM Voyageur v
FULL OUTER JOIN Sejour s ON v.idVoyageur = s.idVoyageur;


-- 29) Logements qui ne proposent aucune activité.
SELECT l.*
FROM Logement l
LEFT JOIN Propose p ON p.codeLogement = l.codeLogement
WHERE p.idActivite IS NULL;

-- 30) Voyageurs qui n’ont jamais séjourné dans aucun logement.
-- (équivalent à "aucun séjour")
SELECT v.*
FROM Voyageur v
LEFT JOIN Sejour s ON s.idVoyageur = v.idVoyageur
WHERE s.idSejour IS NULL;



-- 31) Voyageurs ayant fait un séjour dans un logement capacité > 30.
SELECT DISTINCT v.*
FROM Voyageur v
JOIN Sejour s   ON s.idVoyageur = v.idVoyageur
JOIN Logement l ON l.codeLogement = s.codeLogement
WHERE l.capacite > 30;

-- 32) Logements qui n’ont aucune activité.
SELECT l.*
FROM Logement l
LEFT JOIN Propose p ON p.codeLogement = l.codeLogement
WHERE p.idActivite IS NULL;

-- 33) Voyageurs n’ayant jamais séjourné dans un hôtel.
SELECT v.*
FROM Voyageur v
WHERE NOT EXISTS (
  SELECT 1
  FROM Sejour s
  JOIN Logement l ON l.codeLogement = s.codeLogement
  WHERE s.idVoyageur = v.idVoyageur
    AND l.type = 'Hôtel'
);

-- 34) Logements où plusieurs voyageurs différents ont séjourné.
SELECT l.codeLogement
FROM Logement l
JOIN Sejour s ON s.codeLogement = l.codeLogement
GROUP BY l.codeLogement
HAVING COUNT(DISTINCT s.idVoyageur) >= 2;


-- 35) Compter le nombre total de voyageurs.
SELECT COUNT(*) AS nbVoyageurs
FROM Voyageur;

-- 36) Compter le nombre de logements par type.
SELECT type, COUNT(*) AS nbLogements
FROM Logement
GROUP BY type;

-- 37) Compter le nombre de séjours effectués par chaque voyageur.
SELECT v.idVoyageur, v.nom, v.prenom, COUNT(s.idSejour) AS nbSejours
FROM Voyageur v
LEFT JOIN Sejour s ON s.idVoyageur = v.idVoyageur
GROUP BY v.idVoyageur, v.nom, v.prenom;

-- 38) Afficher le nombre d’activités proposées par chaque logement.
SELECT l.codeLogement, COUNT(p.idActivite) AS nbActivites
FROM Logement l
LEFT JOIN Propose p ON p.codeLogement = l.codeLogement
GROUP BY l.codeLogement;

-- 39) Afficher la capacité moyenne des logements.
SELECT AVG(capacite) AS capaciteMoyenne
FROM Logement;

-- 40) Trouver le logement ayant la capacité maximale.
SELECT *
FROM Logement
WHERE capacite = (SELECT MAX(capacite) FROM Logement);

-- 41) Afficher les voyageurs ayant fait au moins 2 séjours.
SELECT v.idVoyageur, v.nom, v.prenom
FROM Voyageur v
JOIN Sejour s ON s.idVoyageur = v.idVoyageur
GROUP BY v.idVoyageur, v.nom, v.prenom
HAVING COUNT(*) >= 2;

-- 42) Compter combien de séjours ont eu lieu en Corse.
SELECT COUNT(*) AS nbSejoursCorse
FROM Sejour s
JOIN Logement l ON l.codeLogement = s.codeLogement
WHERE l.lieu = 'Corse';


-- 43) Voyageurs ayant fait un séjour dans les Alpes (EXISTS).
SELECT v.*
FROM Voyageur v
WHERE EXISTS (
  SELECT 1
  FROM Sejour s
  JOIN Logement l ON l.codeLogement = s.codeLogement
  WHERE s.idVoyageur = v.idVoyageur
    AND l.lieu = 'Alpes'
);

-- 44) Voyageurs n’ayant jamais fait de séjour en Corse (NOT EXISTS).
SELECT v.*
FROM Voyageur v
WHERE NOT EXISTS (
  SELECT 1
  FROM Sejour s
  JOIN Logement l ON l.codeLogement = s.codeLogement
  WHERE s.idVoyageur = v.idVoyageur
    AND l.lieu = 'Corse'
);

-- 45) Logements où ont séjourné des voyageurs de la même région que le logement (IN).
SELECT *
FROM Logement l
WHERE l.codeLogement IN (
  SELECT s.codeLogement
  FROM Sejour s
  JOIN Voyageur v ON v.idVoyageur = s.idVoyageur
  WHERE v.region = l.lieu
);

-- 46) Logements qui n’ont pas d’activités (NOT IN).
SELECT *
FROM Logement
WHERE codeLogement NOT IN (
  SELECT codeLogement
  FROM Propose
);

-- 47) Voyageurs dont le nombre de séjours est supérieur à la moyenne.
-- (comparaison à la moyenne des counts par voyageur)
SELECT v.*
FROM Voyageur v
JOIN Sejour s ON s.idVoyageur = v.idVoyageur
GROUP BY v.idVoyageur, v.nom, v.prenom, v.ville, v.region
HAVING COUNT(*) > (
  SELECT AVG(nb)
  FROM (
    SELECT COUNT(*) AS nb
    FROM Sejour
    GROUP BY idVoyageur
  ) t
);


-- 48) Régions des voyageurs OU lieux de logement (UNION).
SELECT region AS zone FROM Voyageur
UNION
SELECT lieu AS zone FROM Logement;

-- 49) Régions communes voyageurs et lieux logement (INTERSECT).
SELECT region FROM Voyageur
INTERSECT
SELECT lieu FROM Logement;

-- 50) Régions présentes chez voyageurs mais absentes des lieux logement (EXCEPT/MINUS).
-- PostgreSQL / SQLite / SQL Server :
SELECT region FROM Voyageur
EXCEPT
SELECT lieu FROM Logement;


-- 51) Voyageurs + nombre total de jours passés en séjour (fin - debut).
SELECT v.idVoyageur, v.nom, v.prenom,
       COALESCE(SUM(s.fin - s.debut), 0) AS totalJours
FROM Voyageur v
LEFT JOIN Sejour s ON s.idVoyageur = v.idVoyageur
GROUP BY v.idVoyageur, v.nom, v.prenom;

-- 52) Voyageurs avec les activités qu’ils ont pu pratiquer
-- (Voyageur → Sejour → Logement → Propose → Activite)
SELECT DISTINCT v.nom, v.prenom, a.description
FROM Voyageur v
JOIN Sejour s   ON s.idVoyageur = v.idVoyageur
JOIN Propose p  ON p.codeLogement = s.codeLogement
JOIN Activite a ON a.idActivite = p.idActivite;

-- 53) Logements ayant toutes les activités disponibles dans la base.
SELECT l.codeLogement
FROM Logement l
JOIN Propose p ON p.codeLogement = l.codeLogement
GROUP BY l.codeLogement
HAVING COUNT(DISTINCT p.idActivite) = (SELECT COUNT(*) FROM Activite);

-- 54) Voyageurs qui ont séjourné dans toutes les régions existantes.
SELECT v.idVoyageur, v.nom, v.prenom
FROM Voyageur v
JOIN Sejour s   ON s.idVoyageur = v.idVoyageur
JOIN Logement l ON l.codeLogement = s.codeLogement
GROUP BY v.idVoyageur, v.nom, v.prenom
HAVING COUNT(DISTINCT l.lieu) = (SELECT COUNT(DISTINCT lieu) FROM Logement);
