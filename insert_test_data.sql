-- Vérification et suppression des données existantes
DROP TABLE IF EXISTS historique_prix CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS emprunts CASCADE;
DROP TABLE IF EXISTS livres_genres CASCADE;
DROP TABLE IF EXISTS genres_litteraires CASCADE;
DROP TABLE IF EXISTS livres CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS membres CASCADE;
DROP TABLE IF EXISTS auteurs CASCADE;

-- Création des tables dans le bon ordre
CREATE TABLE auteurs (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50),
    date_naissance DATE,
    nationalite VARCHAR(30)
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    code VARCHAR(10) NOT NULL,
    CONSTRAINT unique_nom_code UNIQUE (nom, code)
);

CREATE TABLE livres (
    id SERIAL PRIMARY KEY,
    isbn VARCHAR(13) UNIQUE,
    titre VARCHAR(100) NOT NULL,
    resume TEXT,
    prix DECIMAL(10,2),
    date_publication DATE,
    en_stock BOOLEAN DEFAULT true,
    derniere_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    auteur_id INTEGER REFERENCES auteurs(id)
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

CREATE TABLE membres (
    id SERIAL PRIMARY KEY,
    numero_membre VARCHAR(10) UNIQUE NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_inscription DATE DEFAULT CURRENT_DATE,
    actif BOOLEAN DEFAULT true
);

CREATE TABLE emprunts (
    id SERIAL PRIMARY KEY,
    livre_id INTEGER REFERENCES livres(id),
    membre_id INTEGER REFERENCES membres(id),
    date_emprunt DATE NOT NULL DEFAULT CURRENT_DATE,
    date_retour DATE,
    note INTEGER CHECK (note BETWEEN 1 AND 5),
    CONSTRAINT date_retour_check CHECK (date_retour >= date_emprunt)
);

CREATE TABLE reservations (
    id SERIAL PRIMARY KEY,
    livre_id INTEGER REFERENCES livres(id),
    membre_id INTEGER REFERENCES membres(id),
    date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut VARCHAR(20) DEFAULT 'en_attente' CHECK (statut IN ('en_attente', 'confirmee', 'annulee', 'terminee'))
);

CREATE TABLE historique_prix (
    id SERIAL PRIMARY KEY,
    livre_id INTEGER REFERENCES livres(id),
    ancien_prix DECIMAL(10,2),
    nouveau_prix DECIMAL(10,2),
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertion des données dans le bon ordre
-- Insertion des auteurs
INSERT INTO auteurs (nom, prenom, date_naissance, nationalite) VALUES
    ('Hugo', 'Victor', '1802-02-26', 'Française'),
    ('Camus', 'Albert', '1913-11-07', 'Française'),
    ('Rowling', 'J.K.', '1965-07-31', 'Britannique'),
    ('Garcia Marquez', 'Gabriel', '1927-03-06', 'Colombienne'),
    ('Murakami', 'Haruki', '1949-01-12', 'Japonaise');

-- Insertion des catégories
INSERT INTO categories (nom, code) VALUES
    ('Roman Classique', 'ROM-CL'),
    ('Science Fiction', 'SF'),
    ('Fantaisie', 'FAN'),
    ('Philosophie', 'PHIL'),
    ('Réalisme Magique', 'RM');

-- Insertion des livres
INSERT INTO livres (isbn, titre, resume, prix, date_publication, en_stock, auteur_id) VALUES
    ('9780123456789', 'Les Misérables', 'L''histoire de Jean Valjean', 24.99, '1862-01-01', true, 1),
    ('9780123456790', 'Notre-Dame de Paris', 'L''histoire de Quasimodo', 22.99, '1831-01-01', true, 1),
    ('9780123456791', 'L''Étranger', 'L''histoire de Meursault', 19.99, '1942-01-01', true, 2),
    ('9780123456792', 'La Peste', 'Une épidémie à Oran', 21.99, '1947-01-01', true, 2),
    ('9780123456793', 'Harry Potter 1', 'L''école des sorciers', 29.99, '1997-06-26', true, 3),
    ('9780123456794', 'Harry Potter 2', 'La chambre des secrets', 29.99, '1998-07-02', true, 3),
    ('9780123456795', 'Cent ans de solitude', 'L''histoire des Buendía', 23.99, '1967-05-30', true, 4),
    ('9780123456796', '1Q84', 'Un monde parallèle', 27.99, '2009-05-29', true, 5);

-- Insertion des genres littéraires
INSERT INTO genres_litteraires (nom, description) VALUES
    ('Roman Historique', 'Romans basés sur des événements historiques'),
    ('Fantasy', 'Univers magiques et créatures fantastiques'),
    ('Philosophique', 'Exploration de questions existentielles'),
    ('Réalisme Magique', 'Mélange de réalité et de fantastique'),
    ('Aventure', 'Récits d''aventures et de découvertes');

-- Association livres-genres
INSERT INTO livres_genres (livre_id, genre_id) VALUES
    (1, 1), -- Les Misérables - Roman Historique
    (1, 3), -- Les Misérables - Philosophique
    (2, 1), -- Notre-Dame de Paris - Roman Historique
    (3, 3), -- L'Étranger - Philosophique
    (4, 3), -- La Peste - Philosophique
    (5, 2), -- Harry Potter 1 - Fantasy
    (6, 2), -- Harry Potter 2 - Fantasy
    (7, 4), -- Cent ans de solitude - Réalisme Magique
    (8, 4); -- 1Q84 - Réalisme Magique

-- Insertion des membres
INSERT INTO membres (numero_membre, nom, prenom, email, actif) VALUES
    ('M001', 'Dupont', 'Jean', 'jean.dupont@email.com', true),
    ('M002', 'Martin', 'Sophie', 'sophie.martin@email.com', true),
    ('M003', 'Bernard', 'Marie', 'marie.bernard@email.com', true),
    ('M004', 'Petit', 'Pierre', 'pierre.petit@email.com', false),
    ('M005', 'Robert', 'Lucie', 'lucie.robert@email.com', true);

-- Insertion des emprunts
INSERT INTO emprunts (livre_id, membre_id, date_emprunt, date_retour, note) VALUES
    (1, 1, CURRENT_DATE - 20, CURRENT_DATE - 5, 5),
    (3, 1, CURRENT_DATE - 10, NULL, NULL),
    (5, 2, CURRENT_DATE - 15, CURRENT_DATE - 2, 4),
    (6, 2, CURRENT_DATE - 5, NULL, NULL),
    (7, 3, CURRENT_DATE - 30, CURRENT_DATE - 10, 5),
    (8, 4, CURRENT_DATE - 25, CURRENT_DATE - 5, 3);

-- Insertion des réservations
INSERT INTO reservations (livre_id, membre_id, statut) VALUES
    (2, 3, 'en_attente'),
    (4, 2, 'confirmee'),
    (5, 5, 'en_attente'),
    (7, 1, 'annulee');

-- Insertion historique des prix
INSERT INTO historique_prix (livre_id, ancien_prix, nouveau_prix, date_modification) VALUES
    (1, 22.99, 24.99, CURRENT_TIMESTAMP - INTERVAL '6 months'),
    (3, 17.99, 19.99, CURRENT_TIMESTAMP - INTERVAL '3 months'),
    (5, 27.99, 29.99, CURRENT_TIMESTAMP - INTERVAL '1 month'),
    (7, 21.99, 23.99, CURRENT_TIMESTAMP - INTERVAL '2 months');

-- Requêtes de test pour vérifier les données

-- 1. Livres avec leurs auteurs
SELECT l.titre, a.nom || ' ' || a.prenom as auteur
FROM livres l
JOIN auteurs a ON l.auteur_id = a.id;

-- 2. Livres par genre
SELECT g.nom as genre, l.titre
FROM livres l
JOIN livres_genres lg ON l.id = lg.livre_id
JOIN genres_litteraires g ON lg.genre_id = g.id
ORDER BY g.nom, l.titre;

-- 3. Emprunts en cours avec détails
SELECT m.nom, m.prenom, l.titre, e.date_emprunt
FROM emprunts e
JOIN membres m ON e.membre_id = m.id
JOIN livres l ON e.livre_id = l.id
WHERE e.date_retour IS NULL;

-- 4. Historique des notes
SELECT l.titre, e.note, m.nom as membre
FROM emprunts e
JOIN livres l ON e.livre_id = l.id
JOIN membres m ON e.membre_id = m.id
WHERE e.note IS NOT NULL
ORDER BY e.note DESC; 