# Exercices Guidés : Data Definition Language (DDL) avec PostgreSQL

## Objectif
Créer une base de données pour une bibliothèque en ligne en utilisant les différentes commandes DDL de PostgreSQL.

## 1. Création et Gestion des Bases de Données

### 1.1 Création de la Base de Données
```sql
-- Se connecter en tant que shivii (compte admin)
psql -U shivii

-- Créer la base de données avec les bons paramètres
CREATE DATABASE bibliotheque
    WITH 
    OWNER = shivii
    ENCODING = 'UTF8'
    LC_COLLATE = 'fr_FR.UTF-8'
    LC_CTYPE = 'fr_FR.UTF-8'
    TEMPLATE = template0;

-- Vérifier la création
\l
```

### 1.2 Suppression (à utiliser avec précaution)
```sql
-- Supprimer une base de données (exemple avec une base de test)
CREATE DATABASE db_test;
DROP DATABASE IF EXISTS db_test;
```

## 2. Création et Modification de Tables

### 2.1 Types de Données de Base
```sql
-- Se connecter à la base bibliothèque
\c bibliotheque

-- Création d'une table livres avec différents types de données
CREATE TABLE livres (
    id INTEGER PRIMARY KEY,
    isbn VARCHAR(13) UNIQUE,
    titre VARCHAR(100) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2),
    date_publication DATE,
    en_stock BOOLEAN DEFAULT true,
    derniere_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Création d'une table auteurs
CREATE TABLE auteurs (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50),
    date_naissance DATE,
    nationalite VARCHAR(30)
);
```

### 2.2 Modification de Tables
```sql
-- Ajouter une colonne
ALTER TABLE livres ADD COLUMN nombre_pages INTEGER;

-- Modifier une colonne
ALTER TABLE livres ALTER COLUMN titre TYPE VARCHAR(150);

-- Renommer une colonne
ALTER TABLE livres RENAME COLUMN description TO resume;

-- Supprimer une colonne
ALTER TABLE livres DROP COLUMN IF EXISTS nombre_pages;
```

## 3. Gestion des Contraintes

### 3.1 Clés Primaires et Étrangères
```sql
-- Création d'une table avec relations
CREATE TABLE emprunts (
    id SERIAL PRIMARY KEY,
    livre_id INTEGER REFERENCES livres(id) ON DELETE CASCADE,
    date_emprunt DATE NOT NULL DEFAULT CURRENT_DATE,
    date_retour DATE,
    CONSTRAINT date_retour_check CHECK (date_retour >= date_emprunt)
);

-- Ajout d'une contrainte de clé étrangère après création
ALTER TABLE livres 
ADD COLUMN auteur_id INTEGER,
ADD CONSTRAINT fk_auteur 
    FOREIGN KEY (auteur_id) 
    REFERENCES auteurs(id) 
    ON UPDATE CASCADE;
```

### 3.2 Autres Contraintes
```sql
-- Contrainte UNIQUE composée
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    code VARCHAR(10) NOT NULL,
    CONSTRAINT unique_nom_code UNIQUE (nom, code)
);

-- Contrainte CHECK
ALTER TABLE livres
ADD CONSTRAINT prix_positif CHECK (prix >= 0);

-- Contrainte NOT NULL
ALTER TABLE auteurs
ALTER COLUMN nationalite SET NOT NULL;

-- Valeur par défaut
ALTER TABLE livres
ALTER COLUMN date_publication SET DEFAULT CURRENT_DATE;
```

## 4. Gestion des Index

### 4.1 Création d'Index Simples
```sql
-- Index pour la recherche par ISBN
CREATE INDEX idx_livres_isbn ON livres(isbn);

-- Index pour la recherche par titre
CREATE INDEX idx_livres_titre ON livres(titre);

-- Index pour les dates d'emprunt
CREATE INDEX idx_emprunts_dates ON emprunts(date_emprunt, date_retour);
```

## 5. Exercice Pratique Complet

### 5.1 Création d'un Système de Gestion de Bibliothèque
```sql
-- 1. Création des tables principales
CREATE TABLE membres (
    id SERIAL PRIMARY KEY,
    numero_membre VARCHAR(10) UNIQUE NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_inscription DATE DEFAULT CURRENT_DATE,
    actif BOOLEAN DEFAULT true
);

CREATE TABLE genres_litteraires (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(30) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE livres_genres (
    livre_id INTEGER REFERENCES livres(id),
    genre_id INTEGER REFERENCES genres_litteraires(id),
    PRIMARY KEY (livre_id, genre_id)
);

-- 2. Ajout des contraintes métier
ALTER TABLE emprunts
ADD CONSTRAINT max_duree_emprunt 
    CHECK (date_retour <= date_emprunt + INTERVAL '30 days');

ALTER TABLE membres
ADD CONSTRAINT email_format 
    CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

-- 3. Création des index pour les recherches fréquentes
CREATE INDEX idx_membres_nom_prenom ON membres(nom, prenom);
CREATE INDEX idx_livres_titre_isbn ON livres(titre, isbn);
CREATE INDEX idx_emprunts_membre_date ON emprunts(membre_id, date_emprunt);
```

### 5.2 Modification de la Structure Existante
```sql
-- 1. Ajout d'un système de notation
ALTER TABLE emprunts
ADD COLUMN note INTEGER,
ADD CONSTRAINT note_valide CHECK (note BETWEEN 1 AND 5);

-- 2. Système de réservation
CREATE TABLE reservations (
    id SERIAL PRIMARY KEY,
    livre_id INTEGER REFERENCES livres(id),
    membre_id INTEGER REFERENCES membres(id),
    date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut VARCHAR(20) DEFAULT 'en_attente',
    CONSTRAINT statut_valide 
        CHECK (statut IN ('en_attente', 'confirmee', 'annulee', 'terminee'))
);

-- 3. Historique des prix
CREATE TABLE historique_prix (
    id SERIAL PRIMARY KEY,
    livre_id INTEGER REFERENCES livres(id),
    ancien_prix DECIMAL(10,2),
    nouveau_prix DECIMAL(10,2),
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 6. Vérification et Maintenance

### 6.1 Vérification de la Structure
```sql
-- Lister toutes les tables
\dt

-- Décrire une table spécifique
\d livres

-- Lister les contraintes
SELECT 
    tc.constraint_name, tc.constraint_type, 
    tc.table_name, kcu.column_name
FROM 
    information_schema.table_constraints tc
    JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
WHERE 
    tc.table_schema = 'public'
ORDER BY 
    tc.table_name, tc.constraint_name;

-- Lister les index
SELECT
    tablename,
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    schemaname = 'public'
ORDER BY
    tablename,
    indexname;
```

## 7. Bonnes Pratiques à Suivre

1. **Nommage**
   - Utiliser des noms explicites et cohérents
   - Éviter les majuscules et les caractères spéciaux
   - Préfixer les contraintes et index de manière cohérente

2. **Contraintes**
   - Toujours nommer explicitement les contraintes
   - Utiliser ON DELETE/UPDATE avec précaution
   - Implémenter les contraintes métier via CHECK

3. **Index**
   - Créer des index uniquement sur les colonnes fréquemment recherchées
   - Éviter la sur-indexation
   - Surveiller la taille et les performances des index

4. **Types de Données**
   - Choisir le type le plus approprié et le plus petit possible
   - Utiliser TEXT plutôt que VARCHAR sans limite
   - Préférer TIMESTAMP à DATE quand la précision est nécessaire

5. **Modifications**
   - Planifier les modifications pendant les périodes creuses
   - Faire des sauvegardes avant les modifications importantes
   - Tester les modifications sur un environnement de développement 