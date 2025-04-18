# Exercices Pratiques : Data Manipulation Language (DML) avec PostgreSQL

## 1. Requêtes de Sélection (SELECT)

### 1.1 Structure de Base
```sql
-- SELECT, FROM, WHERE
-- Trouver tous les livres à plus de 25€
SELECT titre, prix
FROM livres
WHERE prix > 25.00;

-- ORDER BY, LIMIT
-- Top 3 des livres les plus chers
SELECT titre, prix
FROM livres
ORDER BY prix DESC
LIMIT 3;

-- GROUP BY, HAVING
-- Nombre de livres par auteur, uniquement ceux avec plus d'un livre
SELECT a.nom, a.prenom, COUNT(*) as nombre_livres
FROM livres l
JOIN auteurs a ON l.auteur_id = a.id
GROUP BY a.id, a.nom, a.prenom
HAVING COUNT(*) > 1;
```

### 1.2 Opérateurs de Comparaison
```sql
-- Égalité et inégalité
SELECT titre, prix
FROM livres
WHERE prix <> 29.99;

-- BETWEEN
SELECT titre, date_publication
FROM livres
WHERE date_publication BETWEEN '1900-01-01' AND '1999-12-31';

-- IN
SELECT titre
FROM livres
WHERE auteur_id IN (
    SELECT id 
    FROM auteurs 
    WHERE nationalite = 'Française'
);

-- LIKE (recherche de motifs)
SELECT titre
FROM livres
WHERE titre LIKE '%Harry%';

-- IS NULL
SELECT titre
FROM livres
WHERE resume IS NULL;
```

### 1.3 Fonctions d'Agrégation
```sql
-- COUNT
SELECT COUNT(*) as total_livres
FROM livres;

-- SUM et AVG
SELECT 
    COUNT(*) as nombre_emprunts,
    AVG(note) as note_moyenne,
    MIN(note) as note_min,
    MAX(note) as note_max
FROM emprunts
WHERE note IS NOT NULL;

-- Statistiques par genre
SELECT 
    g.nom as genre,
    COUNT(*) as nombre_livres,
    AVG(l.prix) as prix_moyen
FROM livres l
JOIN livres_genres lg ON l.id = lg.livre_id
JOIN genres_litteraires g ON lg.genre_id = g.id
GROUP BY g.nom;
```

## 2. Jointures de Tables

### 2.1 Types de Jointures
```sql
-- INNER JOIN
SELECT l.titre, a.nom as auteur, g.nom as genre
FROM livres l
INNER JOIN auteurs a ON l.auteur_id = a.id
INNER JOIN livres_genres lg ON l.id = lg.livre_id
INNER JOIN genres_litteraires g ON lg.genre_id = g.id;

-- LEFT JOIN (trouver les livres sans emprunt)
SELECT l.titre, COUNT(e.id) as nombre_emprunts
FROM livres l
LEFT JOIN emprunts e ON l.id = e.livre_id
GROUP BY l.id, l.titre
HAVING COUNT(e.id) = 0;

-- RIGHT JOIN (membres avec leurs emprunts, même ceux sans emprunt)
SELECT m.nom, m.prenom, l.titre
FROM emprunts e
RIGHT JOIN membres m ON e.membre_id = m.id
LEFT JOIN livres l ON e.livre_id = l.id;
```

### 2.2 Cas d'Usage Complexes
```sql
-- Historique complet d'un livre
SELECT 
    l.titre,
    COUNT(e.id) as nombre_emprunts,
    AVG(e.note) as note_moyenne,
    COUNT(r.id) as nombre_reservations,
    hp.ancien_prix,
    hp.nouveau_prix,
    hp.date_modification
FROM livres l
LEFT JOIN emprunts e ON l.id = e.livre_id
LEFT JOIN reservations r ON l.id = r.livre_id
LEFT JOIN historique_prix hp ON l.id = hp.livre_id
WHERE l.id = 1
GROUP BY l.id, l.titre, hp.ancien_prix, hp.nouveau_prix, hp.date_modification;

-- Analyse des tendances d'emprunt
SELECT 
    g.nom as genre,
    COUNT(e.id) as nombre_emprunts,
    AVG(e.note) as note_moyenne
FROM genres_litteraires g
JOIN livres_genres lg ON g.id = lg.genre_id
JOIN livres l ON lg.livre_id = l.id
LEFT JOIN emprunts e ON l.id = e.livre_id
GROUP BY g.id, g.nom
ORDER BY nombre_emprunts DESC;
```

## 3. Manipulation des Données

### 3.1 Insertion (INSERT)
```sql
-- Insertion simple
INSERT INTO auteurs (nom, prenom, nationalite)
VALUES ('Tolkien', 'J.R.R.', 'Britannique');

-- Insertion multiple
INSERT INTO livres (isbn, titre, prix, auteur_id)
VALUES 
    ('9780123456797', 'Le Hobbit', 24.99, 
        (SELECT id FROM auteurs WHERE nom = 'Tolkien')),
    ('9780123456798', 'Le Seigneur des Anneaux', 29.99,
        (SELECT id FROM auteurs WHERE nom = 'Tolkien'));

-- INSERT INTO SELECT
INSERT INTO genres_litteraires (nom, description)
SELECT DISTINCT 
    'Sous-genre de ' || nom,
    'Dérivé de : ' || description
FROM genres_litteraires
WHERE nom IN ('Fantasy', 'Roman Historique');
```

