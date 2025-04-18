-- Insertion des données dans SEGMENT
INSERT INTO SEGMENT (N_SEGMENT, NOM_SEGMENT) VALUES
    ('130.120.80', 'segment 80'),
    ('130.120.81', 'segment 81'),
    ('130.120.82', 'segment 82');

-- Insertion des données dans SALLE
INSERT INTO SALLE (N_SALLE, NOM_SALLE, NB_POSTE, N_SEGMENT) VALUES
    ('s01', 'Salle 1', 3, '130.120.80'),
    ('s02', 'Salle 2', 2, '130.120.80'),
    ('s03', 'Salle 3', 2, '130.120.80'),
    ('s11', 'Salle 11', 2, '130.120.81'),
    ('s12', 'Salle 12', 1, '130.120.81'),
    ('s21', 'Salle 21', 2, '130.120.82');

-- Insertion des données dans POSTE
INSERT INTO POSTE (N_POSTE, NOM_POSTE, N_SEGMENT, AD, TYPE_POSTE, N_SALLE) VALUES
    ('p1', 'Poste 1', '130.120.80', '01', 'TX', 's01'),
    ('p2', 'Poste 2', '130.120.80', '02', 'UNIX', 's01'),
    ('p3', 'Poste 3', '130.120.80', '03', 'TX', 's01'),
    ('p4', 'Poste 4', '130.120.80', '04', 'PCWS', 's02'),
    ('p5', 'Poste 5', '130.120.80', '05', 'PCWS', 's02'),
    ('p6', 'Poste 6', '130.120.80', '06', 'UNIX', 's03'),
    ('p7', 'Poste 7', '130.120.80', '07', 'TX', 's03'),
    ('p8', 'Poste 8', '130.120.81', '01', 'UNIX', 's11'),
    ('p9', 'Poste 9', '130.120.81', '02', 'TX', 's11'),
    ('p10', 'Poste 10', '130.120.81', '03', 'UNIX', 's12'),
    ('p11', 'Poste 11', '130.120.82', '01', 'PCXP', 's21'),
    ('p12', 'Poste 12', '130.120.82', '02', 'PCXP', 's21');

-- Insertion des données dans LOGICIEL
INSERT INTO LOGICIEL (N_LOGICIEL, NOM_LOGICIEL, DATE_ACHAT, VERSION, TYPE_LOGICIEL) VALUES
    ('l1', 'Oracle 9i', '2021-05-13', '9.2', 'UNIX'),
    ('l2', 'Oracle 10g', '2020-09-15', '10.1', 'UNIX'),
    ('l3', 'Sql Server', '2022-04-12', '2020SE', 'PCXP'),
    ('l4', '4D', '2020-06-03', '2019.4', 'PCXP'),
    ('l5', 'Windev', '2021-11-12', '10', 'PCWS'),
    ('l6', 'Sql*Net', '2021-05-13', '2.5', 'UNIX'),
    ('l7', 'I. I. S.', '2020-04-12', '6.0', 'PCXP'),
    ('l8', 'Autocad', '2022-03-21', 'AU2019', 'PCWS');

-- Insertion des données dans INSTALLER
INSERT INTO INSTALLER (N_POSTE, N_LOGICIEL, DATE_INS) VALUES
    ('p2', 'l1', '2021-05-15'),
    ('p2', 'l2', '2020-09-17'),
    ('p4', 'l5', '2022-05-30'),
    ('p6', 'l6', '2021-05-20'),
    ('p6', 'l1', '2021-05-20'),
    ('p8', 'l2', '2021-05-19'),
    ('p8', 'l6', '2021-05-20'),
    ('p11', 'l3', '2022-04-20'),
    ('p12', 'l4', '2020-06-20'),
    ('p11', 'l7', '2022-04-20'); 