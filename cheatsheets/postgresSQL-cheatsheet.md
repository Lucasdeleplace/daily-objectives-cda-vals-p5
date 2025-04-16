===========================================
=== GESTION DU SERVICE POSTGRESQL ===
===========================================
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

===========================================
=== GESTION DES UTILISATEURS ET ROLES ===
===========================================
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

=========================================
=== GESTION DES BASES DE DONNÉES ===
=========================================
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

================================
=== COMMANDES PSQL UTILES ===
================================
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

============================================
=== SAUVEGARDE ET RESTAURATION AVANCÉE ===
============================================
# Formats de sauvegarde disponibles
pg_dump -Fp  # Format texte (défaut)
pg_dump -Fc  # Format personnalisé (compressé)
pg_dump -Fd  # Format directory
pg_dump -Ft  # Format tar

# Sauvegardes complètes
pg_dump -U mon_user ma_base > sauvegarde.sql                    # Sauvegarde basique
pg_dump -U mon_user -Fc ma_base > sauvegarde.dump              # Format compressé
pg_dumpall -U mon_user > toutes_les_bases.sql                  # Toutes les bases
pg_dump -U mon_user --schema-only ma_base > structure.sql      # Structure seule
pg_dump -U mon_user --data-only ma_base > donnees.sql          # Données seules

# Sauvegardes partielles
pg_dump -U mon_user -t ma_table ma_base > table.sql            # Une table
pg_dump -U mon_user -n mon_schema ma_base > schema.sql         # Un schéma
pg_dump -U mon_user --exclude-table=table_excluse ma_base      # Exclure une table

# Restauration
psql -U mon_user -d ma_base < sauvegarde.sql                   # Restaurer format texte
pg_restore -U mon_user -d ma_base sauvegarde.dump              # Restaurer format compressé
pg_restore -U mon_user -t ma_table -d ma_base sauvegarde.dump  # Restaurer une table

==============================================
=== GESTION AVANCÉE DES UTILISATEURS (DCL) ===
==============================================
# Création d'utilisateurs avec options
CREATE USER app_user 
    WITH PASSWORD 'password'
    CREATEDB 
    NOCREATEROLE 
    CONNECTION LIMIT 10
    VALID UNTIL '2024-12-31';

# Modification d'utilisateurs
ALTER USER mon_user WITH CREATEDB;                  # Ajouter droit CREATEDB
ALTER USER mon_user WITH NOCREATEDB;               # Retirer droit CREATEDB
ALTER USER mon_user VALID UNTIL '2024-12-31';      # Définir expiration
ALTER USER mon_user CONNECTION LIMIT 5;            # Limiter connexions

# Suppression sécurisée
REASSIGN OWNED BY ancien_user TO nouveau_user;     # Réassigner objets
DROP OWNED BY ancien_user;                         # Supprimer objets
DROP USER IF EXISTS ancien_user;                   # Supprimer utilisateur

================================
=== GESTION DES DROITS ===
================================
# Droits sur les bases de données
GRANT CONNECT ON DATABASE ma_base TO mon_user;
GRANT CREATE ON DATABASE ma_base TO mon_user;
GRANT TEMPORARY ON DATABASE ma_base TO mon_user;

# Droits sur les schémas
GRANT USAGE ON SCHEMA mon_schema TO mon_user;
GRANT CREATE ON SCHEMA mon_schema TO mon_user;

# Droits sur les tables
GRANT SELECT ON ma_table TO mon_user;                          # Lecture seule
GRANT SELECT, INSERT, UPDATE, DELETE ON ma_table TO mon_user;  # CRUD complet
GRANT ALL PRIVILEGES ON ma_table TO mon_user;                  # Tous les droits
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO mon_user;  # Sur toutes les tables

# Révocation des droits
REVOKE ALL PRIVILEGES ON ma_table FROM mon_user;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM mon_user;

=====================================
=== BONNES PRATIQUES DE SÉCURITÉ ===
=====================================
# Création d'un groupe et utilisateurs applicatifs
CREATE ROLE app_group;
CREATE USER app_reader WITH PASSWORD 'xxx' IN ROLE app_group;
CREATE USER app_writer WITH PASSWORD 'xxx' IN ROLE app_group;

# Configuration des droits minimaux
GRANT CONNECT ON DATABASE app_db TO app_group;
GRANT USAGE ON SCHEMA public TO app_group;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_reader;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO app_writer;

# Audit des droits
\dp ma_table                     # Voir les droits sur une table
\du+                            # Liste détaillée des rôles
SELECT * FROM pg_roles;         # Voir tous les rôles
SELECT * FROM pg_user;          # Voir tous les utilisateurs


================================
=== VARIABLES D'ENVIRONNEMENT ===
================================
export PGUSER=mon_user
export PGPASSWORD=mon_password
export PGDATABASE=ma_base
export PGHOST=localhost
export PGPORT=5432

