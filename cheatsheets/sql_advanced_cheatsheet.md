# 🚀 SQL Avancé - Cheatsheet

## 📦 1. Blocs et Procédures

### Bloc Anonyme
> Un bloc anonyme est un bloc de code PL/SQL qui n'est pas sauvegardé dans la base de données. Il est exécuté une seule fois et oublié. Utile pour les tests ou les opérations ponctuelles.

```sql
DO $$
BEGIN
    -- Code ici
END $$;
```

### Procédure Stockée
> Une procédure stockée est un ensemble d'instructions SQL sauvegardées dans la base de données. Elle peut être appelée plusieurs fois et accepte des paramètres. Ne retourne pas de valeur.

```sql
CREATE OR REPLACE PROCEDURE nom_procedure(param1 TYPE, param2 TYPE)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Code ici
END;
$$;

-- Appel
CALL nom_procedure(val1, val2);
```

### Fonction
> Similaire à une procédure stockée, mais DOIT retourner une valeur. Peut être utilisée dans des requêtes SELECT.

```sql
CREATE OR REPLACE FUNCTION nom_fonction(param1 TYPE)
RETURNS TYPE
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN valeur;
END;
$$;

-- Appel
SELECT nom_fonction(param1);
```

### Types de Paramètres
> Définit comment les paramètres sont utilisés dans les procédures et fonctions :
> - IN : Paramètre en lecture seule (défaut)
> - OUT : Paramètre utilisé pour retourner une valeur
> - INOUT : Paramètre qui peut être lu et modifié

```sql
CREATE PROCEDURE exemple(
    IN param1 TYPE,        -- Entrée seulement
    OUT param2 TYPE,       -- Sortie seulement
    INOUT param3 TYPE     -- Entrée et sortie
)
```

### Gestion d'Erreurs
> Permet de gérer les exceptions et les erreurs qui peuvent survenir pendant l'exécution du code PL/SQL.

```sql
BEGIN
    -- Code
EXCEPTION
    WHEN condition THEN
        -- Gestion erreur
    WHEN others THEN
        -- Gestion erreur par défaut
END;
```

## 🔄 2. Triggers

### Fonction Trigger
> Une fonction spéciale qui sera exécutée automatiquement en réponse à certains événements dans la base de données (INSERT, UPDATE, DELETE).
> - NEW : Contient les nouvelles valeurs lors d'un INSERT/UPDATE
> - OLD : Contient les anciennes valeurs lors d'un UPDATE/DELETE
> - TG_OP : Type d'opération qui a déclenché le trigger

```sql
CREATE FUNCTION nom_trigger_fonction()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- NEW = nouvelle ligne
    -- OLD = ancienne ligne
    -- TG_OP = opération (INSERT/UPDATE/DELETE)
    RETURN NEW;
END;
$$;
```

### Création Trigger
> Définit QUAND et SUR QUOI le trigger doit s'exécuter :
> - BEFORE/AFTER : Avant ou après l'événement
> - FOR EACH ROW : Exécuté pour chaque ligne affectée
> - FOR EACH STATEMENT : Exécuté une fois par requête

```sql
CREATE TRIGGER nom_trigger
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON nom_table
FOR EACH {ROW | STATEMENT}
EXECUTE FUNCTION nom_trigger_fonction();
```

## 👁️ 3. Vues

### Vue Simple
> Une requête SQL sauvegardée comme un objet virtuel. Permet de simplifier des requêtes complexes et de gérer les droits d'accès.

```sql
CREATE VIEW nom_vue AS
SELECT * FROM table
WHERE condition;
```

### Vue Matérialisée
> Similaire à une vue simple, mais les résultats sont stockés physiquement et doivent être rafraîchis manuellement. Utile pour les requêtes complexes fréquemment utilisées.

```sql
CREATE MATERIALIZED VIEW nom_vue AS
SELECT * FROM table
WITH DATA;

REFRESH MATERIALIZED VIEW nom_vue;
```

## 🔢 4. Séquences

### Création et Utilisation
> Générateur automatique de nombres uniques. Utile pour créer des clés primaires ou des identifiants uniques.

