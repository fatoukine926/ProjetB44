/*Fatou kine diop */
/*Partie 1 du projet de bas*/

use [B44_fatoukine]
/*Création de la table Relance*/
create table Relance (
NoRelance int identity(1,1) constraint PK_NoRelance primary key,
NoFacture int,
NoPatient int,
DateRelance date default getdate(),
MontantDu decimal(10,2) constraint CK_MontantDuRelance check (MontantDu > 0),
Statut varchar(20) default 'En attente' constraint CK_StatutRelance check (Statut in ('En attente', 'Traitée'))
)

/*Création de la table Patient*/
create table Patient (
NoPatient int identity(1,1) constraint PK_NoPatientPatient primary key,
Nom varchar(50),
Prenom varchar(50),
DateNaisance date,
Maladie varchar(50),
NoAssurance varchar(50) constraint Unique_NoAssurance unique,
Telephone varchar(15)
)

/*Création de la table Prescription*/
create table Prescription(
NoPrescription int identity(1,1) constraint PK_NoPrescriptionPrescription primary key,
NoRendezVous int,
Medicament varchar(100),
Dosage varchar(50),
Duree varchar(50),
DateEmission date default getdate()
)

/*Création de la table Facture*/
create table Facture (
NoFacture int identity(1,1) constraint PK_NoFactureFacture primary key,
NoRendezVous int,
NoPatient int,
MontantTotal decimal(10,2) constraint CK_MontantTotalFacture check (MontantTotal >= 0),
MontantAssurance decimal(10,2) default 0 constraint CK_MontantAssuranceFacture check (MontantAssurance >= 0),
MontantDu decimal(10,2) constraint CK_MontantDuFacture check (MontantDu >= 0),
DateFacture date default getdate(),
Statut varchar(20) default 'Non payé' constraint CK_StatutFacture check (Statut in ('Payé', 'Non payé'))
)

/*Création de la table RendezVous*/
create table RendezVous (
NoRendezVous int identity(1,1) constraint PK_NoRendezVous primary key,
NoPatient int,
NoMedecin int,
DateRV date,
HeureRV time(7),
Motif varchar(200) default 'Consultation générale',
statut varchar(20) default 'Planifié' constraint CK_StatutRendezVous check (Statut in ('Planifié', 'Complété', 'Annulé'))
)

/*Création de la table Paiement*/
create table Paiement (
NoPaiement int identity(1,1) constraint PK_NoPaiement primary key,
NoFacture int,
DatePaiement date default getdate(),
Montant decimal(10,2) constraint CK_MontanPaiementt check (Montant > 0)
)

/*Création de la table Medecin*/
create table Medecin (
NoMedecin int identity(1,1) constraint PK_NoMedecin primary key,
Nom varchar(50),
prenom varchar(50),
Specialite varchar(100),
NoPermis varchar(20) constraint Unique_NoPermis unique
)

/*y avait des erreurs dans la création des tables, 
c'est pour cela j'ai drop tous les tables pour recommencer*/
/*drop table Relance
drop table Patient
drop table Prescription
drop table Facture
drop table RendezVous
drop table Paiement
drop table Medecin*/


/*Verifier si les tables sont bien crées*/
select * from Relance
select * from Patient
select * from Prescription
select * from Facture
select * from RendezVous
select * from Paiement
select * from Medecin



/*Ajout des clés etrangers*/

/*Table Relance*/
alter table Relance add constraint FK_NoPatientRelance foreign key (NoPatient)  
References Patient (NoPatient) on delete cascade

alter table Relance add constraint FK_NoFactureRelance foreign key (NoFacture)  
References Facture (NoFacture) on delete cascade

  
/*Table Prescription*/
alter table Prescription add constraint FK_NoRendezVousPrescription foreign key (NoRendezVous)  
References RendezVous (NoRendezVous) on delete cascade


/*Table Facture*/
-- Pas de CASCADE pour éviter plusieurs chemins de suppression.
alter table Facture add constraint FK_NoPatientFacture foreign key (NoPatient)  
References Patient (NoPatient)

alter table Facture add constraint FK_NoRendezVousFacture foreign key (NoRendezVous)  
References  RendezVous (NoRendezVous) on delete cascade

/*Table RendezVous*/
-- Pas de CASCADE pour éviter plusieurs chemins de suppression.
alter table RendezVous add constraint FK_NoPatientRendezVous foreign key (NoPatient)  
References Patient (NoPatient)

alter table RendezVous add constraint FK_NoMedecinRendezVous foreign key (NoMedecin)  
References Medecin (NoMedecin) on delete cascade

/*Table Paiement*/
alter table Paiement add constraint FK_NoFacturePaiement foreign key (NoFacture)  
References Facture (NoFacture) on delete cascade

/*  =========================
   INSERT INTO Patient
   ========================= */
insert into Patient (Nom, Prenom, DateNaisance, Maladie, NoAssurance, Telephone)
values
('Diop', 'Bintou', '2005-03-15', 'Asthme', 'ASS001', '5141111111'),
('Tremblay', 'Julie', '1998-07-22', 'Diabète', 'ASS002', '5142222222'),
('Nguyen', 'Alex', '2001-11-09', 'Migraine', 'ASS003', '5143333333'),
('Smith', 'John', '1989-01-30', 'Hypertension', 'ASS004', '5144444444'),
('Dubois', 'Emma', '1995-06-18', 'Allergie', 'ASS005', '5145555555');
select * from Patient

/* =========================
   INSERT INTO Medecin
   ========================= */

