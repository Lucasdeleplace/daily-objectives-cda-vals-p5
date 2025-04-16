# Exercices Pratiques PostgreSQL : Gestion des Utilisateurs et Sécurité

## 1. Configuration Initiale

### 1.1 Création de la Base de Données
```sql
-- Se connecter en tant que postgres
sudo -u postgres psql

-- Créer la base de données
CREATE DATABASE blog_app;
\c blog_app

-- Création des tables
CREATE TABLE articles (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(100) NOT NULL,
    contenu TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    auteur_id INTEGER
);

CREATE TABLE commentaires (
    id SERIAL PRIMARY KEY,
    article_id INTEGER REFERENCES articles(id),
    contenu TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    utilisateur_id INTEGER
);

CREATE TABLE utilisateurs (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE,
    role VARCHAR(20)
);
```

## 2. Gestion des Utilisateurs et Rôles

### 2.1 Création des Rôles
```sql
-- Création des groupes de rôles
CREATE ROLE blog_admins;
CREATE ROLE blog_editors;
CREATE ROLE blog_readers;

-- Création des utilisateurs avec leurs rôles
CREATE USER blog_admin WITH PASSWORD 'admin123' LOGIN;
CREATE USER blog_editor WITH PASSWORD 'editor123' LOGIN;
CREATE USER blog_reader WITH PASSWORD 'reader123' LOGIN;
CREATE USER blog_app WITH PASSWORD 'app123' LOGIN;

-- Attribution des rôles aux utilisateurs
GRANT blog_admins TO blog_admin;
GRANT blog_editors TO blog_editor;
GRANT blog_readers TO blog_reader;
```

### 2.2 Configuration des Droits
```sql
-- Droits pour les administrateurs
GRANT ALL PRIVILEGES ON DATABASE blog_app TO blog_admins;
GRANT ALL PRIVILEGES ON SCHEMA public TO blog_admins;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO blog_admins;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO blog_admins;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO blog_admins;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO blog_admins;

-- Droits pour les éditeurs
GRANT CONNECT ON DATABASE blog_app TO blog_editors;
GRANT USAGE ON SCHEMA public TO blog_editors;
GRANT SELECT, INSERT, UPDATE, DELETE ON articles TO blog_editors;
GRANT SELECT, UPDATE ON articles_id_seq TO blog_editors;
GRANT SELECT ON utilisateurs TO blog_editors;

-- Droits pour les lecteurs
GRANT CONNECT ON DATABASE blog_app TO blog_readers;
GRANT USAGE ON SCHEMA public TO blog_readers;
GRANT SELECT ON articles, commentaires, utilisateurs TO blog_readers;
```

## 3. Configuration de l'Authentification

### 3.1 Configuration du fichier pg_hba.conf
```bash
# Éditer le fichier pg_hba.conf
sudo nano /etc/postgresql/16/main/pg_hba.conf

# Ajouter ou modifier ces lignes
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all            all                                     md5
host    all            all             127.0.0.1/32            md5
host    all            all             ::1/128                 md5

# Redémarrer PostgreSQL
sudo systemctl restart postgresql
```

### 3.2 Configuration du fichier .pgpass
```bash
# Créer le fichier .pgpass
nano ~/.pgpass

# Ajouter ces lignes
localhost:5432:blog_app:blog_reader:reader123
localhost:5432:blog_app:blog_editor:editor123
localhost:5432:blog_app:blog_admin:admin123

# Définir les bonnes permissions
chmod 600 ~/.pgpass
```

## 4. Tests de Sécurité

### 4.1 Test du Compte Lecteur
```sql
-- Connexion
psql -U blog_reader -h localhost -d blog_app

-- Tests de lecture (doivent fonctionner)
SELECT * FROM articles;
SELECT * FROM commentaires;
SELECT * FROM utilisateurs;

-- Tests d'écriture (doivent échouer)
INSERT INTO articles (titre, contenu) VALUES ('Test', 'Test contenu');
UPDATE articles SET titre = 'Modified' WHERE id = 1;
DELETE FROM articles WHERE id = 1;
```

### 4.2 Test du Compte Éditeur
```sql
-- Connexion
psql -U blog_editor -h localhost -d blog_app

-- Tests sur articles (doivent fonctionner)
INSERT INTO articles (titre, contenu) VALUES ('Article test', 'Contenu test');
UPDATE articles SET titre = 'Modifié' WHERE titre = 'Article test';
DELETE FROM articles WHERE titre = 'Modifié';

-- Tests sur utilisateurs (seul SELECT doit fonctionner)
SELECT * FROM utilisateurs;
INSERT INTO utilisateurs (username, email) VALUES ('test', 'test@test.com');
```

### 4.3 Test du Compte Administrateur
```sql
-- Connexion
psql -U blog_admin -h localhost -d blog_app

-- Tests de création/modification de structure
CREATE TABLE test_table (id serial primary key, name text);
INSERT INTO test_table (name) VALUES ('test');
ALTER TABLE test_table ADD COLUMN description text;
DROP TABLE test_table;

-- Tests sur les tables existantes
INSERT INTO articles (titre, contenu) VALUES ('Admin article', 'Contenu admin');
INSERT INTO utilisateurs (username, email) VALUES ('admin_test', 'admin@test.com');
```

## 5. Vérification des Droits

### 5.1 Vérification des Rôles et Privilèges
```sql
-- Se connecter en tant que postgres
sudo -u postgres psql -d blog_app

-- Vérifier les droits sur les tables
SELECT grantee, table_name, privilege_type 
FROM information_schema.role_table_grants 
WHERE table_schema = 'public'
ORDER BY grantee, table_name, privilege_type;

-- Vérifier les rôles et leurs membres
SELECT r.rolname, r.rolsuper, r.rolinherit,
       r.rolcreaterole, r.rolcreatedb, r.rolcanlogin,
       r.rolconnlimit, r.rolvaliduntil,
       ARRAY(SELECT b.rolname
             FROM pg_catalog.pg_auth_members m
             JOIN pg_catalog.pg_roles b ON (m.roleid = b.oid)
             WHERE m.member = r.oid) as memberof
FROM pg_catalog.pg_roles r
WHERE r.rolname NOT LIKE 'pg_%'
ORDER BY 1;
```

### 5.2 Surveillance des Connexions
```sql
-- Vérifier les connexions actives
SELECT usename, application_name, client_addr, 
       backend_start, state, query
FROM pg_stat_activity 
WHERE datname = 'blog_app';
```