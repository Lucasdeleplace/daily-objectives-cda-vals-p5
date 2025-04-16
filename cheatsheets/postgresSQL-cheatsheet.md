-- GESTION DU SERVICE POSTGRESQL
# Démarrer le service
sudo systemctl start postgresql

# Arrêter le service
sudo systemctl stop postgresql

# Redémarrer le service
sudo systemctl restart postgresql

# Vérifier le statut
sudo systemctl status postgresql

# Activer le démarrage automatique
sudo systemctl enable postgresql

# Désactiver le démarrage automatique
sudo systemctl disable postgresql

-- GESTION DES UTILISATEURS ET ROLES
# Se connecter en tant que postgres (super-utilisateur)
sudo -u postgres psql

# Créer un nouvel utilisateur
CREATE USER mon_user WITH PASSWORD 'mon_password';

# Donner les droits superuser
ALTER USER mon_user WITH SUPERUSER;

# Donner le droit de créer des bases
ALTER USER mon_user CREATEDB;

# Changer le mot de passe d'un utilisateur
ALTER USER mon_user WITH PASSWORD 'nouveau_password';

-- GESTION DES BASES DE DONNÉES
# Créer une base de données
CREATE DATABASE ma_base;
# ou via createdb
createdb -U mon_user ma_base

# Supprimer une base de données
DROP DATABASE ma_base;
# ou via dropdb
dropdb -U mon_user ma_base

# Se connecter à une base de données
psql -U mon_user -d ma_base
# ou avec pgcli
pgcli -U mon_user -d ma_base

-- COMMANDES PSQL UTILES
\l          -- Liste toutes les bases de données
\c ma_base  -- Se connecter à une base de données
\dt         -- Liste toutes les tables
\du         -- Liste tous les utilisateurs
\dn         -- Liste tous les schémas
\d ma_table -- Décrit la structure d'une table
\?          -- Aide sur les commandes psql
\q          -- Quitter psql
\i file.sql -- Exécuter un fichier SQL
\x          -- Basculer l'affichage étendu
\timing     -- Activer/désactiver le chronométrage des requêtes

-- GESTION DES FICHIERS DE CONFIGURATION
# Localisation des fichiers de configuration
/etc/postgresql/14/main/postgresql.conf  -- Configuration principale
/etc/postgresql/14/main/pg_hba.conf     -- Configuration authentification

# Recharger la configuration sans redémarrer
sudo pg_ctl reload

-- SAUVEGARDE ET RESTAURATION
# Sauvegarder une base de données
pg_dump -U mon_user ma_base > backup.sql

# Sauvegarder toutes les bases de données
pg_dumpall -U mon_user > backup_complet.sql

# Restaurer une base de données
psql -U mon_user ma_base < backup.sql

-- MAINTENANCE
# Analyser une base de données
ANALYZE ma_table;

# Vider le cache
DISCARD ALL;

# Vacuum (nettoyage et optimisation)
VACUUM;
VACUUM ANALYZE;
VACUUM FULL;

-- SURVEILLANCE ET DIAGNOSTIC
# Voir les connexions actives
SELECT * FROM pg_stat_activity;

# Tuer une connexion
SELECT pg_terminate_backend(pid);

# Voir la taille des bases de données
SELECT pg_size_pretty(pg_database_size('ma_base'));

# Voir la taille des tables
SELECT pg_size_pretty(pg_total_relation_size('ma_table'));

-- VARIABLES D'ENVIRONNEMENT UTILES
export PGUSER=mon_user
export PGPASSWORD=mon_password
export PGDATABASE=ma_base
export PGHOST=localhost
export PGPORT=5432

-- GESTION DES DROITS
# Donner tous les droits sur une table
GRANT ALL PRIVILEGES ON ma_table TO mon_user;

# Donner des droits spécifiques
GRANT SELECT, INSERT, UPDATE ON ma_table TO mon_user;

# Révoquer des droits
REVOKE ALL PRIVILEGES ON ma_table FROM mon_user;

-- GESTION DES SCHÉMAS
# Créer un schéma
CREATE SCHEMA mon_schema;

# Définir le schéma par défaut
SET search_path TO mon_schema, public;

-- EXTENSIONS
# Lister les extensions disponibles
SELECT * FROM pg_available_extensions;

# Installer une extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