```sql
-- Création
CREATE SEQUENCE nom_sequence
    INCREMENT BY 1
    START WITH 1;

-- Utilisation
SELECT nextval('nom_sequence');  -- Prochain numéro
SELECT currval('nom_sequence');  -- Numéro actuel
SELECT setval('nom_sequence', 100);  -- Définir valeur
```

### Types Auto-increment
> Différentes façons de créer des colonnes auto-incrémentées avec leurs limites respectives.

```sql
-- Différents types
id SERIAL         -- 1 à 2147483647
id BIGSERIAL      -- 1 à 9223372036854775807
id INT GENERATED ALWAYS AS IDENTITY
```

## 📊 5. CTE (Common Table Expressions)

### CTE Simple
> Requête temporaire nommée qui peut être référencée dans la requête principale. Améliore la lisibilité et permet de réutiliser des sous-requêtes.

```sql
WITH nom_cte AS (
    SELECT * FROM table
)
SELECT * FROM nom_cte;
```

### CTE Récursive
> CTE qui s'appelle elle-même. Parfaite pour traiter des données hiérarchiques (organigrammes, catégories imbriquées).

```sql
WITH RECURSIVE nom_cte AS (
    -- Requête initiale
    SELECT * FROM table WHERE condition
    UNION ALL
    -- Partie récursive
    SELECT t.* 
    FROM table t
    JOIN nom_cte c ON condition
)
SELECT * FROM nom_cte;
```

## 📈 6. Agrégats Avancés

### ROLLUP
> Génère automatiquement des sous-totaux et un total général. Utile pour les rapports hiérarchiques.

```sql
SELECT col1, col2, SUM(valeur)
FROM table
GROUP BY ROLLUP(col1, col2);
```

### CUBE
> Génère toutes les combinaisons possibles de groupement. Plus complet que ROLLUP mais plus intensif en ressources.

```sql
SELECT col1, col2, SUM(valeur)
FROM table
GROUP BY CUBE(col1, col2);
```

## 🔒 7. Transactions

### Transaction Simple
> Groupe d'opérations qui doivent être exécutées comme une seule unité. Soit toutes réussissent, soit toutes échouent.

```sql
BEGIN;
    -- Instructions SQL
COMMIT;
-- ou ROLLBACK;
```

### Points de Sauvegarde
> Points de contrôle dans une transaction permettant de revenir en arrière partiellement sans annuler toute la transaction.

```sql
BEGIN;
    UPDATE table1 SET col = val;
    SAVEPOINT point1;
    UPDATE table2 SET col = val;
    ROLLBACK TO point1;
COMMIT;
```

### Niveaux d'Isolation
> Définit comment les transactions interagissent entre elles :
> - READ COMMITTED : Voit uniquement les données validées (commit)
> - REPEATABLE READ : Garantit que les données lues ne changent pas pendant la transaction
> - SERIALIZABLE : Le plus strict, évite tous les problèmes de concurrence

```sql
BEGIN TRANSACTION ISOLATION LEVEL {
    READ COMMITTED |      -- Défaut
    REPEATABLE READ |    -- Empêche lectures non répétables
    SERIALIZABLE        -- Plus strict, empêche anomalies
};
```

## 🔍 Astuces Bonus

### Indexation
> Améliore les performances des requêtes en créant des structures de données pour accéder plus rapidement aux enregistrements.

```sql
CREATE INDEX nom_index ON table(colonne);
CREATE UNIQUE INDEX nom_index ON table(colonne);
```

### Partitionnement
> Divise une grande table en plusieurs parties plus petites pour améliorer les performances et faciliter la gestion des données.

```sql
CREATE TABLE table_parent (
    id INT,
    date_col DATE
) PARTITION BY RANGE (date_col);

CREATE TABLE partition_2024 
PARTITION OF table_parent 
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
```

### Optimisation de Requêtes
> Analyse comment PostgreSQL exécute une requête. Utile pour comprendre et optimiser les performances.

```sql
EXPLAIN ANALYZE
SELECT * FROM table WHERE condition;
``` 