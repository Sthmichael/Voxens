create table Mpiasa(
    idMpiasa int PRIMARY KEY auto_increment,
    Matricule varchar(122),
    Prenoms varchar(122),
    Niveau varchar(122),
    Fonction varchar(122),
    Responsable varchar(122),
    Perimetre varchar(122),
    Mots_de_passe varchar(122)
);


create table Planning(
    idPlanning int PRIMARY KEY auto_increment,
    idMpiasa int,
    Date_Debut date,
    Date_Fin date,
    Heure_Debut time,
    Heure_Fin time
);

CREATE VIEW Mpiasa_Planning_View AS
SELECT 
    M.idMpiasa,
    M.Matricule,
    M.Prenoms,
    M.Niveau,
    M.Fonction,
    M.Responsable,
    M.Perimetre,
    M.Mots_de_passe,
    P.idPlanning,
    P.Date_Debut,
    P.Date_Fin,
    P.Heure_Debut,
    P.Heure_Fin
FROM 
    Mpiasa M
JOIN 
    Planning P ON M.idMpiasa = P.idMpiasa;

create table Motif(
    idMotif int PRIMARY KEY auto_increment,
    motif varchar(122)
);

insert into Motif values (default,'CP');
insert into Motif values (default,'PE');
insert into Motif values (default,'CSS');
insert into Motif values (default,'RM');
insert into Motif values (default,'AM');
insert into Motif values (default,'CM');
insert into Motif values (default,'JF');


create table Planning_Conge(
    idPlanning_Conge int PRIMARY KEY auto_increment,
    idMpiasa int,
    idMotif int,
    Date_Debut_Conge date,
    Date_Fin_Conge date,
    FOREIGN KEY (idMpiasa) REFERENCES Mpiasa(idMpiasa),
    FOREIGN KEY (idMotif) REFERENCES Motif(idMotif)
);

create table Acceptation(
    idAcceptation int PRIMARY KEY auto_increment,
    Acceptation varchar(122)
);

insert into Acceptation values (default,'Accepter');
insert into Acceptation values (default,'Suprimer');
CREATE TABLE Reponse_Conge(
    idReponse_Conge int PRIMARY KEY auto_increment,
    idPlanning_Conge int,
    idAcceptation int,
    heure_validation datetime, -- Nouvelle colonne pour l'heure de validation
    FOREIGN KEY (idPlanning_Conge) REFERENCES Planning_Conge(idPlanning_Conge),
    FOREIGN KEY (idAcceptation) REFERENCES Acceptation(idAcceptation)
);

CREATE VIEW `Vue_Reponse_Conge` AS
SELECT
    `rc`.`idReponse_Conge` AS `idReponse_Conge`,
    `pc`.`idPlanning_Conge` AS `idPlanning_Conge`,
    `mp`.`idMpiasa` AS `idMpiasa`,
    `mp`.`Matricule` AS `Matricule`,
    `pc`.`idMotif` AS `idMotif`,
    `pc`.`Date_Debut_Conge` AS `Date_Debut_Conge`,
    `pc`.`Date_Fin_Conge` AS `Date_Fin_Conge`,
    `a`.`Acceptation` AS `Acceptation`,
    `rc`.`heure_validation` AS `heure_validation`
FROM
    `reponse_conge` `rc`
JOIN
    `planning_conge` `pc` ON `rc`.`idPlanning_Conge` = `pc`.`idPlanning_Conge`
JOIN
    `acceptation` `a` ON `rc`.`idAcceptation` = `a`.`idAcceptation`
JOIN
    `Mpiasa` `mp` ON `mp`.`idMpiasa` = `pc`.`idMpiasa`;

SELECT * 
FROM Conge_View
WHERE idPlanning_Conge = (SELECT MAX(idPlanning_Conge) FROM Conge_View) And Matricule='305/23';



CREATE VIEW pointeuse_view AS
SELECT 
    pt.idPointeuse AS idPointeuse,
    pt.Matricule AS Matricule,
    pt.Device AS Device,
    pt.Locations AS Locations,
    pt.Prenoms AS Pointeuse_Prenoms,
    pt.Departement AS Departement,
    pt.Temps AS Temps,
    mp.idMpiasa AS idMpiasa,
    mp.Prenoms AS Mpiasa_Prenoms,
    mp.Niveau AS Niveau,
    mp.Fonction AS Fonction,
    mp.Responsable AS Responsable,
    mp.Perimetre AS Perimetre,
    mp.Mots_de_passe AS Mots_de_passe,
    mp.idPlanning AS idPlanning,
    mp.Date_Debut AS Date_Debut,
    mp.Date_Fin AS Date_Fin,
    mp.Heure_Debut AS Heure_Debut,
    mp.Heure_Fin AS Heure_Fin
FROM 
    pointeuse pt