### 3.2 Modification (UPDATE)
```sql
-- Mise à jour simple
UPDATE livres
SET prix = prix * 1.1
WHERE date_publication < '1900-01-01';

-- Avec conditions WHERE complexes
UPDATE emprunts
SET note = 5
WHERE membre_id IN (
    SELECT id 
    FROM membres 
    WHERE actif = true
) AND note IS NULL;

-- Avec jointures
UPDATE livres l
SET prix = l.prix * 1.05
FROM genres_litteraires g
JOIN livres_genres lg ON g.id = lg.genre_id
WHERE lg.livre_id = l.id
AND g.nom = 'Fantasy';
```

### 3.3 Suppression (DELETE)
```sql
-- Suppression avec condition
DELETE FROM reservations
WHERE statut = 'annulee'
AND date_reservation < CURRENT_DATE - INTERVAL '30 days';

-- Suppression avec jointure
DELETE FROM emprunts
WHERE membre_id IN (
    SELECT id
    FROM membres
    WHERE actif = false
);

-- TRUNCATE (vider une table)
TRUNCATE TABLE historique_prix;
-- Attention : TRUNCATE est plus rapide mais ne peut pas être annulé
```

## 4. Exercices Pratiques Avancés

### 4.1 Requêtes Complexes
```sql
-- Classement des membres par activité
SELECT 
    m.nom,
    m.prenom,
    COUNT(e.id) as nombre_emprunts,
    AVG(e.note) as note_moyenne,
    COUNT(DISTINCT r.id) as nombre_reservations,
    CASE
        WHEN COUNT(e.id) > 5 THEN 'Très actif'
        WHEN COUNT(e.id) > 2 THEN 'Actif'
        ELSE 'Peu actif'
    END as statut_activite
FROM membres m
LEFT JOIN emprunts e ON m.id = e.membre_id
LEFT JOIN reservations r ON m.id = r.membre_id
GROUP BY m.id, m.nom, m.prenom
ORDER BY nombre_emprunts DESC;

-- Analyse des tendances par période
SELECT 
    DATE_TRUNC('month', e.date_emprunt) as mois,
    g.nom as genre,
    COUNT(*) as nombre_emprunts,
    AVG(e.note) as note_moyenne
FROM emprunts e
JOIN livres l ON e.livre_id = l.id
JOIN livres_genres lg ON l.id = lg.livre_id
JOIN genres_litteraires g ON lg.genre_id = g.id
GROUP BY mois, g.nom
ORDER BY mois DESC, nombre_emprunts DESC;
```

### 4.2 Cas Pratiques Métier
```sql
-- Recommandations basées sur les notes
WITH notes_moyennes AS (
    SELECT 
        l.id,
        l.titre,
        g.nom as genre,
        AVG(e.note) as note_moyenne
    FROM livres l
    JOIN livres_genres lg ON l.id = lg.livre_id
    JOIN genres_litteraires g ON lg.genre_id = g.id
    LEFT JOIN emprunts e ON l.id = e.livre_id
    GROUP BY l.id, l.titre, g.nom
)
SELECT 
    n1.titre,
    n1.genre,
    n1.note_moyenne,
    STRING_AGG(n2.titre, ', ') as livres_similaires
FROM notes_moyennes n1
JOIN notes_moyennes n2 ON n1.genre = n2.genre 
    AND n1.id != n2.id 
    AND n2.note_moyenne >= 4
GROUP BY n1.id, n1.titre, n1.genre, n1.note_moyenne
HAVING n1.note_moyenne >= 4
ORDER BY n1.note_moyenne DESC;

-- Rapport d'activité mensuel
SELECT 
    DATE_TRUNC('month', e.date_emprunt) as mois,
    COUNT(DISTINCT e.membre_id) as membres_actifs,
    COUNT(e.id) as total_emprunts,
    COUNT(DISTINCT e.livre_id) as livres_differents,
    AVG(e.note) as note_moyenne,
    COUNT(DISTINCT r.id) as nouvelles_reservations
FROM emprunts e
LEFT JOIN reservations r ON DATE_TRUNC('month', r.date_reservation) = DATE_TRUNC('month', e.date_emprunt)
GROUP BY mois
ORDER BY mois DESC;
```

## 5. Bonnes Pratiques

1. **Sécurité**
   - Toujours utiliser WHERE dans les UPDATE et DELETE
   - Tester les requêtes avec SELECT avant UPDATE/DELETE
   - Utiliser des transactions pour les opérations critiques

2. **Performance**
   - Éviter SELECT *
   - Utiliser des index appropriés
   - Optimiser les jointures
   - Limiter les résultats avec LIMIT

3. **Maintenance**
   - Commenter les requêtes complexes
   - Utiliser des alias explicites
   - Indenter le code SQL
   - Documenter les modifications importantes 