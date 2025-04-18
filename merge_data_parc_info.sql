-- MERGE pour SEGMENT
MERGE INTO SEGMENT s
USING (VALUES
    ('130.120.80', 'segment 80'),
    ('130.120.81', 'segment 81'),
    ('130.120.82', 'segment 82')
) AS source(n_segment, nom_segment)
ON (s.n_segment = source.n_segment)
WHEN MATCHED THEN
    UPDATE SET nom_segment = source.nom_segment
WHEN NOT MATCHED THEN
    INSERT (n_segment, nom_segment)
    VALUES (source.n_segment, source.nom_segment);

-- MERGE pour SALLE
MERGE INTO SALLE s
USING (VALUES
    ('S01', 'Salle 1', 3, '130.120.80'),
    ('S02', 'Salle 2', 2, '130.120.80'),
    ('S03', 'Salle 3', 2, '130.120.80'),
    ('S11', 'Salle 11', 2, '130.120.81'),
    ('S12', 'Salle 12', 1, '130.120.81'),
    ('S21', 'Salle 21', 2, '130.120.82')
) AS source(n_salle, nom_salle, nb_poste, n_segment)
ON (s.n_salle = source.n_salle)
WHEN MATCHED THEN
    UPDATE SET 
        nom_salle = source.nom_salle,
        nb_poste = source.nb_poste,
        n_segment = source.n_segment
WHEN NOT MATCHED THEN
    INSERT (n_salle, nom_salle, nb_poste, n_segment)
    VALUES (source.n_salle, source.nom_salle, source.nb_poste, source.n_segment);

-- MERGE pour POSTE
MERGE INTO POSTE p
USING (VALUES
    ('P1', 'Poste 1', '130.120.80', '01', 'TX', 'S01'),
    ('P2', 'Poste 2', '130.120.80', '02', 'UNIX', 'S01'),
    ('P3', 'Poste 3', '130.120.80', '03', 'TX', 'S01'),
    ('P4', 'Poste 4', '130.120.80', '04', 'PCWS', 'S02'),
    ('P5', 'Poste 5', '130.120.80', '05', 'PCWS', 'S02'),
    ('P6', 'Poste 6', '130.120.80', '06', 'UNIX', 'S03'),
    ('P7', 'Poste 7', '130.120.80', '07', 'TX', 'S03'),
    ('P8', 'Poste 8', '130.120.81', '01', 'UNIX', 'S11'),
    ('P9', 'Poste 9', '130.120.81', '02', 'TX', 'S11'),
    ('P10', 'Poste 10', '130.120.81', '03', 'UNIX', 'S12'),
    ('P11', 'Poste 11', '130.120.82', '01', 'PCXP', 'S21'),
    ('P12', 'Poste 12', '130.120.82', '02', 'PCXP', 'S21')
) AS source(n_poste, nom_poste, n_segment, ad, type_poste, n_salle)
ON (p.n_poste = source.n_poste)
WHEN MATCHED THEN
    UPDATE SET 
        nom_poste = source.nom_poste,
        n_segment = source.n_segment,
        ad = source.ad,
        type_poste = source.type_poste,
        n_salle = source.n_salle
WHEN NOT MATCHED THEN
    INSERT (n_poste, nom_poste, n_segment, ad, type_poste, n_salle)
    VALUES (source.n_poste, source.nom_poste, source.n_segment, source.ad, source.type_poste, source.n_salle);

-- MERGE pour LOGICIEL
MERGE INTO LOGICIEL l
USING (VALUES
    ('Log1', 'Oracle 9i', '2021-05-13', '9.2', 'UNIX'),
    ('Log2', 'Oracle 10g', '2020-09-15', '10.1', 'UNIX'),
    ('Log3', 'Sql Server', '2022-04-12', '2020SE', 'PCXP'),
    ('Log4', '4D', '2020-06-03', '2019.4', 'PCXP'),
    ('Log5', 'Windev', '2021-11-12', '10', 'PCWS'),
    ('Log6', 'Sql*Net', '2021-05-13', '2.5', 'UNIX'),
    ('Log7', 'I. I. S.', '2020-04-12', '6.0', 'PCXP'),
    ('Log8', 'Autocad', '2022-03-21', 'AU2019', 'PCWS')
) AS source(n_logiciel, nom_logiciel, date_achat, version, type_logiciel)
ON (l.n_logiciel = source.n_logiciel)
WHEN MATCHED THEN
    UPDATE SET 
        nom_logiciel = source.nom_logiciel,
        date_achat = source.date_achat,
        version = source.version,
        type_logiciel = source.type_logiciel
WHEN NOT MATCHED THEN
    INSERT (n_logiciel, nom_logiciel, date_achat, version, type_logiciel)
    VALUES (source.n_logiciel, source.nom_logiciel, source.date_achat, source.version, source.type_logiciel);

-- MERGE pour INSTALLER
MERGE INTO INSTALLER i
USING (VALUES
    ('P2', 'Log1', '2021-05-15'),
    ('P2', 'Log2', '2020-09-17'),
    ('P4', 'Log5', '2022-05-30'),
    ('P6', 'Log6', '2021-05-20'),
    ('P6', 'Log1', '2021-05-20'),
    ('P8', 'Log2', '2021-05-19'),
    ('P8', 'Log6', '2021-05-20'),
    ('P11', 'Log3', '2022-04-20'),
    ('P12', 'Log4', '2020-06-20'),
    ('P11', 'Log7', '2022-04-20')
) AS source(n_poste, n_logiciel, date_ins)
ON (i.n_poste = source.n_poste AND i.n_logiciel = source.n_logiciel)
WHEN MATCHED THEN
    UPDATE SET date_ins = source.date_ins
WHEN NOT MATCHED THEN
    INSERT (n_poste, n_logiciel, date_ins)
    VALUES (source.n_poste, source.n_logiciel, source.date_ins); 