JOIN 
    mpiasa_planning_view mp 
ON 
    pt.Matricule = mp.Matricule 
    AND MONTH(pt.Temps) = MONTH(mp.Date_Debut) 
    AND YEAR(pt.Temps) = YEAR(mp.Date_Debut);


CREATE VIEW pointeuse_view2 AS
SELECT DISTINCT
    pt.idPointeuse AS idPointeuse,
    pt.Matricule AS Matricule,
    pt.Device AS Device,
    pt.Locations AS Locations,
    pt.Prenoms AS Pointeuse_Prenoms,
    pt.Departement AS Departement,
    pt.Temps AS Temps,
    mp.idMpiasa AS idMpiasa,
    mp.Prenoms AS Mpiasa_Prenoms,
    mp.Niveau AS Niveau,
    mp.Fonction AS Fonction,
    mp.Responsable AS Responsable,
    mp.Perimetre AS Perimetre,
    mp.Mots_de_passe AS Mots_de_passe,
    mp.idPlanning AS idPlanning,
    mp.Date_Debut AS Date_Debut,
    mp.Date_Fin AS Date_Fin,
    mp.Heure_Debut AS Heure_Debut,
    mp.Heure_Fin AS Heure_Fin
FROM 
    pointeuse pt
JOIN 
    mpiasa_planning_view mp 
ON 
    pt.Matricule = mp.Matricule 
    AND MONTH(pt.Temps) = MONTH(mp.Date_Debut) 
    AND YEAR(pt.Temps) = YEAR(mp.Date_Debut);


CREATE VIEW pointeuse_view AS
SELECT 
    MIN(pt.idPointeuse) AS idPointeuse,
    pt.Matricule AS Matricule,
    pt.Device AS Device,
    pt.Locations AS Locations,
    pt.Prenoms AS Pointeuse_Prenoms,
    pt.Departement AS Departement,
    pt.Temps AS Temps,
    mp.idMpiasa AS idMpiasa,
    mp.Prenoms AS Mpiasa_Prenoms,
    mp.Niveau AS Niveau,
    mp.Fonction AS Fonction,
    mp.Responsable AS Responsable,
    mp.Perimetre AS Perimetre,
    mp.Mots_de_passe AS Mots_de_passe,
    mp.idPlanning AS idPlanning,
    mp.Date_Debut AS Date_Debut,
    mp.Date_Fin AS Date_Fin,
    mp.Heure_Debut AS Heure_Debut,
    mp.Heure_Fin AS Heure_Fin
FROM 
    pointeuse pt
JOIN 
    mpiasa_planning_view mp 
ON 
    pt.Matricule = mp.Matricule 
    AND MONTH(pt.Temps) = MONTH(mp.Date_Debut) 
    AND YEAR(pt.Temps) = YEAR(mp.Date_Debut)
GROUP BY 
    pt.Matricule, 
    pt.Device, 
    pt.Locations, 
    pt.Prenoms, 
    pt.Departement, 
    pt.Temps,
    mp.idMpiasa,
    mp.Prenoms,
    mp.Niveau,
    mp.Fonction,
    mp.Responsable,
    mp.Perimetre,
    mp.Mots_de_passe,
    mp.idPlanning,
    mp.Date_Debut,
    mp.Date_Fin,
    mp.Heure_Debut,
    mp.Heure_Fin;


create table Pointeuse (
    idPointeuse int PRIMARY KEY auto_increment,
    Matricule varchar(122),
    Device varchar(122),
    Locations varchar(122),
    Prenoms varchar(122),
    Departement varchar(122),
    Temps datetime
);

-- Création de la vue
CREATE VIEW VuePointeuse AS
SELECT 
Matricule,
    Prenoms,
    Departement,
    DATE(Temps) AS Date,
    MIN(Temps) AS Heure_Entree,
    MAX(Temps) AS Heure_Sortie
FROM Pointeuse
GROUP BY Prenoms, DATE(Temps);



select `rc`.`idReponse_Conge` AS `idReponse_Conge`,`pc`.`idPlanning_Conge` AS `idPlanning_Conge`,`pc`.`idMpiasa` AS `idMpiasa`,`pc`.`Matricule` AS `Matricule`,`pc`.`idMotif` AS `idMotif`,`pc`.`Date_Debut_Conge` AS `Date_Debut_Conge`,`pc`.`Date_Fin_Conge` AS `Date_Fin_Conge`,`a`.`Acceptation` AS `Acceptation`,`rc`.`heure_validation` AS `heure_validation` from ((`reponse_conge` `rc` join `planning_conge` `pc` on(`rc`.`idPlanning_Conge` = `pc`.`idPlanning_Conge`)) join `acceptation` `a` on(`rc`.`idAcceptation` = `a`.`idAcceptation`))







