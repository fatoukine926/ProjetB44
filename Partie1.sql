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