insert into Medecin (Nom, Prenom, Specialite, NoPermis)
values
('Gagnon', 'Marc', 'Cardiologie', 'PER001'),
('Roy', 'Sophie', 'Dermatologie', 'PER002'),
('Lee', 'Kevin', 'Pédiatrie', 'PER003'),
('Martin', 'Laura', 'Neurologie', 'PER004'),
('Wilson', 'David', 'Médecine générale', 'PER005');
select * from Medecin


/* =========================
   INSERT INTO RendezVous
   ========================= */

insert into RendezVous (NoPatient, NoMedecin, DateRV, HeureRV, Motif, Statut)
values
(1, 1, '2026-05-10', '09:00:00', 'Consultation cardiaque', 'Planifié'),
(2, 2, '2026-05-11', '10:30:00', 'Problème peau', 'Complété'),
(3, 3, '2026-05-12', '14:00:00', 'Suivi médical', 'Planifié'),
(4, 4, '2026-05-13', '11:15:00', 'Examen neurologique', 'Annulé'),
(5, 5, '2026-05-14', '15:45:00', 'Consultation générale', 'Complété');
select * from RendezVous


/* =========================
   INSERT INTO Prescription
   ========================= */
insert into Prescription (NoRendezVous, Medicament, Dosage, Duree, DateEmission)
values
(1, 'Ventolin', '2 bouffées', '30 jours', '2026-05-10'),
(2, 'Metformine', '500mg', '60 jours', '2026-05-11'),
(3, 'Ibuprofène', '400mg', '7 jours', '2026-05-12'),
(4, 'Aspirine', '100mg', '15 jours', '2026-05-13'),
(5, 'Cetirizine', '10mg', '14 jours', '2026-05-14');
select * from Prescription


/* =========================
   INSERT INTO Facture
   ========================= */
insert into Facture (NoRendezVous, NoPatient, MontantTotal, MontantAssurance, MontantDu, DateFacture, Statut)
values
(1, 1, 150.00, 50.00, 100.00, '2026-05-10', 'Non payé'),
(2, 2, 200.00, 100.00, 100.00, '2026-05-11', 'Payé'),
(3, 3, 120.00, 20.00, 100.00, '2026-05-12', 'Non payé'),
(4, 4, 300.00, 150.00, 150.00, '2026-05-13', 'Non payé'),
(5, 5, 180.00, 80.00, 100.00, '2026-05-14', 'Payé');
select * from Facture


/* =========================
   INSERT INTO Paiement
   ========================= */
insert into Paiement (NoFacture, DatePaiement, Montant)
values
(1, '2026-05-15', 50.00),
(2, '2026-05-15', 100.00),
(3, '2026-05-16', 40.00),
(4, '2026-05-16', 75.00),
(5, '2026-05-17', 100.00);
select * from Paiement


/* =========================
   INSERT INTO Relance
   ========================= */
insert into Relance (NoFacture, NoPatient, DateRelance, MontantDu, Statut)
values
(1, 1, '2026-05-20', 100.00, 'En attente'),
(2, 2, '2026-05-20', 100.00, 'Traitée'),
(3, 3, '2026-05-21', 100.00, 'En attente'),
(4, 4, '2026-05-21', 150.00, 'En attente'),
(5, 5, '2026-05-22', 100.00, 'Traitée');
select * from Relance


/*2eme partie*/

/*1)Lister tous les rendez-vous d'un médecin pour une journée donnée (3pts) 
Respecter le format de sortie */
select R.NoRendezVous, R.HeureRV, concat(P.Nom,' ',P.Prenom) as 'Patient', R.Motif, R.Statut
from RendezVous R inner join Patient P on R.NoPatient = P.NoPatient 
where R.NoMedecin  = 1 and R.DateRV = '2026-05-10'


/*2) Afficher les patients ayant des factures impayées  (3pts) 
Respecter le format de sortie */
select P.NoPatient, concat(P.Nom,' ',P.Prenom) as 'Patient',
substring(P.Telephone,1,3) + '-' +
substring(P.Telephone,4,3) + '-' +
substring(P.Telephone,7,4) as Telephone,
F.MontantDu as 'TotalDu'
from Patient P inner join Facture F on P.NoPatient = F.NoPatient
where F.MontantDu > 0


/*3) Calculer le nombre moyen de rendez-vous par médecin (3pts) 
Respecter le format de sortie*/
select cast(avg(NbRendezVous) as decimal(10,6)) as MoyenneRendezVousParMedecin
from (
    select count(*) as NbRendezVous
    from RendezVous
    group by NoMedecin
) as T

/*Trouver les 5 médecins ayant vu le plus de patients distincts (3pts) 
Respecter le format de sortie :*/
select top 5 
    concat(M.Nom, ' ', M.Prenom) as Medecin,
    M.Specialite,
    count(distinct R.NoPatient) as NbPatientsDistincts
from Medecin M 
inner join RendezVous R on M.NoMedecin = R.NoMedecin
group by M.NoMedecin, M.Nom, M.Prenom, M.Specialite
order by NbPatientsDistincts desc


/*Lister tous les rendez-vous annulés au cours des 30 derniers jours (3pts) 
Respecter le format de sortie : */
select 
    R.NoRendezVous,
    R.DateRV,
    R.HeureRV,
    concat(P.Nom, ' ', P.Prenom) as Patient,
    concat(M.Nom, ' ', M.Prenom) as Medecin,
    R.Motif
from RendezVous R 
inner join Patient P on R.NoPatient = P.NoPatient
inner join Medecin M on R.NoMedecin = M.NoMedecin
where R.Statut = 'Annulé'
  and R.DateRV >= dateadd(day, -30, getdate())



