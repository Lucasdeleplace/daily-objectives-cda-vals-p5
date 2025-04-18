-- Création de la table SEGMENT
CREATE TABLE SEGMENT (
    N_SEGMENT VARCHAR(10) PRIMARY KEY,
    NOM_SEGMENT VARCHAR(20) NOT NULL
);

-- Création de la table SALLE
CREATE TABLE SALLE (
    N_SALLE VARCHAR(7) PRIMARY KEY,
    NOM_SALLE VARCHAR(20) NOT NULL,
    NB_POSTE INTEGER CHECK (NB_POSTE > 0),
    N_SEGMENT VARCHAR(10) REFERENCES SEGMENT(N_SEGMENT)
);

-- Création de la table LOGICIEL
CREATE TABLE LOGICIEL (
    N_LOGICIEL VARCHAR(7) PRIMARY KEY,
    NOM_LOGICIEL VARCHAR(20) NOT NULL,
    DATE_ACHAT DATE,
    VERSION VARCHAR(7),
    TYPE_LOGICIEL VARCHAR(20)
);

-- Création de la table POSTE
CREATE TABLE POSTE (
    N_POSTE VARCHAR(7) PRIMARY KEY,
    NOM_POSTE VARCHAR(20) NOT NULL,
    N_SEGMENT VARCHAR(10) REFERENCES SEGMENT(N_SEGMENT),
    AD VARCHAR(2),
    TYPE_POSTE VARCHAR(20),
    N_SALLE VARCHAR(7) REFERENCES SALLE(N_SALLE)
);

-- Création de la table INSTALLER (table de liaison)
CREATE TABLE INSTALLER (
    N_POSTE VARCHAR(7) REFERENCES POSTE(N_POSTE),
    N_LOGICIEL VARCHAR(7) REFERENCES LOGICIEL(N_LOGICIEL),
    DATE_INS DATE,
    PRIMARY KEY (N_POSTE, N_LOGICIEL)
);

-- Ajout d'index pour optimiser les performances
CREATE INDEX idx_salle_segment ON SALLE(N_SEGMENT);
CREATE INDEX idx_poste_segment ON POSTE(N_SEGMENT);
CREATE INDEX idx_poste_salle ON POSTE(N_SALLE);
CREATE INDEX idx_installer_logiciel ON INSTALLER(N_LOGICIEL);
CREATE INDEX idx_installer_poste ON INSTALLER(N_POSTE);

-- Commentaires sur les tables et colonnes
COMMENT ON TABLE SEGMENT IS 'Table des segments réseau';
COMMENT ON TABLE SALLE IS 'Table des salles informatiques';
COMMENT ON TABLE POSTE IS 'Table des postes de travail';
COMMENT ON TABLE LOGICIEL IS 'Table des logiciels';
COMMENT ON TABLE INSTALLER IS 'Table de liaison entre postes et logiciels';

-- Commentaires sur les colonnes importantes
COMMENT ON COLUMN SEGMENT.N_SEGMENT IS '3 premiers groupes IP (ex : 127.0.0)';
COMMENT ON COLUMN POSTE.AD IS 'Dernier groupe de chiffre IP';
COMMENT ON COLUMN SALLE.NB_POSTE IS 'Nombre de postes de travail dans la salle';
COMMENT ON COLUMN LOGICIEL.VERSION IS 'Version du logiciel (ex : 8.0)';
COMMENT ON COLUMN INSTALLER.DATE_INS IS 'Date d''installation du logiciel sur le poste';

-- Contraintes supplémentaires pour la cohérence des données
ALTER TABLE POSTE ADD CONSTRAINT valid_ad CHECK (AD ~ '^[0-9]{1,2}$');
ALTER TABLE SALLE ADD CONSTRAINT valid_n_salle CHECK (N_SALLE ~ '^s[0-9]{2}$');
ALTER TABLE POSTE ADD CONSTRAINT valid_n_poste CHECK (N_POSTE ~ '^p[0-9]+$');
ALTER TABLE LOGICIEL ADD CONSTRAINT valid_n_logiciel CHECK (N_LOGICIEL ~ '^l[0-9]+$'); 