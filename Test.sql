use [B44_fatoukine]
/*create synonym Annuelles for BDCoursB44.dbo.ANNUELLES
create synonym Vivaces for BDCoursB44.dbo.VIVACES
create synonym Inventaires for BDCoursB44.dbo.INVENTAIRES
create synonym Couleurs for BDCoursB44.dbo.COULEURS*/

/*select * from Annuelles*/
/*select * from Vivaces*/
/*select * from Inventaires*/
/*select * from Couleurs*/

/*Lister tous les annuelles jaunes (ne pas afficher la colonne remarques)
select NOPLANTE,NOMPLANTE,COULEUR,HAUTEUR,HUMIDITE,DATESEMIS from Annuelles where COULEUR='J'*/

/*lister les annuelles rose dont la hateur est superieure a 30 cm
select * from Annuelles where COULEUR='RS' and HAUTEUR>30*/

/*lister les vivaces dont la hauteur est entre 5 et 25 cm
select * from Vivaces where HAUTEUR between 5 and 25*/

/*
listons les vivaces rouges qui fleurissent en aout Afficher les colonnes NOPLANTE, NOMPLANTE 
et MOISFLORAISON avec les titres de colonnes suivants: No plante, Nom de la plante et Mois de 
floraison. 
select NOPLANTE 'No plante',NOMPLANTE 'Nom de la plante',MOISFLORAISON 'Mois de floraison' from Vivaces*/

/* Lister les vivaces blanches que l'on peut placer à l'ombre dans un endroit humide 
select * from Vivaces where COULEUR='BL' AND SOLEIL='O' and HUMIDITE='H'*/

/*
Lister les annuelles moyennes (entre 30 et 50 cm) que l'on peut placer en plein soleil, en 
terrain sec.   Afficher le numéro, le nom, la hauteur, les facteurs de soleil et d'humidité.

select NOPLANTE numéro,NOMPLANTE nom,HAUTEUR hauteur,Soleil 'les facteurs du soleil',HUMIDITE humidité from Annuelles where Hauteur between 30 and 50 and SOLEIL='S' AND HUMIDITE='S'*/

/*Lister toutes les fleurs annuelles (nom, date de semis) en ordre de date de semis (plus 
récente en premier).
select NOMPLANTE nom,DATESEMIS 'date de semis' from Annuelles order BY DATESEMIS desc*/

/*Lister toutes les annuelles (nom, hauteur, soleil, humidité) qui ne supportent pas l'ombre. 
Utiliser l'opérateur IN
*/

/*Lister les vivaces qui n'ont rien d'inscrit comme facteur de soleil ou d'humidité. 

select * from Vivaces where SOLEIL IS NULL AND HUMIDITE IS NULL*/

/*
 Lister les annuelles (nom de la plante) qui commence par la lettre C.

select * from Annuelles where NOMPLANTE like 'C%'*/


/*
Lister les annuelles (nom de la plante) qui ont la lettre S comme 3ième caractère. 


select * from Annuelles where NOMPLANTE like '__S%' */

/* Lister les annuelles (nom de la plante) qui ont au moins une lettre A dans leur nom. 


select NOMPLANTE 'nom de la plante' from Annuelles where NOMPLANTE like '%A%' */



/*
Lister la première vivace blanche (Numéro de plante, Nom de plante)

select top 1 NOPLANTE 'Numéro de la plante',NOMPLANTE 'Nom de plante' from Vivaces where COULEUR='BL'*/


/*
Lister les annuelles qui ont été semées en 2026, utiliser between. 
*/
select * from Annuelles where DATESEMIS between '2026-01-01' and '2026-12-31'












