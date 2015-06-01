DROP TABLE IF EXISTS Site;
DROP TABLE IF EXISTS Membre;
DROP TABLE IF EXISTS Sortie;
DROP TABLE IF EXISTS Erreur;
DROP TABLE IF EXISTS Participant;


CREATE TABLE Erreur (
    id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nom_Erreur VARCHAR(255) UNIQUE);

CREATE TABLE Site (
idSite INT(10) AUTO_INCREMENT NOT NULL,
nomSite VARCHAR(100) NOT NULL,
SecteurSite VARCHAR(100),
descriptionSite VARCHAR(10000),
topoSite VARCHAR(50),
CONSTRAINT cp_IDsite PRIMARY KEY(idSite)
)ENGINE=INNODB;


CREATE TABLE Participant(
idSortie INT(10)  NOT NULL,
idParticipant INT(10)  NOT NULL,
PRIMARY KEY(idSortie,idParticipant),
CONSTRAINT FOREIGN KEY (idSortie) REFERENCES Sortie (idEvt),
FOREIGN KEY (IDParticipant) REFERENCES Membre (IDMembre)
)ENGINE=INNODB;


CREATE TABLE Sortie(
idEvt INT(10) AUTO_INCREMENT NOT NULL,
dateEvt Date Not Null,
heureEvt VARCHAR(8) Not Null,
site int(10),
organisateur VARCHAR(50) Not Null,
PRIMARY KEY(idEvt),
CONSTRAINT FOREIGN KEY (site) REFERENCES Site (idSite)
)ENGINE=INNODB;


CREATE TABLE Membre (
IDMembre INT(10) AUTO_INCREMENT NOT NULL,
email VARCHAR(254),
nomMembre VARCHAR(100) NOT NULL,
PrenomMembre VARCHAR(100) NOT NULL,
mdp VARCHAR(254) NOT NULL,
tel INT(20),
statut BOOLEAN NOT NULL,
niveau VARCHAR(3),
CONSTRAINT cp_IDMembre PRIMARY KEY(IDMembre)
)ENGINE=INNODB;






ALTER TABLE Membre ADD cookie VARCHAR(254) NULL DEFAULT NULL AFTER niveau, ADD UNIQUE (cookie) ;


delimiter // 
CREATE TRIGGER before_insert_datesortie 
  BEFORE INSERT ON Sortie
  FOR EACH ROW 
  BEGIN
		IF NEW.dateEvt < NOW() THEN
			INSERT INTO Erreur (Nom_Erreur) VALUES ('Erreur : il est impossible de creer un evénement avec une dante antérieur à la date actuelle');
		END IF;
	END// 
delimiter ;



delimiter // 
CREATE TRIGGER before_update_datesortie 
  BEFORE UPDATE ON Sortie
  FOR EACH ROW 
  BEGIN
	IF NEW.dateEvt < NOW() THEN
		INSERT INTO Erreur (Nom_Erreur) VALUES ('Erreur : il est impossible de creer un evénement avec une date antérieur à la date actuelle');
	END IF;
END// 
delimiter ;


delimiter // 
CREATE TRIGGER before_insert_nomMembre
BEFORE INSERT ON Membre FOR EACH ROW
	BEGIN
	SET NEW.nomMembre = UPPER(NEW.nomMembre);
END// 
delimiter ;



INSERT INTO Site (
idSite ,
nomSite ,
SecteurSite ,
descriptionSite ,
topoSite
)

VALUES ('', 'Ad vitam aeternam', 'Thaurac', 'Du village de St Guilhem, prendre le GR jusqu’au sentier d’accès au mur de la Carmina

Emprunter la sente d’accès aux voies de la Carmina, monter tout droit jusqu’à la vire de départ

/ 25 mn depuis le parking

Le départ de la voie (les 10 premiers mètres) est commun avec « Les fondus déchaînés »', 'topo-ad-vitam-aeternam.pdf'),



('', 'Les Bartassiers de la Yaute', 'Pic St Loup', 'Accès<br />

Se garer au domaine de Mortiès (entre Cazevieille et Saint

Mathieu de Tréviers). Monter au col supérieur de la Pousterle

(à l’ouest du pas de la Pousterle de la carte IGN), pour

basculer versant NE du Pic. Suivre la sente (balisage bleu) au

pied de la face vers l’ouest. Après une dizaine de minutes de

marche, le sentier descend dans un chaos de blocs : la voie est alors visible. Le sentier repart à travers bois et peu

après on repère un grand bloc fissuré « errant » dans le bartas entre la piste et l’attaque de la voie. Quitter alors le

chemin pour rejoindre l’attaque par une sente discrète.

Descente<br />

Désescalader l’arête E (facile) sur une centaine de mètre, jusqu’à rejoindre le sentier des crêtes, balisé en bleu, et

rejoindre le col supérieur de la Pousterle. Revenir alors sur ses pas vers le domaine de Mortiès.', 'Les-Bartassiers-de-la-Yaute.pdf'),



('', 'La Walker des garrigues', 'Pic St Loup', 'La "walker des garrigues" a en commun avec sa fameuse homonyme le fait de sortir sur

un sommet prestigieux (si si! "le Pic est une des plus belles montagnes du monde" dixit

Lucien Bérardini) et d’être le plus long itinéraire de la face nord...

La voie suit l’écharpe de bon rocher qui traverse de gauche à droite la face. C’est une

grande voie à caractère "montagne" (coinceurs et friends indispensables) avec de

grandes longueurs en traversée: passé la deuxième longueur la redescente dans la voie

devient problématique!

Le rocher est très bon dans l ensemble mais quelques courts passages de transitions

nécessitent d être vigilant... ', 'walker-des-garrigues.pdf'),



('', 'Calibre douze', 'Saint Guilhem le désert', '« Calibre douze », clin d’œil aux chasseurs de St Guilhem, est un bel

itinéraire homogène dans ce niveau de difficulté, ayant le mérite de

sortir au sommet du roc de la Bissone ; c’est l’itinéraire le plus long du

cirque, proposant une escalade variée sur un beau rocher, avec

l’ambiance en prime ! ', 'topo-calibre-12.pdf'),



 ('', ' Pic Performance', 'Pic St Loup', ' 7c/A0 ou 8b (un pas)

210m 7a', 'Pic-Performance-Intégral.pdf'),



('', 'Salle Odysseum', 'Altissimo', 'Avec ses 1800m² de surface grimpable, l’espace escalade Odysseum est la plus grande salle du réseau Altissimo. Une très belle variété de profils y est déclinée, permettant à chacun d’y pratiquer l’escalade selon son niveau et ses envies.', '');


INSERT INTO Sortie (
idEvt ,
dateEvt ,
heureEvt ,
site ,
organisateur
)

VALUES ('', '2015-6-15', '14', '1', 'Jack'),

('', '2015-6-15', '14', '2', 'Jack'),

('', '2015-6-21', '14', '3', 'Jack'),

('', '2015-6-29', '14', '4', 'Pierre'),

 ('', '2015-6-7', '15', '5', 'Pierre'),
 ('', '2015-5', '14:30', '6', 'Daniel'),

 ('', '2015-6-7', '15:30', '5', 'Daniel');

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('admin@admin.com', 'test', 'test', '9283a03246ef2dacdc21a9b137817ec1', '', 1, '');
 insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgarcia0@hugedomains.com', 'Garcia', 'Léone', 'QwdJIVu4b', '06 91 54 05 67', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gallen1@nsw.gov.au', 'Allen', 'Lèi', 'K2BUcOR18li', '06 96 46 40 58', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jlopez2@harvard.edu', 'Lopez', 'Gaétane', 'BiayegFdqt', '06 41 83 56 17', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmartin3@va.gov', 'Martin', 'Régine', 'BG8YClw', '06 36 67 64 70', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sbaker4@accuweather.com', 'Baker', 'Maïwenn', '745f7nAWn', '06 34 39 30 73', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sadams5@soundcloud.com', 'Adams', 'Céline', 'k4nN6V', '06 47 77 06 84', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nmiller6@exblog.jp', 'Miller', 'Örjan', '6FNEdjMxivM', '06 87 82 59 96', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rpierce7@alibaba.com', 'Pierce', 'Illustrée', 'xz0hIJLG', '06 03 96 59 37', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kburton8@reuters.com', 'Burton', 'Åslög', 'sje71VHiE', '06 16 69 50 05', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jsmith9@chron.com', 'Smith', 'Vérane', 'ehuAn9nt', '06 84 47 31 04', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lpetersona@patch.com', 'Peterson', 'Kuí', 'y1ToHarPK', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ncunninghamb@delicious.com', 'Cunningham', 'Léana', 'OObj5Ssa', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tmatthewsc@sitemeter.com', 'Matthews', 'Eloïse', 'VvxfyBvntU', '06 42 19 29 72', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nrusselld@slate.com', 'Russell', 'Béatrice', 'qMxgUH', '06 11 41 12 58', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aelliotte@nasa.gov', 'Elliott', 'Réjane', 'cCFLZB', '06 37 02 76 45', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bboydf@hp.com', 'Boyd', 'Mégane', 'kAfc9T0x4cc', '06 70 69 86 88', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jjacobsg@ameblo.jp', 'Jacobs', 'Styrbjörn', 'MAiw6Y9xW', '06 02 45 41 32', 0, '6a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jcarrh@jigsy.com', 'Carr', 'Véronique', 'DZeU3JXUI', null, 0, '7a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cjacobsi@merriam-webster.com', 'Jacobs', 'Kù', 'y0VN74Gc', '06 88 52 04 24', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hmatthewsj@4shared.com', 'Matthews', 'Inès', 'eiwH77KfGu', '06 88 97 24 80', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sphillipsk@oaic.gov.au', 'Phillips', 'Maïlys', '01QwGf2F3nh', '06 79 84 46 80', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bcarpenterl@yahoo.co.jp', 'Carpenter', 'Ophélie', 'kCtDHr6U', '06 25 71 83 81', 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ehallm@geocities.jp', 'Hall', 'Léana', 'e27QFqjeXMGK', '06 43 97 65 89', 0, '6b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dharveyn@aboutads.info', 'Harvey', 'Irène', 'T0Et9TE', '06 46 84 74 12', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lwilliamso@bloglines.com', 'Williams', 'Célestine', 'MMU1YfXc42pS', '06 52 27 96 89', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bwilliamsonp@hp.com', 'Williamson', 'Uò', 'LJw07YsaLHNe', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hgreeneq@de.vu', 'Greene', 'Estève', 'AT7bcNH7bt', '06 00 51 56 54', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ballenr@cyberchimps.com', 'Allen', 'Ophélie', 'M9SfcQhNyy', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aburtons@histats.com', 'Burton', 'Amélie', '6gvn2h2ypF', '06 10 85 91 22', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('elopezt@posterous.com', 'Lopez', 'Clélia', 'FzKgjyxBG', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aleeu@simplemachines.org', 'Lee', 'Lóng', 'hEOIS6V2YAlQ', '06 59 34 48 59', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cspencerv@mail.ru', 'Spencer', 'Cléa', '7laUgJ', '06 12 23 40 22', 0, '7a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kdixonw@deliciousdays.com', 'Dixon', 'Michèle', 'vobxa3TzemDB', '06 86 11 17 56', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ekelleyx@ucsd.edu', 'Kelley', 'Görel', 're9Gnb', '06 27 12 01 97', 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rreedy@plala.or.jp', 'Reed', 'Marie-josée', '7xfWH8d', '06 51 97 42 28', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lhillz@auda.org.au', 'Hill', 'Adélie', 'X8QX7UKFfus', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rmarshall10@skype.com', 'Marshall', 'Dà', '1KhpJb', '06 27 40 62 60', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jblack11@timesonline.co.uk', 'Black', 'Mén', 'HRJXelm', '06 03 84 52 49', 0, '6a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lgraham12@ft.com', 'Graham', 'Lucrèce', 'hT7q8bKFlrw', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgordon13@shinystat.com', 'Gordon', 'Aloïs', 'rsgAYN', '06 94 67 89 46', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mjackson14@va.gov', 'Jackson', 'Vénus', 'Muxuk7Ov0Pll', '06 70 92 58 19', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lbryant15@netscape.com', 'Bryant', 'Mahélie', 'dbHPONslc4CC', '06 11 51 06 48', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kparker16@patch.com', 'Parker', 'Léone', 'fSxplx', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('krivera17@blogs.com', 'Rivera', 'Táng', 'Y8CRDySftfCj', '06 84 94 77 69', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fhamilton18@pcworld.com', 'Hamilton', 'Yáo', 'e8qUhtNEJC9', '06 38 96 31 25', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jcarpenter19@i2i.jp', 'Carpenter', 'Méng', 'Be9o1Ms', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ahunt1a@columbia.edu', 'Hunt', 'Yáo', 'uFNMzR', '06 80 79 70 66', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('acarpenter1b@ebay.com', 'Carpenter', 'Adélaïde', 'n1Vl4xM', '06 84 08 44 93', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mgardner1c@e-recht24.de', 'Gardner', 'Hélène', 'SXoRAkFet', '06 50 65 58 08', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tbarnes1d@yandex.ru', 'Barnes', 'Anaïs', 'RTZNrA', '06 86 66 93 04', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hmitchell1e@mashable.com', 'Mitchell', 'Estève', 'xdhYwU', '06 60 06 31 51', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('arobertson1f@usnews.com', 'Robertson', 'Ruò', 'iD52C0', '06 90 40 52 15', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jpatterson1g@nature.com', 'Patterson', 'Gwenaëlle', 'zLgW3B9b3', '06 71 41 87 29', 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fbarnes1h@weibo.com', 'Barnes', 'Torbjörn', 'lV6EK2GRlcOT', '06 04 31 74 28', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('srose1i@house.gov', 'Rose', 'Clémentine', 'BxZNK9NlcEZ', '06 99 41 16 72', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('krice1j@ihg.com', 'Rice', 'Lèi', 'vLAsEC4R', '06 00 50 49 12', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dcox1k@bloglines.com', 'Cox', 'Lauréna', 'WOxZ64Lk', '06 13 87 97 14', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('srivera1l@vkontakte.ru', 'Rivera', 'Yénora', 'MrrIJOP', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dcampbell1m@earthlink.net', 'Campbell', 'Yáo', 'lcS753oj8xSw', '06 12 98 83 53', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bjohnson1n@blinklist.com', 'Johnson', 'Fèi', 'JdHIObke', '06 97 78 68 62', 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dadams1o@scribd.com', 'Adams', 'Anaé', 'FjQBoVNCnspE', '06 91 23 39 14', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jrobinson1p@tiny.cc', 'Robinson', 'Adélaïde', 'ct6D0Wyukv', '06 52 16 97 29', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('balexander1q@google.nl', 'Alexander', 'Naéva', 'zYwpnV95UF9', '06 26 36 51 63', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmartin1r@amazon.com', 'Martin', 'Maïté', '6WSjOq4E0CC', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lhicks1s@w3.org', 'Hicks', 'Mélissandre', 'hpZkRNC', '06 68 14 22 62', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('awilliams1t@mozilla.org', 'Williams', 'Garçon', 'G3VNUQdm', '06 21 13 34 99', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mwheeler1u@amazon.co.jp', 'Wheeler', 'Daphnée', '7fSJBzzQXG5', null, 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sjohnston1v@networkadvertising.org', 'Johnston', 'Gaétane', 'gyZnKefL2Rf', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mellis1w@smh.com.au', 'Ellis', 'Clélia', '3QiZlYO', '06 08 76 12 30', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ageorge1x@hostgator.com', 'George', 'Eléa', 'c8EmoJaQ9', '06 61 50 10 06', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('egeorge1y@sourceforge.net', 'George', 'Méryl', '5T2hgNZeb', '06 74 78 52 72', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('erichards1z@mtv.com', 'Richards', 'Noëlla', 'ZBYTuHJ5IC7', '06 19 27 62 06', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('phayes20@addtoany.com', 'Hayes', 'Lóng', 'LyBx08', '06 64 30 54 59', 0, '6c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rjordan21@senate.gov', 'Jordan', 'Alizée', 'wBKNGSmK3', '06 95 92 30 30', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhicks22@newyorker.com', 'Hicks', 'Maëline', '6THFuCYCIoTq', '06 33 98 46 25', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dsmith23@jigsy.com', 'Smith', 'Lucrèce', 'vcGfHeIoNUOB', '06 59 15 64 20', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cstewart24@networksolutions.com', 'Stewart', 'Françoise', '0VCjsPG7MdkN', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwilson25@dagondesign.com', 'Wilson', 'Stéphanie', 'gXLtaVs', '06 00 35 46 43', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jlopez26@weebly.com', 'Lopez', 'Lauréna', 'KvWmK0', '06 95 44 72 56', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sjohnson27@weather.com', 'Johnson', 'Célia', 'wvuskn', '06 99 13 19 58', 0, '7a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rbradley28@nifty.com', 'Bradley', 'Kuí', 'OpMOVn', '06 18 40 33 34', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fowens29@aol.com', 'Owens', 'Estève', 'q8dObvj', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cday2a@fc2.com', 'Day', 'André', 'GdW7BCz', '06 91 44 36 55', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ssullivan2b@flickr.com', 'Sullivan', 'Maïlis', '5FNjqcYZWu2', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lferguson2c@mlb.com', 'Ferguson', 'Frédérique', '2o1Cd04M5t', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jromero2d@army.mil', 'Romero', 'Andréanne', 'jFvdXc', '06 50 16 82 94', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('carnold2e@google.it', 'Arnold', 'Josée', 'pZW5Z85JKLh', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('llarson2f@yahoo.com', 'Larson', 'Marlène', '1bBv6g', '06 12 52 89 94', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mjenkins2g@constantcontact.com', 'Jenkins', 'Illustrée', 'jd3QLxks5zb', '06 14 29 31 39', 0, '4a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nwelch2h@a8.net', 'Welch', 'Gaïa', '10LNzfXR64', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ksims2i@irs.gov', 'Sims', 'Salomé', 'tPB8kVEytL4', '06 80 85 08 13', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rturner2j@slashdot.org', 'Turner', 'Gérald', 'hiMWHH1Xr', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mcruz2k@slideshare.net', 'Cruz', 'Renée', '2eOZ97geEoH', '06 08 93 35 80', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('amorrison2l@un.org', 'Morrison', 'Tán', 'w9dlX1Al', '06 76 00 03 75', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('brice2m@dyndns.org', 'Rice', 'Aimée', 'eFQMmxMFE', '06 83 33 20 29', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pbradley2n@imgur.com', 'Bradley', 'Nélie', 'RHTOPAH6oL', '06 58 57 81 38', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('msanders2o@wiley.com', 'Sanders', 'Lài', 'J4Htixc2V9Iv', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jfields2p@so-net.ne.jp', 'Fields', 'Marie-ève', 'HI2uWor', '06 50 60 46 13', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('banderson2q@vistaprint.com', 'Anderson', 'Cinéma', 'nMuyjO5kM', '06 46 28 37 48', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jblack2r@angelfire.com', 'Black', 'Rachèle', 'exXv2e0GnkQ', '06 63 99 02 69', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vstone2s@addthis.com', 'Stone', 'Eléa', '8HPhKVWFUf', '06 14 96 41 25', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lbishop2t@mapquest.com', 'Bishop', 'Mén', 'oXE7sc9', '06 13 98 99 59', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jbailey2u@gnu.org', 'Bailey', 'Aí', 'vRvXkN4UN', '06 30 74 73 22', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bcook2v@theatlantic.com', 'Cook', 'Anaé', 'vOtfwj5tB', '06 90 49 20 14', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('krose2w@google.com.au', 'Rose', 'Clémentine', 'xJrK4WCYQ', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pelliott2x@so-net.ne.jp', 'Elliott', 'Dà', 'KZohVXnX', null, 0, '4b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ebryant2y@google.ca', 'Bryant', 'Mélanie', 'dHwIafhf', '06 05 48 37 35', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lvasquez2z@creativecommons.org', 'Vasquez', 'Lèi', 'YHwWO0Ou', '06 26 24 81 85', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kstevens30@tmall.com', 'Stevens', 'Océanne', '47BsYOKjfIM', '06 38 64 17 10', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rspencer31@liveinternet.ru', 'Spencer', 'Josée', 'UsSIDXjCrF7', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('agutierrez32@wix.com', 'Gutierrez', 'Cloé', 'raRCUa', '06 43 62 88 41', 0, '4a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pwilson33@state.gov', 'Wilson', 'Garçon', 'Cgelkv', '06 66 71 05 75', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dlee34@intel.com', 'Lee', 'Aimée', 'mRRu7hqz', '06 33 67 52 01', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bgeorge35@deliciousdays.com', 'George', 'Bérangère', '69LoA0tBlQU4', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sberry36@sakura.ne.jp', 'Berry', 'Pélagie', 'nIoCn6', '06 37 97 37 49', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('acollins37@youtu.be', 'Collins', 'Ruì', 'Elv2SZ', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ithomas38@statcounter.com', 'Thomas', 'Aí', 'txMHmOuVM', '06 49 02 13 18', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gchapman39@moonfruit.com', 'Chapman', 'Annotée', 'ueyo35Vd', null, 0, '6a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tellis3a@vinaora.com', 'Ellis', 'Bérangère', 'kM7tPxD2cAdP', '06 65 57 70 78', 0, '7a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ngarza3b@slashdot.org', 'Garza', 'Zoé', '6L9RGJ', null, 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cfoster3c@addtoany.com', 'Foster', 'Maëly', 'kpfcHbu8SV', '06 06 57 66 77', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tmedina3d@friendfeed.com', 'Medina', 'Andréa', 'slWo7CHd', '06 39 76 93 88', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rjenkins3e@people.com.cn', 'Jenkins', 'Bérangère', 'J5LuVcfI3FVB', '06 89 45 66 32', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rblack3f@xrea.com', 'Black', 'Chloé', 'caxnyqHwscU', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cedwards3g@nps.gov', 'Edwards', 'Åslög', 'wQDju6231', null, 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kgonzalez3h@si.edu', 'Gonzalez', 'Naëlle', 'SkH45zv3GULQ', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('swoods3i@nifty.com', 'Woods', 'Loïca', 'ap90SvA1Qmyz', '06 08 14 93 64', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sstephens3j@wix.com', 'Stephens', 'Mahélie', 'BjD3JIq', null, 0, '4c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aryan3k@house.gov', 'Ryan', 'Néhémie', '9xrLPRY8k', '06 65 36 83 17', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lhenry3l@un.org', 'Henry', 'Ráo', 'aN2HMAyeV1gQ', '06 91 14 67 50', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kthompson3m@shop-pro.jp', 'Thompson', 'Faîtes', 'NE6lcUfbOOG', '06 13 68 32 47', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('koliver3n@myspace.com', 'Oliver', 'Yáo', 'XX1oCWXtR', '06 88 14 51 33', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwagner3o@hexun.com', 'Wagner', 'Almérinda', 'WqcLUg4zN9X', '06 96 04 28 63', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sdunn3p@wikia.com', 'Dunn', 'Hélène', 'R8Fxw44', '06 53 74 01 26', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ccook3q@toplist.cz', 'Cook', 'Pål', 'bSVn1yd9LCw0', '06 15 71 17 89', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lpalmer3r@google.com', 'Palmer', 'Lorène', 'xsWAMbn8bvhR', '06 70 95 28 99', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('colson3s@ning.com', 'Olson', 'Marie-noël', 'L7x3SDcvIQq', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mclark3t@wufoo.com', 'Clark', 'Eliès', 'ecTKMruURu1q', '06 23 71 07 12', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ashaw3u@storify.com', 'Shaw', 'Dà', 'AMycOjoe', '06 90 67 11 77', 0, '4a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hjenkins3v@amazon.de', 'Jenkins', 'Estève', 'vgAzMRr', '06 10 68 92 13', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nfowler3w@shareasale.com', 'Fowler', 'Inès', 'MOsk32FN', '06 69 13 44 62', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lgordon3x@elpais.com', 'Gordon', 'Crééz', 'YZZkdEGdx', '06 96 34 02 44', 0, '6a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aking3y@nhs.uk', 'King', 'Nuó', 'F38zBk', '06 44 83 88 65', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmorales3z@lulu.com', 'Morales', 'Félicie', 'mKNQM72uOZ', '06 91 69 45 83', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tsimmons40@ow.ly', 'Simmons', 'André', 'pADaN2', '06 28 43 04 80', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mgriffin41@baidu.com', 'Griffin', 'Marie-thérèse', 'wxgbDu9', '06 69 19 79 05', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lstone42@intel.com', 'Stone', 'Laïla', '5allG8q', '06 00 56 75 14', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jward43@lulu.com', 'Ward', 'Åsa', 'NSSOPO', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('eboyd44@sohu.com', 'Boyd', 'Régine', '7KOtaG', '06 53 37 99 65', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bford45@techcrunch.com', 'Ford', 'Maïly', 'ulXenz', '06 18 99 78 78', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rowens46@addthis.com', 'Owens', 'Tú', 'cSZ6mth47ey', '06 65 21 55 84', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('arice47@wordpress.org', 'Rice', 'Estée', 'wcFePWYMi', '06 85 92 38 01', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wcarter48@yandex.ru', 'Carter', 'Inès', 'h6xWFxlK', '06 36 42 85 28', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('phicks49@odnoklassniki.ru', 'Hicks', 'Lén', 'zI4gaFG6S', '06 70 56 26 51', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('eadams4a@mapy.cz', 'Adams', 'Mélina', 'Qq4s9nnn', null, 0, '4b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('croberts4b@usa.gov', 'Roberts', 'Cléopatre', '1lImwoQSfBe', '06 92 28 68 11', 0, '6a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mbailey4c@lulu.com', 'Bailey', 'Naéva', '4cwHwg9A', '06 50 02 48 31', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dgreen4d@telegraph.co.uk', 'Green', 'Frédérique', 'GYi1jiNHq8H', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sromero4e@whitehouse.gov', 'Romero', 'Yénora', 'd1CZQqz9WDQj', '06 25 43 43 51', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rcarr4f@yelp.com', 'Carr', 'Béatrice', 'wTLnoka41puL', '06 60 61 21 97', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mhansen4g@ning.com', 'Hansen', 'Françoise', 'lKRdVbd57VDO', '06 97 87 40 90', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mprice4h@theglobeandmail.com', 'Price', 'Mélodie', 'uUS8uBg4d', null, 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kpierce4i@dagondesign.com', 'Pierce', 'Annotée', 'fUoZ1VQ', '06 65 38 97 68', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmorris4j@discovery.com', 'Morris', 'Michèle', 'dxj7m1Nl0A', null, 0, '4c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('smedina4k@hc360.com', 'Medina', 'Adèle', 'iDwpQoz4XYE', '06 12 90 06 27', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mkim4l@webeden.co.uk', 'Kim', 'Fèi', 'TpsiVr4f8Yz', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ggordon4m@zimbio.com', 'Gordon', 'Åsa', 'q9q4TajsOTE', null, 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aford4n@zimbio.com', 'Ford', 'Anaëlle', 'q213FR', '06 06 33 25 30', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rsanchez4o@amazon.com', 'Sanchez', 'Réjane', 'DCG6PCNro5c', '06 02 12 21 30', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aprice4p@disqus.com', 'Price', 'Lauréna', 'yASUuau2mXz', '06 93 17 57 04', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ralvarez4q@1und1.de', 'Alvarez', 'Vénus', 'iyI5Qk6', '06 49 64 98 34', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hwallace4r@theguardian.com', 'Wallace', 'Mégane', 'FPl0ppxZDlM', '06 89 47 21 80', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bwhite4s@state.tx.us', 'White', 'Célia', '2Co01wt9og', '06 54 19 27 10', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rmurphy4t@ebay.co.uk', 'Murphy', 'Maï', 'jSvthjUxo', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ejohnson4u@about.me', 'Johnson', 'Léonore', 'js6qoZF0wX', '06 20 94 89 55', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vhart4v@gmpg.org', 'Hart', 'Gösta', 'GprMNm7yj', '06 74 23 17 64', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lortiz4w@webmd.com', 'Ortiz', 'Adélaïde', 'qlG9gdi5z', '06 12 73 42 83', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('drussell4x@blog.com', 'Russell', 'Jú', 'OnbYveNEsaT4', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gboyd4y@nih.gov', 'Boyd', 'Åslög', 'NlcyNyR', '06 51 54 93 12', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('chill4z@patch.com', 'Hill', 'Cunégonde', 'j8DUfsWumL', '06 02 74 72 59', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('prose50@hatena.ne.jp', 'Rose', 'Aimée', 'rOnjzo9JrTS', '06 60 25 64 86', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwarren51@t.co', 'Warren', 'Faîtes', 'oAGoRfJvI', '06 25 75 74 92', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lwhite52@drupal.org', 'White', 'Lài', '7ib7T6m1TGE', '06 35 69 02 30', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bthomas53@cocolog-nifty.com', 'Thomas', 'Séréna', 'XkDKZhHn78', '06 71 66 74 23', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('crussell54@webnode.com', 'Russell', 'Anaëlle', 'WcAZRe5XCr', '06 69 56 10 24', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lcoleman55@bravesites.com', 'Coleman', 'Crééz', 'kwBPln7T', '06 45 19 53 08', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kjohnson56@disqus.com', 'Johnson', 'Cléa', 'wKE1wZxz', '06 15 38 95 01', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rtucker57@bizjournals.com', 'Tucker', 'Eloïse', '4mV0bPuxrgul', '06 22 80 16 07', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cwelch58@simplemachines.org', 'Welch', 'Solène', 'lzmxFf', '06 07 14 67 39', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kgonzales59@themeforest.net', 'Gonzales', 'Géraldine', 'pUv9OR9f', '06 60 30 88 82', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('csmith5a@wikipedia.org', 'Smith', 'Félicie', 'gqwko5kC', '06 87 57 32 81', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gscott5b@jigsy.com', 'Scott', 'Cléa', 'J6mT9pzD9', '06 44 91 97 20', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rhowell5c@usnews.com', 'Howell', 'Ruì', 'Af9QjfI0', null, 0, '7b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('estephens5d@indiegogo.com', 'Stephens', 'Loïs', 'ShsuUIj', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('smurphy5e@mapy.cz', 'Murphy', 'Méng', 'HiOsf85UR', null, 0, '4a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('khansen5f@mashable.com', 'Hansen', 'Bérénice', 'lpzohNYVP', '06 13 43 91 65', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rtaylor5g@nbcnews.com', 'Taylor', 'Dafnée', 'zK1bzq0rT', '06 29 28 27 27', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kcarroll5h@mayoclinic.com', 'Carroll', 'Mélys', 'ryu4er', '06 92 01 06 51', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('htorres5i@blogger.com', 'Torres', 'Tán', 'bKtSjVpPiMr', '06 86 80 57 79', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('caustin5j@printfriendly.com', 'Austin', 'Tú', 'VznIL08S1I', '06 87 32 77 96', 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rkim5k@nifty.com', 'Kim', 'Gaétane', 'soUiqVVZk6', '06 59 72 26 61', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jstephens5l@abc.net.au', 'Stephens', 'Océanne', 'OTqNIYRip', '06 01 28 07 55', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgray5m@ifeng.com', 'Gray', 'Måns', 'r0BZP4', '06 00 80 83 25', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tsmith5n@narod.ru', 'Smith', 'Åslög', 'HG3DILz33', '06 92 64 41 13', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tallen5o@businessweek.com', 'Allen', 'Clémence', 'MrAFmB', '06 83 73 89 81', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wgraham5p@cam.ac.uk', 'Graham', 'Anaïs', 'b2FIoqvPPc3', '06 09 13 98 28', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mmitchell5q@bigcartel.com', 'Mitchell', 'Ruò', 'rJBCFFgNnzsL', '06 55 72 53 91', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('awallace5r@mozilla.org', 'Wallace', 'Ophélie', 'tmtu4sBb4o', '06 02 58 80 10', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kfowler5s@wisc.edu', 'Fowler', 'Fèi', 'qqQRnYCPq', '06 12 08 51 62', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('amontgomery5t@ibm.com', 'Montgomery', 'Vénus', 'pjzFWYcef', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lmcdonald5u@nsw.gov.au', 'Mcdonald', 'Wá', 'bORhJ1DG', '06 23 04 96 32', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('slewis5v@thetimes.co.uk', 'Lewis', 'Mahélie', 'oREqUD9FDP', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgray5w@prweb.com', 'Gray', 'Réjane', 'Y6GdRF', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rburns5x@mapy.cz', 'Burns', 'Miléna', 'nDaEH7rJDVD', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hgardner5y@zimbio.com', 'Gardner', 'Inès', 'rH8RgRffV2', '06 85 52 83 68', 0, '4b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ctaylor5z@ow.ly', 'Taylor', 'Yú', '58H7jJ6C5T1Z', '06 50 07 62 74', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dcampbell60@columbia.edu', 'Campbell', 'Mélinda', 'KS1Eqt', '06 87 34 89 36', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cschmidt61@cnet.com', 'Schmidt', 'Clémence', '7LwLyK1nF', '06 46 31 05 15', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mgrant62@wikispaces.com', 'Grant', 'Anaël', 'YrxdfwFO', '06 05 89 33 70', 0, '4b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwagner63@bizjournals.com', 'Wagner', 'Märta', '70y0rC', '06 98 99 84 70', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mbarnes64@cdbaby.com', 'Barnes', 'Céline', 'IyQTxlMj63', '06 27 51 23 35', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ipatterson65@over-blog.com', 'Patterson', 'Erwéi', 'osVu2seHsRl', '06 84 53 38 40', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dcarter66@army.mil', 'Carter', 'Maëlle', '6Fu6HQO4siLx', '06 99 76 16 85', 0, '6b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jevans67@usatoday.com', 'Evans', 'Mà', 'cEsGwlW', '06 97 22 26 45', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('prodriguez68@cbsnews.com', 'Rodriguez', 'Véronique', 'c1PRmCKP', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jbutler69@cmu.edu', 'Butler', 'Östen', 'lxQ6Tqzw', '06 83 13 56 03', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sbrown6a@stumbleupon.com', 'Brown', 'Cinéma', 'oBekgPDhu', null, 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('blong6b@smugmug.com', 'Long', 'Lucrèce', 'XcTYgA', '06 89 73 98 36', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ncole6c@army.mil', 'Cole', 'Angélique', 'S18HzR', '06 57 82 16 27', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dlopez6d@stanford.edu', 'Lopez', 'Cécilia', 'ERnTRChT0lKV', '06 57 12 95 13', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ewatkins6e@blinklist.com', 'Watkins', 'Lorène', 'wGWtBU', '06 76 95 74 87', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kgomez6f@cbslocal.com', 'Gomez', 'Mà', 'FmFznu55H7X', null, 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dhill6g@statcounter.com', 'Hill', 'Sélène', 'Ja2X7eizs2M3', '06 01 95 56 59', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhanson6h@irs.gov', 'Hanson', 'Yáo', 'SvOs3KIAk', '06 56 21 99 81', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rlarson6i@noaa.gov', 'Larson', 'Björn', 'enx91i2vFFk', '06 02 25 36 98', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hsanders6j@who.int', 'Sanders', 'Mélinda', '3vy6FcLZhG', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gmccoy6k@imageshack.us', 'Mccoy', 'Maïly', 'rT7KuCl8PST', '06 15 37 75 10', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cstewart6l@pinterest.com', 'Stewart', 'Laurélie', 'ty0V3Zmba', '06 64 21 03 57', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('acunningham6m@seattletimes.com', 'Cunningham', 'Loïca', '3cHe2oTCq', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jjames6n@yellowbook.com', 'James', 'Lauréna', 'W17rn7nV', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mlynch6o@cdc.gov', 'Lynch', 'Uò', 'uXsdpTDChn', '06 00 19 85 25', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rmartinez6p@e-recht24.de', 'Martinez', 'Réservés', '5ojcKMD2a', '06 70 11 61 25', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ssimpson6q@google.co.uk', 'Simpson', 'Estève', 'z978AidCh6', '06 53 13 49 56', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('charper6r@ucoz.ru', 'Harper', 'Renée', 'U1OtJat', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kmarshall6s@drupal.org', 'Marshall', 'Bérangère', 'xYYQMQ6M28Z', '06 06 12 75 89', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lfowler6t@cdc.gov', 'Fowler', 'Noémie', 'zvuH1AxV', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgardner6u@shareasale.com', 'Gardner', 'Marie-thérèse', '9qTMx0Uff', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kwatkins6v@bloglines.com', 'Watkins', 'Cloé', '5XeX6rEKCBt', '06 38 56 10 54', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lrobertson6w@unc.edu', 'Robertson', 'Mén', 'nqxEjtqwitpi', '06 46 92 72 62', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kthomas6x@stumbleupon.com', 'Thomas', 'Maïwenn', 'PfqzGmA', '06 21 04 51 47', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hholmes6y@purevolume.com', 'Holmes', 'Géraldine', 'Yl8YdlpSC5J', '06 37 57 19 92', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('twashington6z@networksolutions.com', 'Washington', 'Cléopatre', '0OR5jGH3V', '06 23 49 23 40', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sbowman70@tinypic.com', 'Bowman', 'Méryl', 'CXqDyJSa', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jcrawford71@wunderground.com', 'Crawford', 'Audréanne', '2w2FBdH', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pford72@hp.com', 'Ford', 'Aloïs', 'YzZTjNDnq1', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('afuller73@wiley.com', 'Fuller', 'Marie-josée', 'FV07ja2cm4Kw', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aarmstrong74@netlog.com', 'Armstrong', 'Maïlis', 'KFD8NNAjsHwK', '06 30 05 23 60', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cwallace75@biglobe.ne.jp', 'Wallace', 'Daphnée', 'Gprt4jl1N', '06 23 03 72 26', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rwallace76@godaddy.com', 'Wallace', 'Néhémie', 'w09N8K3', '06 25 23 17 19', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ldean77@soundcloud.com', 'Dean', 'Eléa', '2OUvG3AzN', '06 13 96 92 73', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ewelch78@prlog.org', 'Welch', 'Simplifiés', '7zNsc0', '06 16 10 06 47', 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hsimpson79@google.ru', 'Simpson', 'Estève', 'kSuYLF', '06 29 08 16 80', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dward7a@altervista.org', 'Ward', 'Léone', 'xHNvgh7aBRAL', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rhawkins7b@shutterfly.com', 'Hawkins', 'Edmée', 'wuvE5vIa7W', '06 07 16 64 93', 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('egraham7c@typepad.com', 'Graham', 'Styrbjörn', 'U5OdOCY', '06 74 36 39 10', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('klarson7d@sun.com', 'Larson', 'Aurélie', '2KQ9LWczqk6', '06 77 95 45 80', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('shenry7e@deviantart.com', 'Henry', 'Yè', 'fbN0Pj6K8U', '06 94 50 03 28', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('msanders7f@ning.com', 'Sanders', 'Amélie', 'AOHtcZ', null, 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kferguson7g@google.cn', 'Ferguson', 'Régine', 'K5Pno7K5', '06 20 62 75 02', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lburns7h@pbs.org', 'Burns', 'Eliès', 'jnZbm5DG', '06 38 52 88 69', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgreene7i@imdb.com', 'Greene', 'Geneviève', 'kupkkJ1Q7Ix', null, 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('naustin7j@tumblr.com', 'Austin', 'Méghane', '3L5OTrsnO', '06 91 64 54 66', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kwheeler7k@opensource.org', 'Wheeler', 'Mårten', 'yijoHcBnO', '06 66 96 25 54', 0, '7a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('agarza7l@mashable.com', 'Garza', 'Görel', 'GEfo73hQr3Q', '06 53 24 50 16', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('drichards7m@fema.gov', 'Richards', 'Thérèsa', 'zOKCbSRFj', '06 99 58 85 31', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('schavez7n@shop-pro.jp', 'Chavez', 'Daphnée', 'HV0xRYbF', '06 22 22 65 99', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wadams7o@artisteer.com', 'Adams', 'Erwéi', 'wDFAJ5uz7WzG', '06 53 22 76 67', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tgordon7p@desdev.cn', 'Gordon', 'Daphnée', 'XpRjhb', '06 32 80 99 21', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('award7q@addtoany.com', 'Ward', 'Torbjörn', 'F1Elye4', '06 81 35 95 53', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pfox7r@mapquest.com', 'Fox', 'Lyséa', 'aJbc8bkoyD', '06 05 21 80 90', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lmorrison7s@mysql.com', 'Morrison', 'Personnalisée', 'YndeK33z', '06 06 87 95 78', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cholmes7t@indiatimes.com', 'Holmes', 'Dà', '51D0ZbnKmSk', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lcarr7u@moonfruit.com', 'Carr', 'Léone', 'dDp0Evp3', '06 07 66 85 29', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rbaker7v@illinois.edu', 'Baker', 'Torbjörn', 'jqJXIH4', '06 04 01 40 53', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('galexander7w@dropbox.com', 'Alexander', 'Zoé', 'V6MM85', '06 98 20 24 12', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tfernandez7x@reddit.com', 'Fernandez', 'Edmée', 'ZAnhgHYMi', '06 21 01 56 48', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('alittle7y@chronoengine.com', 'Little', 'André', 'GYczzp', null, 0, '6b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('atorres7z@twitter.com', 'Torres', 'Nadège', '0XSApDM5C', '06 18 15 44 02', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('crichards80@plala.or.jp', 'Richards', 'Gaïa', 'uey7LyU', '06 16 57 74 33', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('belliott81@goo.gl', 'Elliott', 'Dafnée', 'sTJSLqAE55', '06 42 45 43 35', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('calexander82@usgs.gov', 'Alexander', 'Garçon', 'gLj6e84jRj', null, 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sallen83@shutterfly.com', 'Allen', 'Mà', '87ETvN', '06 30 93 23 57', 0, '6c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tdunn84@bigcartel.com', 'Dunn', 'Angèle', 'dGi0n4M', '06 11 60 26 99', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kjenkins85@delicious.com', 'Jenkins', 'Maëly', '3k9oClWlo', '06 97 05 74 92', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pferguson86@slideshare.net', 'Ferguson', 'Lèi', '1JAhOY', '06 04 93 46 30', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('csimpson87@odnoklassniki.ru', 'Simpson', 'Yóu', 'cBAbNFi5Bb6', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bmartin88@360.cn', 'Martin', 'Miléna', 'yeJ7iAw', '06 88 36 84 35', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rrose89@is.gd', 'Rose', 'Geneviève', 'oKgynlB6', '06 27 22 99 17', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('agarcia8a@redcross.org', 'Garcia', 'Cléopatre', '6yEcUCXfl3', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cgarza8b@mysql.com', 'Garza', 'Hélène', '0ZDL5BHufedw', '06 42 23 30 17', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('asanders8c@newsvine.com', 'Sanders', 'Méng', '7WyIY3Mi', '06 38 66 49 08', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fsanchez8d@rediff.com', 'Sanchez', 'Maïté', 'n7drM0vH', null, 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kfreeman8e@ameblo.jp', 'Freeman', 'Esbjörn', '38cbMCRaut7m', '06 29 40 57 98', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('balexander8f@merriam-webster.com', 'Alexander', 'Laurélie', 'gGebg7mfM', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tevans8g@sina.com.cn', 'Evans', 'Léonie', 'qUt38B1', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sferguson8h@youtube.com', 'Ferguson', 'Adélaïde', 'q3gTuAP', '06 35 00 67 94', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dschmidt8i@marriott.com', 'Schmidt', 'Mélia', '4clm8XtNpj', '06 08 26 98 65', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ejackson8j@ocn.ne.jp', 'Jackson', 'Laurène', 'RLSdp4z3Kw8', '06 00 08 22 92', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kduncan8k@wunderground.com', 'Duncan', 'Kévina', 'rICXVkk7m', null, 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ichapman8l@cbsnews.com', 'Chapman', 'Adélie', 'T4iBeP2m1s', '06 90 55 76 51', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jboyd8m@geocities.jp', 'Boyd', 'Edmée', '13FC7OoZSGm', null, 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bdaniels8n@salon.com', 'Daniels', 'Béatrice', 'jwrJcDzH', '06 62 55 82 72', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fbell8o@usatoday.com', 'Bell', 'Pål', 'OqcmfUB3', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pharrison8p@miitbeian.gov.cn', 'Harrison', 'Fèi', 'qTp7ly', '06 00 83 52 53', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('chenry8q@nature.com', 'Henry', 'Audréanne', 'ulvzK6', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('prussell8r@umich.edu', 'Russell', 'Marie-josée', 'SDRGlzegO', '06 28 37 64 62', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tpayne8s@upenn.edu', 'Payne', 'Gwenaëlle', 'q8RTNqEKTKO', '06 78 02 98 89', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jcarroll8t@dyndns.org', 'Carroll', 'Cunégonde', 'I5WJmA9u6', '06 27 18 06 33', 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cbennett8u@forbes.com', 'Bennett', 'Noëlla', 'JHzw0rK', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kkelley8v@hhs.gov', 'Kelley', 'Bérénice', 'fnwIFNL30', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dlee8w@un.org', 'Lee', 'Danièle', 'SYUt7rqId3', '06 89 34 09 88', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sburton8x@1688.com', 'Burton', 'Nuó', 'UgXl9xm', '06 83 78 40 56', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('smorgan8y@vinaora.com', 'Morgan', 'Solène', 'F6hArFgmLg', '06 23 12 41 52', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dmills8z@hostgator.com', 'Mills', 'Gaëlle', 'eaUuP9Sn9', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mmoore90@usnews.com', 'Moore', 'Marie-noël', 'lhu2HzVRSPua', '06 28 96 07 06', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('swelch91@indiegogo.com', 'Welch', 'Céline', 'dMgpXS2UDIM', '06 90 44 46 81', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rkennedy92@comcast.net', 'Kennedy', 'Léandre', 'FIKWyAMI', '06 36 69 25 93', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwood93@umich.edu', 'Wood', 'Anaëlle', 'UWDgKtxUP', '06 78 76 20 94', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('acarr94@miitbeian.gov.cn', 'Carr', 'Maïté', 'jLmIrd', '06 54 83 83 60', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('staylor95@amazon.de', 'Taylor', 'Illustrée', 'Pknbn8x8BePx', '06 69 39 02 08', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmoore96@buzzfeed.com', 'Moore', 'Nadège', 'BPELtNj2iwv', '06 12 85 92 08', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bbennett97@businessweek.com', 'Bennett', 'Edmée', '7kayIkLqW6WE', '06 03 02 07 19', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jolson98@livejournal.com', 'Olson', 'Camélia', 'i8sK3ewJm', '06 81 92 04 29', 0, '6b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lwallace99@ustream.tv', 'Wallace', 'Léonie', 'rTr1VJdI7', '06 81 39 30 38', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmills9a@bing.com', 'Mills', 'Mélodie', 'iT27gT0DH', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cgonzales9b@icio.us', 'Gonzales', 'Léonie', 'sW5PyMR', '06 12 32 94 97', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lcarpenter9c@free.fr', 'Carpenter', 'Maïly', 'qLhF2V2nN', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lsmith9d@gravatar.com', 'Smith', 'Pò', '15yN9PqqYMS', '06 96 97 13 52', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mmurphy9e@java.com', 'Murphy', 'Noémie', 'jHJEo8Tb0xS', '06 19 84 62 14', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ilarson9f@army.mil', 'Larson', 'Göran', 'LBC4vnn9e', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('chayes9g@feedburner.com', 'Hayes', 'Andrée', '5S5kSgA', '06 68 99 99 36', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgibson9h@webmd.com', 'Gibson', 'Magdalène', 'vVsUrlWuO7', '06 76 23 26 24', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('stucker9i@de.vu', 'Tucker', 'Noémie', 'NYy4lG', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('grichards9j@posterous.com', 'Richards', 'Tán', 'ZHXARM', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tmoreno9k@wordpress.org', 'Moreno', 'Josée', 'yREZCUcwunG', '06 41 56 08 38', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kwatson9l@amazon.com', 'Watson', 'Naëlle', 'GEFUZaAzO', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('shamilton9m@biglobe.ne.jp', 'Hamilton', 'Marie-hélène', 'GtbYRo', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pblack9n@mail.ru', 'Black', 'Dorothée', '9WwkxT1J', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pgriffin9o@cmu.edu', 'Griffin', 'Annotés', 'QzScZIXS', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tmills9p@senate.gov', 'Mills', 'Béatrice', 'SrddkR5Q', '06 14 38 77 80', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ahamilton9q@ucoz.com', 'Hamilton', 'Maëly', 'zRIDO25OqXnU', '06 07 80 96 73', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lhenderson9r@devhub.com', 'Henderson', 'Noémie', 'YeT3RaUIbfQQ', '06 40 18 96 07', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('shunt9s@scientificamerican.com', 'Hunt', 'Marie-noël', 'CPXfCuo', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mfowler9t@ameblo.jp', 'Fowler', 'Aimée', 'fk0TXTXJ0I', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rrose9u@wikimedia.org', 'Rose', 'Östen', 'nMxw6iaO8', '06 01 47 57 55', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mbowman9v@washingtonpost.com', 'Bowman', 'Ruò', 'cPcy3wNaL', null, 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lharris9w@bbb.org', 'Harris', 'Nélie', 'Db7HvT', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nrodriguez9x@joomla.org', 'Rodriguez', 'Miléna', '0rMiqxt2', '06 76 66 62 53', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dcruz9y@blogger.com', 'Cruz', 'Médiamass', 'y8atYzjjF', '06 43 31 17 02', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jward9z@archive.org', 'Ward', 'Mahélie', 'YRVOFG', '06 31 86 48 14', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mmartina0@list-manage.com', 'Martin', 'Léone', 'p0XqiST5AK', '06 96 30 59 24', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wdavisa1@wsj.com', 'Davis', 'Sòng', 'V3K7Iqw', '06 16 97 66 74', 0, '4a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('anicholsa2@marketwatch.com', 'Nichols', 'Réjane', 'ifWj57', '06 86 44 91 74', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('msancheza3@printfriendly.com', 'Sanchez', 'Zhì', '4OIShnnqZm', '06 61 26 94 79', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rhenrya4@prlog.org', 'Henry', 'Nélie', 'iWtWxQUUibx', '06 90 99 89 52', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('slewisa5@ihg.com', 'Lewis', 'Maëline', 'dEXaFey', '06 81 03 08 64', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('amartina6@newsvine.com', 'Martin', 'Maïlys', 'TNJ6qKeSsd', '06 46 03 64 87', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgraya7@amazon.com', 'Gray', 'Bécassine', 'n2PdYJLphy', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhansona8@ameblo.jp', 'Hanson', 'Vénus', '4VRcYs2R', '06 10 94 40 90', 0, '7a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rmendozaa9@cbc.ca', 'Mendoza', 'Aí', '9ZHElTFtPb', '06 08 84 53 20', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bwilliamsaa@feedburner.com', 'Williams', 'Marie-ève', 'NrU3WcNUgm', '06 72 99 92 05', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhayesab@bravesites.com', 'Hayes', 'Göran', 'AQfveP1zJW', '06 96 61 69 65', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rwestac@hao123.com', 'West', 'Frédérique', 'l6vw1u5Fxso', '06 01 55 68 88', 0, '7b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kweaverad@naver.com', 'Weaver', 'Loïs', 'BygWjNW', '06 59 92 11 13', 0, '6c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dporterae@constantcontact.com', 'Porter', 'Vérane', 'SPf0KIaSoTf', '06 33 86 99 96', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lcruzaf@dagondesign.com', 'Cruz', 'Pénélope', 'EDnWnJxfHmd', '06 72 38 85 89', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nstoneag@bigcartel.com', 'Stone', 'Marie-françoise', '21LgS4Ym2hiS', '06 66 29 34 29', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('amorganah@myspace.com', 'Morgan', 'Dà', 'rk2zNlfEXe6', '06 69 72 04 88', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ealexanderai@cdbaby.com', 'Alexander', 'Cléa', '0yD7Hmy', '06 93 59 15 24', 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('adavisaj@admin.ch', 'Davis', 'Céline', 'pDHT0y0S9562', '06 81 36 48 50', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rramirezak@geocities.jp', 'Ramirez', 'Alizée', 'qiGtE0', '06 07 27 12 47', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rrossal@imageshack.us', 'Ross', 'Mégane', 'XkFEttquEWBL', '06 34 00 78 84', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hharveyam@google.ru', 'Harvey', 'Françoise', 'xge60y', '06 70 04 29 40', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sdiazan@mlb.com', 'Diaz', 'Håkan', 'zuqvyi651tuB', '06 41 20 53 09', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jandrewsao@thetimes.co.uk', 'Andrews', 'Måns', 'UoD4Db1', '06 12 25 06 14', 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sgardnerap@typepad.com', 'Gardner', 'Annotée', 'WqOzp3pq9S', '06 57 21 71 29', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sdixonaq@nih.gov', 'Dixon', 'Yénora', 'lqseHDXtpnB', '06 77 65 66 37', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rwellsar@linkedin.com', 'Wells', 'Inès', '5jS7LUX9J', '06 68 68 57 87', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cellisas@sciencedaily.com', 'Ellis', 'Aimée', 'T5l5nO1hkhS', '06 20 99 95 82', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jkellyat@php.net', 'Kelly', 'Eugénie', 'q1meh8CSybg8', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pramirezau@tripod.com', 'Ramirez', 'Liè', 'DagMbcWk5eQ', '06 71 48 09 97', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('akelleyav@columbia.edu', 'Kelley', 'Adèle', 'ubY50PdS1XDo', null, 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kgrantaw@woothemes.com', 'Grant', 'Garçon', 'k0mFaVU', '06 35 68 68 48', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('erobertsax@blogger.com', 'Roberts', 'Pélagie', 'JlwYEXjHI', '06 88 56 25 54', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ccoleay@theatlantic.com', 'Cole', 'Uò', 'FTevJ2', '06 45 14 19 87', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ascottaz@bizjournals.com', 'Scott', 'Pélagie', 'ZhAWsKLj9', '06 60 92 59 19', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pgarciab0@census.gov', 'Garcia', 'Göran', 'T6xezXJug288', '06 93 32 87 80', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mkelleyb1@businessinsider.com', 'Kelley', 'Personnalisée', 'DNw6G6', '06 32 57 46 09', 0, '4b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ahallb2@g.co', 'Hall', 'Lén', '6y9mxEL', '06 97 54 44 92', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aclarkb3@bing.com', 'Clark', 'Joséphine', 'QfYmxnPp', '06 19 52 65 42', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rdavisb4@wikia.com', 'Davis', 'Magdalène', 'BJAiLcle5G7z', '06 57 55 93 02', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('twellsb5@netscape.com', 'Wells', 'Dù', 'LSojv74ld', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cdixonb6@dell.com', 'Dixon', 'Maïly', 'AjJZ3NI7OIwm', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nfreemanb7@baidu.com', 'Freeman', 'Pénélope', 'LM3kXqhA', '06 54 55 28 98', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hturnerb8@bbb.org', 'Turner', 'Michèle', 'ZbEo7oiB0', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jcoleb9@reverbnation.com', 'Cole', 'Audréanne', '7HZO11S', '06 46 72 22 12', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kmillerba@yelp.com', 'Miller', 'Styrbjörn', 'HJylXTigEyl', '06 18 64 34 16', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mgardnerbb@dot.gov', 'Gardner', 'Océanne', 'AdZ1dQGOT8Gi', '06 86 30 74 17', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mrobertsbc@sogou.com', 'Roberts', 'Lèi', '1bVd5EaBE', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gpetersonbd@unc.edu', 'Peterson', 'Maéna', '3zvDltJBXNn', '06 22 06 01 36', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jsimpsonbe@1688.com', 'Simpson', 'Liè', 'TB2d2gKf', '06 31 88 89 47', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aschmidtbf@stumbleupon.com', 'Schmidt', 'Gösta', 'fa8PgXYPeC', '06 98 82 12 96', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dwoodbg@virginia.edu', 'Wood', 'Dorothée', 'udalj2', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rhudsonbh@elpais.com', 'Hudson', 'Yénora', 'ImH0MlSaIWj9', '06 26 54 99 96', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sevansbi@vk.com', 'Evans', 'Athéna', 'HjWrXz', '06 74 45 59 25', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lbanksbj@java.com', 'Banks', 'Bérangère', 'LpPd2ECx', null, 0, '7a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhillbk@wikipedia.org', 'Hill', 'Gisèle', '510P9npFb0', '06 54 52 86 00', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('epiercebl@seattletimes.com', 'Pierce', 'Gwenaëlle', '6aim9Re9BS', '06 12 98 68 66', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('eramirezbm@geocities.jp', 'Ramirez', 'Léandre', 'wYq1vQHm', '06 65 02 43 45', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('atuckerbn@businessweek.com', 'Tucker', 'Léonore', 'hgCTyxx', '06 41 92 90 53', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ahansenbo@netlog.com', 'Hansen', 'Hélène', 'ltS4KEOM', '06 77 44 92 74', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dfoxbp@wordpress.com', 'Fox', 'Lyséa', '7aFyDdN', null, 0, '6c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ddixonbq@mayoclinic.com', 'Dixon', 'Mélia', 'dE4PMHLdohic', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rdavisbr@blog.com', 'Davis', 'Aurélie', 'zxAnWrJG74', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgibsonbs@gov.uk', 'Gibson', 'Marie-hélène', 'D222OHoX', '06 60 46 28 57', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jallenbt@opera.com', 'Allen', 'Célia', 'Ah5YWE', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sperrybu@nps.gov', 'Perry', 'Dù', 'Xo5gWFPjUN', '06 21 72 48 62', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hmitchellbv@1und1.de', 'Mitchell', 'Nélie', 'ppRy6ANOL', '06 93 85 62 50', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rwatsonbw@chron.com', 'Watson', 'Faîtes', 'hGK8nm', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sbutlerbx@cnbc.com', 'Butler', 'Stéphanie', 'e8VyJgjsYw7', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jshawby@cnbc.com', 'Shaw', 'Loïca', 'gSMBfPwK6ODn', '06 52 33 09 66', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hdanielsbz@free.fr', 'Daniels', 'Almérinda', 'pGMZoEupYa', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rsandersc0@blog.com', 'Sanders', 'Nadège', 'RAF9Bkp6c', '06 70 27 84 06', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mgrahamc1@t.co', 'Graham', 'Maïlys', 'nKrhOVv', '06 93 02 27 72', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wkennedyc2@joomla.org', 'Kennedy', 'Gaïa', 'Y5l6U6Q', '06 05 11 75 48', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mperkinsc3@mit.edu', 'Perkins', 'Jú', 'XeX73X8EUW0', '06 09 59 85 91', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ahuntc4@pagesperso-orange.fr', 'Hunt', 'Léa', 'vlSxBobe0ex', '06 11 86 06 07', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('acarrollc5@deliciousdays.com', 'Carroll', 'Måns', 'IMmIMV', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cjohnstonc6@amazon.co.jp', 'Johnston', 'Illustrée', '9sp09d3xMIh', null, 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jstephensc7@blogger.com', 'Stephens', 'Eloïse', 'eyhefBOoF', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rreidc8@yellowpages.com', 'Reid', 'Pénélope', '5vZ0RmAyu0M', null, 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('erosec9@bizjournals.com', 'Rose', 'Märta', 'k5F914ipQb4', '06 99 72 93 63', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lreidca@godaddy.com', 'Reid', 'Loïc', 'aE8SrSa5', '06 69 09 02 47', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ttaylorcb@cyberchimps.com', 'Taylor', 'Östen', 'CwyY27rn85ak', '06 29 72 39 23', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bgomezcc@dropbox.com', 'Gomez', 'Gösta', 'zK9c8S6wB', '06 38 93 82 10', 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sdunncd@altervista.org', 'Dunn', 'Marlène', 'cBxunM', '06 44 35 66 16', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tvasquezce@livejournal.com', 'Vasquez', 'Naéva', 'U3E0c0Z33', '06 09 09 74 34', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('eblackcf@dyndns.org', 'Black', 'Noëlla', 'H0kOGi', '06 73 53 28 12', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dwebbcg@artisteer.com', 'Webb', 'Aurélie', 'ZxAR6Qp', '06 21 18 80 79', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lwashingtonch@w3.org', 'Washington', 'Styrbjörn', 'e80433cc', '06 38 35 37 44', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhansenci@mashable.com', 'Hansen', 'Wá', 'aSXdk9', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ldanielscj@independent.co.uk', 'Daniels', 'Cunégonde', '2HfziF', '06 13 38 34 98', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tjohnsonck@weebly.com', 'Johnson', 'Noëlla', 'VlC6F1Emdn', '06 76 02 97 12', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dgutierrezcl@google.cn', 'Gutierrez', 'Valérie', 'Oq2ysJ2T', '06 60 40 72 25', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lcolemancm@dailymotion.com', 'Coleman', 'Véronique', 'a4IyFcsBvR12', '06 91 46 60 74', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('amorriscn@smh.com.au', 'Morris', 'Loïca', 'HMBthN8S91d8', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bsimmonsco@mlb.com', 'Simmons', 'Geneviève', 'LaVG32hpBTXB', '06 40 41 85 26', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sandrewscp@youtube.com', 'Andrews', 'Börje', 'XDgqqxOAQu', '06 22 19 97 79', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('twilliscq@imgur.com', 'Willis', 'Östen', 'F2t59H3', '06 75 11 56 21', 0, '6a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mgriffincr@a8.net', 'Griffin', 'Marlène', 'FWcvAns7MHQK', '06 55 65 35 20', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rgarrettcs@va.gov', 'Garrett', 'Desirée', 'Zzo0r8m', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cwhitect@wufoo.com', 'White', 'Léone', 'xPZUHn', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cdanielscu@flickr.com', 'Daniels', 'Yú', 'igWUbYb', '06 72 35 15 86', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('saustincv@narod.ru', 'Austin', 'Cinéma', 's9z8vEI', '06 83 61 80 82', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bfostercw@xrea.com', 'Foster', 'Eugénie', 'RiKsMNyMzlHP', '06 23 33 48 09', 0, '4c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mkellycx@biblegateway.com', 'Kelly', 'Stévina', 'x195KkauwE', '06 88 19 69 86', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bjordancy@pcworld.com', 'Jordan', 'Mén', 'LA5qULnB', '06 04 09 66 56', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rfostercz@archive.org', 'Foster', 'Adélaïde', 'kZNJ0Jjef', '06 43 32 63 16', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vfullerd0@nbcnews.com', 'Fuller', 'Eléonore', 'R0PbgA', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwoodsd1@virginia.edu', 'Woods', 'Pò', 'hcsSYGtl1f', null, 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('eberryd2@nasa.gov', 'Berry', 'Håkan', 'BCBWhu5Sqv', '06 82 71 35 29', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jortizd3@ezinearticles.com', 'Ortiz', 'Örjan', 'K2OLg56LB5', '06 70 24 40 46', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tthompsond4@home.pl', 'Thompson', 'Médiamass', 'jNYXhsVjgY', '06 12 86 33 13', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('amurphyd5@gmpg.org', 'Murphy', 'Naëlle', 'jxwR8vs2EQg', '06 34 01 64 39', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nriverad6@cocolog-nifty.com', 'Rivera', 'Océanne', 'v6mgXZF', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('poliverd7@cnn.com', 'Oliver', 'Lucrèce', '3TBWVwX1', '06 14 77 33 88', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('madamsd8@sina.com.cn', 'Adams', 'Vénus', 'onlHBrG0rO', '06 69 78 53 81', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jfoxd9@mapquest.com', 'Fox', 'Camélia', 'YVdw8U9yMY5', '06 02 06 65 10', 0, '6b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kwagnerda@sciencedirect.com', 'Wagner', 'Garçon', 'iZwghA6Y', '06 60 21 18 27', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('scunninghamdb@simplemachines.org', 'Cunningham', 'Pélagie', 'bEHMcXrU9t', '06 97 69 75 47', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('plarsondc@salon.com', 'Larson', 'Aí', 'VYZygTeP', '06 80 95 74 22', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('salexanderdd@youku.com', 'Alexander', 'Mélanie', 'Mi4ZdbTBzDfw', '06 63 45 83 43', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tcooperde@sina.com.cn', 'Cooper', 'Sélène', 'UPn7agBjro', '06 53 43 72 44', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ericedf@weebly.com', 'Rice', 'Anaé', 'CFeYEJM42WiF', '06 85 21 48 36', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('esullivandg@timesonline.co.uk', 'Sullivan', 'Tú', 'hkF08a', '06 30 90 67 69', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bsullivandh@economist.com', 'Sullivan', 'Amélie', '3yw25rWI', '06 47 65 80 30', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmcdonalddi@printfriendly.com', 'Mcdonald', 'Andréa', 'CUZIpPetqb8', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhernandezdj@about.com', 'Hernandez', 'Lyséa', 'uVBAy0SIl40', '06 07 92 47 88', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bcampbelldk@yale.edu', 'Campbell', 'Loïca', 'F9hTlmWyBH', '06 53 60 33 31', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('treiddl@godaddy.com', 'Reid', 'Cécilia', 'KULerf', '06 96 50 61 20', 0, '6b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gmorrisdm@npr.org', 'Morris', 'Bérénice', '5tp8sYZVsUoi', '06 05 85 61 95', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('msimpsondn@oaic.gov.au', 'Simpson', 'Clémence', 'IfZAje8q6d9', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lwashingtondo@nydailynews.com', 'Washington', 'Gisèle', '5vQevUhq', '06 88 65 93 00', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jdaydp@homestead.com', 'Day', 'Célia', 'xGad0C', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tharveydq@ebay.co.uk', 'Harvey', 'Eugénie', 'eRo6IjKZs8', '06 08 89 84 08', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('raustindr@shop-pro.jp', 'Austin', 'Personnalisée', 'X5VgOPxx3', '06 86 61 38 30', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jramirezds@apache.org', 'Ramirez', 'Maïwenn', 'OiyBvf', '06 81 29 43 67', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhansondt@unblog.fr', 'Hanson', 'Ruì', '18YrgAb', '06 92 08 04 19', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lthompsondu@prweb.com', 'Thompson', 'Eléonore', 'ihybv5JrK', '06 19 26 67 17', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rrichardsondv@twitter.com', 'Richardson', 'Maïlys', 'uoHxIx8', '06 12 43 95 18', 0, '6c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jdunndw@usda.gov', 'Dunn', 'Laurène', 'jDtW8AWqoVKQ', '06 32 32 62 65', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bscottdx@biblegateway.com', 'Scott', 'André', 'xLZiAGnh52F', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jpiercedy@webnode.com', 'Pierce', 'Kallisté', '2QrLWXSKtFhr', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dwillisdz@chronoengine.com', 'Willis', 'Marie-françoise', 'cvs6yiG', '06 78 09 41 54', 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tmorrise0@utexas.edu', 'Morris', 'Marie-noël', 'BdjPwjuAV51', '06 36 88 35 91', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jburtone1@sbwire.com', 'Burton', 'Stéphanie', 'pw396oscue', '06 90 83 33 09', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dortize2@unc.edu', 'Ortiz', 'Réjane', 'FWgk1sO', '06 28 33 90 49', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('drobinsone3@tiny.cc', 'Robinson', 'Clémence', 'YP0YcqN', '06 73 98 94 28', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cjohnsone4@globo.com', 'Johnson', 'Maëlyss', 'bB7kxXEHPWl', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rblacke5@cdbaby.com', 'Black', 'Mårten', '2o8S1BYNL', null, 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jrileye6@meetup.com', 'Riley', 'Loïca', 'f90rbb69', '06 90 15 72 56', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('stuckere7@adobe.com', 'Tucker', 'Laurène', 'DkOjjOQ6nmx', '06 70 68 12 22', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('snguyene8@apache.org', 'Nguyen', 'Örjan', '0G29rm', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('knicholse9@jalbum.net', 'Nichols', 'Dorothée', 'Ld7TD14ruh', '06 32 58 18 31', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jcoxea@oakley.com', 'Cox', 'Cunégonde', 'ysx27hW9bQ', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rdanielseb@yandex.ru', 'Daniels', 'Håkan', 'qlDMtQbW', null, 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hwebbec@examiner.com', 'Webb', 'Josée', 'TrgrejW', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jolsoned@tamu.edu', 'Olson', 'Gisèle', '6bjS0KAN1', '06 27 94 83 15', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hlawrenceee@cdbaby.com', 'Lawrence', 'Athéna', 'dFKoVSqq', '06 71 04 72 05', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('blittleef@behance.net', 'Little', 'Inès', 'LIPtYrem', '06 88 93 42 07', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhuntereg@plala.or.jp', 'Hunter', 'Mà', 'paSJXKbUy2Nq', '06 52 67 80 59', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nsanderseh@mediafire.com', 'Sanders', 'Gisèle', 'WuWBEy9piuy', '06 27 79 74 32', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ahamiltonei@macromedia.com', 'Hamilton', 'Mén', 'Hatt3UA', '06 54 81 05 79', 0, '7a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jfosterej@smugmug.com', 'Foster', 'André', 'jFZ0rQ5P', '06 24 41 91 12', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('eramosek@creativecommons.org', 'Ramos', 'Pénélope', 'heVWNp2wU2Wi', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rharveyel@51.la', 'Harvey', 'Mélys', '3l3HSzi', '06 12 37 46 88', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ksnyderem@de.vu', 'Snyder', 'Styrbjörn', '9UfAnor12', '06 13 83 63 88', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mburtonen@vk.com', 'Burton', 'Andréa', '0pOFcwsK', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dharpereo@icio.us', 'Harper', 'Bécassine', 'npXk8G2QaB0', '06 92 48 51 50', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgomezep@merriam-webster.com', 'Gomez', 'Loïc', 'FwlvpHbFJN18', null, 0, '4c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('adaviseq@amazon.co.jp', 'Davis', 'Angèle', 'lKme6K2s4m', '06 93 55 86 93', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vwrighter@homestead.com', 'Wright', 'Måns', 'iNXGUv', '06 81 40 41 49', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tcooperes@gravatar.com', 'Cooper', 'Clémence', 'kwISDbvBm3m', '06 32 72 61 55', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dcooket@amazon.co.uk', 'Cook', 'Chloé', 'mP4GfFn', '06 89 29 11 41', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pphillipseu@google.com.br', 'Phillips', 'Léandre', 'ThFyLC2Cx18', '06 79 63 66 99', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rcarpenterev@slashdot.org', 'Carpenter', 'Pål', 'a3guMZJv', '06 97 84 69 77', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ldunnew@networkadvertising.org', 'Dunn', 'Kù', 'ultQOMRTwr', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gbowmanex@google.de', 'Bowman', 'Méghane', 'hD4VGfzMBx', '06 45 92 34 75', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jcoleey@live.com', 'Cole', 'Renée', 'kPTTSOf', '06 59 37 35 42', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ghansenez@accuweather.com', 'Hansen', 'Mélina', 'rFCo7heJ', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fthomasf0@state.tx.us', 'Thomas', 'Crééz', 'MQbsvsBnqw', '06 92 23 15 86', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ablackf1@livejournal.com', 'Black', 'Eléonore', 'AwfIFZ7', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('arichardsf2@google.com.au', 'Richards', 'Almérinda', 'shkD1sJt6tv', '06 89 89 53 29', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('phowellf3@disqus.com', 'Howell', 'Céline', 'saXy0Adzp', '06 91 99 44 72', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jbryantf4@sohu.com', 'Bryant', 'Joséphine', 'XJkvp3xGjCY', '06 09 13 99 99', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhernandezf5@hubpages.com', 'Hernandez', 'Cécilia', 'AwnlUc5l5', null, 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sdeanf6@cdbaby.com', 'Dean', 'Andréanne', 'jnqgYIt1Gz', null, 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pdiazf7@ezinearticles.com', 'Diaz', 'Personnalisée', 'CrD49BWw7Mc', '06 83 95 54 64', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dcarrollf8@answers.com', 'Carroll', 'Geneviève', 'DoWrX1Xex', '06 41 18 50 65', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vgrantf9@census.gov', 'Grant', 'Gaëlle', 'klJ7GriC0ptp', '06 78 31 97 93', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ahowardfa@baidu.com', 'Howard', 'Séverine', 'MQySqJQR', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('creedfb@huffingtonpost.com', 'Reed', 'Andrée', 'PR6XMRe1OKGD', '06 63 76 20 79', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('madamsfc@omniture.com', 'Adams', 'Örjan', 'jEA5Mcbng', '06 51 82 74 54', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tchavezfd@accuweather.com', 'Chavez', 'Uò', 'kzE8Dg', '06 51 31 93 53', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dlarsonfe@marriott.com', 'Larson', 'Eléonore', 'PhLYSlYMzbx0', '06 86 75 74 16', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('alawrenceff@nba.com', 'Lawrence', 'Maëline', 're7QQA5', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cporterfg@nydailynews.com', 'Porter', 'Cunégonde', '4gw1RV27eT', '06 68 80 75 27', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aallenfh@tamu.edu', 'Allen', 'Ráo', 'GJfZKASTsgWG', '06 96 63 08 13', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('enelsonfi@theatlantic.com', 'Nelson', 'Sélène', 'w5NXVdahZmim', '06 08 97 38 81', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('awrightfj@sourceforge.net', 'Wright', 'Maéna', 'msUlE1Gkq', null, 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lweaverfk@bloglovin.com', 'Weaver', 'Gisèle', '0NefXQ', null, 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pshawfl@imgur.com', 'Shaw', 'Ruò', 'tvFrcmo9', '06 85 22 75 68', 0, '7b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dsimmonsfm@bandcamp.com', 'Simmons', 'Åslög', 'z8KGtPwGMKa', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cfranklinfn@pen.io', 'Franklin', 'Léonore', 'ljyknfMffR', '06 31 80 75 29', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rdayfo@nationalgeographic.com', 'Day', 'Styrbjörn', 'rdanCbx', null, 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lbrownfp@vinaora.com', 'Brown', 'Inès', 'J2wHUA', '06 61 46 35 71', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pfergusonfq@cloudflare.com', 'Ferguson', 'Vérane', 'qjeXAjHZ4HX', '06 91 21 72 28', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cyoungfr@surveymonkey.com', 'Young', 'Börje', '3x8jzzYBWM5H', '06 31 03 21 78', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nwebbfs@paypal.com', 'Webb', 'Åslög', 'Ev84ccYwobU', '06 58 88 29 57', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rriceft@studiopress.com', 'Rice', 'Bérangère', 'JbsfPNb5XNu', '06 06 46 36 39', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kkellyfu@dropbox.com', 'Kelly', 'Torbjörn', 'WGWlfj4TQs0', '06 58 73 83 19', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kedwardsfv@ucsd.edu', 'Edwards', 'Rachèle', 'ScicmM', '06 05 25 77 59', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ccooperfw@rambler.ru', 'Cooper', 'Simplifiés', 'kMMee1z', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pramosfx@examiner.com', 'Ramos', 'Örjan', 'USiFatT7l9', '06 67 83 20 62', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jparkerfy@kickstarter.com', 'Parker', 'Clémence', 'SE2h2xh', null, 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tpowellfz@auda.org.au', 'Powell', 'Valérie', 'r6uaYmapw', '06 81 73 27 72', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmorgang0@biglobe.ne.jp', 'Morgan', 'Marie-josée', 'RdkMGHpB', '06 05 89 67 44', 0, '6c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rchavezg1@51.la', 'Chavez', 'Estève', 'HQv6E1JT2ab', '06 77 08 66 99', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kcarterg2@yahoo.co.jp', 'Carter', 'Mårten', 'kpV1vZBnFDIf', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lnguyeng3@example.com', 'Nguyen', 'Mégane', 'KlFxwS', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jbutlerg4@senate.gov', 'Butler', 'Ruò', 'YHMd4v4', null, 0, '6a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wchapmang5@hexun.com', 'Chapman', 'Faîtes', 'p2Xz4UWmU3h', '06 48 76 70 54', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aramirezg6@blogger.com', 'Ramirez', 'Gaëlle', '0tOA0Sc5b', '06 34 67 92 47', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dreedg7@domainmarket.com', 'Reed', 'Gösta', '05KGyaEIDSF', null, 0, '7b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kolsong8@whitehouse.gov', 'Olson', 'Mårten', 'vxvz2bv', '06 51 16 69 67', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jpetersong9@deliciousdays.com', 'Peterson', 'André', 'OlOQqK3elaTb', '06 47 78 11 17', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jpetersga@histats.com', 'Peters', 'Mélanie', 'E3EdlmRZd', '06 46 15 34 86', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhayesgb@blog.com', 'Hayes', 'Mélodie', 'xGOTkgQH', '06 28 56 52 54', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aparkergc@jugem.jp', 'Parker', 'Bérangère', 'sL53Fv2kX', '06 99 87 93 22', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('igrahamgd@bbc.co.uk', 'Graham', 'Aurélie', 'Ls0NiA', '06 59 81 61 30', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhowardge@hugedomains.com', 'Howard', 'Bérénice', 'sWESV0', '06 25 45 44 98', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dtaylorgf@sohu.com', 'Taylor', 'Véronique', 'pnWXJ3PfZGM', '06 05 89 21 29', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('msandersgg@cdc.gov', 'Sanders', 'Léa', 'S82FysHak', '06 15 19 52 34', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mbrowngh@hao123.com', 'Brown', 'Naëlle', 'kGs5qcoaJ', '06 13 80 11 64', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aaustingi@qq.com', 'Austin', 'Néhémie', '0ZV3eo', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mcarrgj@unesco.org', 'Carr', 'Cléopatre', 'EJfL9GHNkgc', '06 32 49 68 27', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bolsongk@xrea.com', 'Olson', 'Mårten', 'DZX1jUnI', '06 41 87 71 82', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('scartergl@sphinn.com', 'Carter', 'Adélaïde', '335ckBy6', null, 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wdanielsgm@chron.com', 'Daniels', 'Sélène', 'SIP299Clt79r', '06 10 16 09 50', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('elynchgn@adobe.com', 'Lynch', 'Anaé', 'HPMio2r', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('klewisgo@narod.ru', 'Lewis', 'Maéna', '3MhAZwb8wES', '06 55 75 12 13', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rfieldsgp@blogtalkradio.com', 'Fields', 'Marie-françoise', 'WlE9VIvNAvRq', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sburnsgq@fastcompany.com', 'Burns', 'Andréanne', 'QM5nQXZ', '06 49 25 10 71', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhallgr@noaa.gov', 'Hall', 'Östen', 'lU4qbl2E8LOe', '06 87 90 02 08', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lperrygs@techcrunch.com', 'Perry', 'Josée', '5jIDr41e5', '06 02 84 69 61', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jleegt@fotki.com', 'Lee', 'Amélie', '0cULAbM', '06 49 56 10 74', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hknightgu@de.vu', 'Knight', 'Adélie', 'SGho5K4Iul6', '06 97 90 23 33', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jperkinsgv@patch.com', 'Perkins', 'Dorothée', 'DHwVjCs0', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rrossgw@reference.com', 'Ross', 'Vérane', 'NVrkkxSY31', '06 40 20 95 26', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gphillipsgx@seattletimes.com', 'Phillips', 'Mélodie', 'r9cCW847Qm', '06 99 38 49 57', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('arussellgy@reuters.com', 'Russell', 'Lucrèce', 'g3TYfz', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dfranklingz@blog.com', 'Franklin', 'Mårten', 'XhNCZ1', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ecollinsh0@reference.com', 'Collins', 'Mélissandre', 'BUKSbZ', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mschmidth1@miibeian.gov.cn', 'Schmidt', 'Régine', 'KIUoA1Nw', '06 27 61 17 01', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sandersonh2@amazon.de', 'Anderson', 'Håkan', 'FXHmW71T', '06 67 32 12 37', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('howensh3@skyrock.com', 'Owens', 'Salomé', 'EnTasx', '06 58 30 49 15', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jcunninghamh4@paypal.com', 'Cunningham', 'Intéressant', 'n9lqd6Qyb', '06 60 13 12 44', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mcastilloh5@noaa.gov', 'Castillo', 'Aimée', 'VmjzSiEldd', null, 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lpierceh6@go.com', 'Pierce', 'Cinéma', 'CbggIutgOL05', '06 77 79 75 61', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jbishoph7@unicef.org', 'Bishop', 'Daphnée', '9gBmOE', '06 27 82 05 97', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('apierceh8@myspace.com', 'Pierce', 'Valérie', 'ycDNdS', '06 29 64 65 60', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sharth9@soundcloud.com', 'Hart', 'Lèi', 'oha5Gs', '06 14 66 18 97', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kfosterha@1und1.de', 'Foster', 'Kù', 'xbSQWuMPx7qy', '06 71 93 24 30', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mperezhb@mayoclinic.com', 'Perez', 'Lén', 'FMJmf7uk', '06 74 20 72 99', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jbankshc@deliciousdays.com', 'Banks', 'Annotée', 'hJhWj6cU', '06 84 52 17 45', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('clopezhd@nydailynews.com', 'Lopez', 'Véronique', 'i8lmGN', '06 13 23 94 16', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('afowlerhe@google.com.br', 'Fowler', 'Åsa', '76lKvifM', null, 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mmccoyhf@xrea.com', 'Mccoy', 'Yú', 'Lb0EOVCtjh', '06 66 40 31 82', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('epattersonhg@indiegogo.com', 'Patterson', 'Océane', 'rbxq4IquObsZ', '06 25 92 87 26', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bgonzaleshh@freewebs.com', 'Gonzales', 'Adèle', '8wStpOej', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('anguyenhi@jalbum.net', 'Nguyen', 'Göran', 'ijqaKW', null, 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mtuckerhj@amazon.de', 'Tucker', 'Léana', 'w1MLiBN', '06 82 65 06 40', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('iramoshk@baidu.com', 'Ramos', 'Danièle', 'khUF5SjiDQB', '06 26 43 19 73', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('krobertshl@cnbc.com', 'Roberts', 'Örjan', 'cCcTAEWhqhT3', '06 41 30 93 02', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmillerhm@gizmodo.com', 'Miller', 'Nuó', 'qMyLZzlBw1', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hschmidthn@woothemes.com', 'Schmidt', 'Alizée', 'htQVn6w2Tt', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sgonzalezho@businessinsider.com', 'Gonzalez', 'Kuí', 'L3OK15', '06 91 31 99 19', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('framirezhp@ox.ac.uk', 'Ramirez', 'Annotée', 'oKowzu2EPy', '06 94 65 70 67', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cjohnsonhq@eventbrite.com', 'Johnson', 'Valérie', 'fe8v2H2Uxf', '06 59 53 33 33', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jdeanhr@gizmodo.com', 'Dean', 'Agnès', '3l6xwYH75', '06 46 51 02 38', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmoorehs@slate.com', 'Moore', 'Françoise', 'SNsNCRR', '06 35 01 89 71', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('marmstronght@mozilla.com', 'Armstrong', 'Célia', 'vtXdoi9egyfo', '06 36 51 91 28', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rgeorgehu@yahoo.co.jp', 'George', 'Léana', 'jxFvVznv', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('awelchhv@ibm.com', 'Welch', 'Yóu', 'xUBjCMcKd', '06 73 70 27 92', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dmillshw@irs.gov', 'Mills', 'Clélia', 'n9Nhq58', '06 03 78 30 22', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hbrookshx@craigslist.org', 'Brooks', 'Régine', 'dVmRebKa7Od', '06 09 18 18 74', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ldiazhy@usa.gov', 'Diaz', 'Athéna', 'hWlJmJ', '06 93 02 13 62', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jedwardshz@mashable.com', 'Edwards', 'Maëlla', 'QpNbGSliE5wq', '06 41 77 88 80', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kwatkinsi0@walmart.com', 'Watkins', 'Camélia', 'Ol19kO', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rhamiltoni1@netlog.com', 'Hamilton', 'Cléopatre', 'GGZvlX', '06 39 74 83 71', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmartini2@cdc.gov', 'Martin', 'Estée', 'PawjyNCiZ', '06 84 84 39 10', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lwelchi3@psu.edu', 'Welch', 'Maëline', 'SBaS1WnSv', '06 18 68 38 29', 0, '7b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bwagneri4@parallels.com', 'Wagner', 'Mélia', '1P0594pF', '06 81 73 18 33', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmorrisi5@uol.com.br', 'Morris', 'Zoé', 'Vm2nuq', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wboydi6@vinaora.com', 'Boyd', 'Mélia', 'MKRdFayt', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tcarteri7@over-blog.com', 'Carter', 'Adélaïde', '1YLodemlAo', '06 99 39 20 25', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jryani8@mapy.cz', 'Ryan', 'Angélique', 'DSOa292HBS', null, 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sgeorgei9@parallels.com', 'George', 'Mà', 'VJcRVGB645rX', '06 17 44 52 44', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ecastilloia@stanford.edu', 'Castillo', 'Yénora', 'SsL80ZbL5n', '06 55 04 52 62', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rgrayib@yandex.ru', 'Gray', 'Maëlle', 'zjqFzVbSHGK', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jreedic@privacy.gov.au', 'Reed', 'Léone', 'i54t9c', '06 94 81 92 58', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jspencerid@illinois.edu', 'Spencer', 'Clélia', 'VwLDQlE', '06 58 76 56 59', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mlaneie@auda.org.au', 'Lane', 'Lén', 'RKIaVLRIbh', '06 82 40 64 09', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('athomasif@guardian.co.uk', 'Thomas', 'Kallisté', 'Er6Z9JR', '06 14 36 34 00', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('alopezig@wisc.edu', 'Lopez', 'Anaël', 'D7VeWs', '06 44 90 34 81', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('afranklinih@cafepress.com', 'Franklin', 'Cécile', 'vNQDVeT', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wreynoldsii@friendfeed.com', 'Reynolds', 'Andrée', 'RImenPoAx4', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rmurphyij@about.me', 'Murphy', 'Kévina', 'ZOf87VSq', null, 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rturnerik@php.net', 'Turner', 'Pò', 'Mow0YxahqK', '06 06 10 17 63', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dowensil@fastcompany.com', 'Owens', 'Pål', 'Bt3v5fEr6', '06 79 40 09 09', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dknightim@posterous.com', 'Knight', 'Dù', 'm4356xaU3ng', '06 31 37 79 08', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hramosin@mlb.com', 'Ramos', 'Åslög', 'qKe1uaQ', '06 49 40 65 76', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ecarrio@aboutads.info', 'Carr', 'Josée', '5hTLcgMIglb', '06 28 40 33 12', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwilliamsonip@examiner.com', 'Williamson', 'Görel', 'iP7Qv3', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hhughesiq@prnewswire.com', 'Hughes', 'Bénédicte', 'js241oSEPyM', '06 95 01 74 90', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('chicksir@tinypic.com', 'Hicks', 'Léa', 'jJvxk7GnQr', '06 94 19 39 77', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aknightis@columbia.edu', 'Knight', 'Måns', 'DiASyxi0AFG', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aperkinsit@plala.or.jp', 'Perkins', 'Cléopatre', 'HLJYV20', '06 54 00 84 81', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vmoralesiu@marketwatch.com', 'Morales', 'Bérengère', '8c7xiuX', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mwhiteiv@vimeo.com', 'White', 'Bécassine', 'UlYh5uB2Ec', '06 38 36 02 95', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mjonesiw@gmpg.org', 'Jones', 'Loïca', 'UWUDN0wN4D', '06 01 73 54 81', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vpayneix@hc360.com', 'Payne', 'Dafnée', 'zsFZo49eoUh', '06 18 11 76 58', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('swhiteiy@businesswire.com', 'White', 'Salomé', 'LzDqZu9o', '06 47 62 81 25', 0, '4b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lcastilloiz@umn.edu', 'Castillo', 'Táng', 'RyKMXT3gIn', '06 67 48 37 02', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dlarsonj0@dropbox.com', 'Larson', 'Garçon', 'w96Y9B2davH', '06 97 54 49 71', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('swagnerj1@opera.com', 'Wagner', 'Mélodie', 'QmXR1VkxtH', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pharrisj2@baidu.com', 'Harris', 'Josée', '81VzJY6Bztv', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fnelsonj3@princeton.edu', 'Nelson', 'Kévina', 'g8lTJc', '06 22 97 14 98', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ephillipsj4@ted.com', 'Phillips', 'Liè', '6jbXStXG3Z', '06 70 01 69 31', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('amontgomeryj5@springer.com', 'Montgomery', 'Börje', '7J2Jfzbbx', '06 01 24 93 73', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lmontgomeryj6@jalbum.net', 'Montgomery', 'Méline', 'FRVaOBf9qh', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cellisj7@census.gov', 'Ellis', 'Miléna', 'Zg1TLJHez1', '06 81 01 16 02', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jsimsj8@webs.com', 'Sims', 'Bérangère', 'JAIzASDOOJ', '06 50 50 96 35', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('afosterj9@facebook.com', 'Foster', 'Gaëlle', 'd2pJcV7Y', '06 57 95 00 37', 0, '7a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rgutierrezja@bigcartel.com', 'Gutierrez', 'Marylène', 'fiNaE9e', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bedwardsjb@odnoklassniki.ru', 'Edwards', 'Cléopatre', 'A9Xysv5I', '06 67 91 19 52', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('salexanderjc@upenn.edu', 'Alexander', 'Cinéma', 'uixOfgWB0wD', '06 13 36 99 05', 0, '4c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cellisjd@hao123.com', 'Ellis', 'Björn', 'InGMCE7VI1o', '06 87 69 77 66', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nmitchellje@yahoo.co.jp', 'Mitchell', 'Lóng', 'fYbwjze', '06 69 16 90 31', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jfrazierjf@aol.com', 'Frazier', 'Célia', '8TceXla747', '06 97 85 67 17', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mmillsjg@themeforest.net', 'Mills', 'Mélina', 'Kl0GObw', '06 72 22 78 31', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jbowmanjh@utexas.edu', 'Bowman', 'Kévina', 'JgsfbrBoVb', '06 79 13 15 45', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bdiazji@xrea.com', 'Diaz', 'Mylène', 'vZuT1Db', '06 68 96 33 06', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ffranklinjj@imdb.com', 'Franklin', 'Marie-françoise', 'OtREz4ndovh', '06 59 65 95 99', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tbowmanjk@last.fm', 'Bowman', 'Åsa', 'gWt7Be2mVf', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mtorresjl@webmd.com', 'Torres', 'Mélina', 'Yy9UJ8xh', '06 42 05 66 48', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jdavisjm@zdnet.com', 'Davis', 'Loïc', 'anuFom2PkA', '06 90 21 98 09', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lfosterjn@mozilla.com', 'Foster', 'Nélie', 'YgsEA5db', '06 12 34 20 87', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhernandezjo@sogou.com', 'Hernandez', 'Clémence', 'jlNP5c2pZ2Og', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jlawrencejp@chicagotribune.com', 'Lawrence', 'Estève', 'pjJbuTpDbqGK', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mhughesjq@friendfeed.com', 'Hughes', 'Dù', 'mxBE1Xsy2iPu', '06 07 82 86 53', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ccollinsjr@blogspot.com', 'Collins', 'Dà', 'TFxTjgvvuU5', '06 54 76 12 36', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wpalmerjs@amazon.de', 'Palmer', 'Marylène', 'wPVC0D850Jp', '06 92 14 37 99', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cjenkinsjt@salon.com', 'Jenkins', 'Chloé', 'pDJxThNYIBP', '06 66 83 84 21', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jroseju@npr.org', 'Rose', 'Cunégonde', 'lJK1TNRhx2sX', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sedwardsjv@weebly.com', 'Edwards', 'Geneviève', 'eCckqLntp', '06 29 53 04 63', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lfosterjw@tumblr.com', 'Foster', 'Léa', 'ir2SrcjLpK', '06 45 30 33 39', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('acooperjx@yahoo.com', 'Cooper', 'Almérinda', 'GLkyDvdB', '06 30 89 32 32', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bbelljy@hud.gov', 'Bell', 'Régine', 'yN6JDQ10vv', '06 15 02 65 72', 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('msimsjz@upenn.edu', 'Sims', 'Kù', 'ybkOUPjVqB', '06 56 82 09 45', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rpiercek0@scribd.com', 'Pierce', 'Marylène', 'TisH0uYAD', '06 23 14 66 33', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pcunninghamk1@imdb.com', 'Cunningham', 'Lèi', 'n7g2hR5uRqMR', '06 73 96 64 78', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bfernandezk2@soup.io', 'Fernandez', 'Estève', 'rp6Am2VI9G', '06 01 28 12 97', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kchavezk3@harvard.edu', 'Chavez', 'Gérald', 'H5BXcSG', '06 44 01 71 02', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bjohnsonk4@goo.gl', 'Johnson', 'Mårten', '5JpUZhq8', '06 88 79 76 74', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pchavezk5@nhs.uk', 'Chavez', 'Jú', 'WqgypDQkmuaa', '06 90 26 73 73', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hfisherk6@nhs.uk', 'Fisher', 'Véronique', 'SpMGwL', '06 21 99 42 20', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ttorresk7@yelp.com', 'Torres', 'Josée', 'Ubd2JS', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dpaynek8@sphinn.com', 'Payne', 'Garçon', '65GaRY1jYqp', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgarciak9@eventbrite.com', 'Garcia', 'Mélina', 'tjizzDHsf', '06 68 22 28 75', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jfrazierka@symantec.com', 'Frazier', 'Lyséa', 'PwMiP0340E', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('spiercekb@weibo.com', 'Pierce', 'Mélinda', 'yQsZbBAwRl', '06 11 03 78 52', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhowardkc@devhub.com', 'Howard', 'Audréanne', 'QJGsBUtNro', '06 14 56 97 17', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mgarciakd@artisteer.com', 'Garcia', 'Maïly', 'LsWATsW0Zw', '06 90 72 24 24', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cjohnsonke@squidoo.com', 'Johnson', 'Marie-hélène', 'fIsz981ERCLx', '06 95 65 40 59', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ndanielskf@economist.com', 'Daniels', 'Mélinda', 'KPxBeJ', '06 29 66 66 97', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('phillkg@disqus.com', 'Hill', 'Gaïa', '33YYAE8Y8JN', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwashingtonkh@sphinn.com', 'Washington', 'Salomé', 'K74Ekg6Zp2', '06 43 91 44 36', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sdaviski@fotki.com', 'Davis', 'Amélie', 'W2Rv7LE', '06 13 76 74 96', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kmatthewskj@goo.ne.jp', 'Matthews', 'Laurélie', 'RhEnwmson2FA', '06 71 51 97 33', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kwatsonkk@123-reg.co.uk', 'Watson', 'Léone', 'QPgAQcf', '06 15 40 77 11', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmitchellkl@cpanel.net', 'Mitchell', 'Mélia', 'pTBjKSE', '06 39 64 37 75', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mwagnerkm@nationalgeographic.com', 'Wagner', 'Séréna', 'C1ne0i0', null, 0, '7b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('asmithkn@quantcast.com', 'Smith', 'Aí', 'rMEKmAJxai', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jknightko@hibu.com', 'Knight', 'Mélinda', '1q2uJqWbZ4YP', '06 61 89 67 45', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('csanderskp@typepad.com', 'Sanders', 'Garçon', 'IuQsagVjf', '06 96 70 35 70', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wfreemankq@cmu.edu', 'Freeman', 'Styrbjörn', 'xZypMfniiT', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmoorekr@illinois.edu', 'Moore', 'Lài', 'rhFeVzGor9V', '06 75 50 84 72', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ckelleyks@about.com', 'Kelley', 'Lài', 'qaaHfjv', '06 95 01 38 23', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ralexanderkt@reuters.com', 'Alexander', 'Rébecca', 'bLQ1jqt', '06 74 21 10 31', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nnicholsku@amazon.co.uk', 'Nichols', 'Esbjörn', 'Lg7UPvaRQLm', '06 76 23 99 73', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nrodriguezkv@hao123.com', 'Rodriguez', 'Maïlis', 'E7Z8bHC', '06 21 18 98 27', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('khowardkw@ameblo.jp', 'Howard', 'Tú', '9rDrEz', '06 39 34 83 37', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('amcdonaldkx@4shared.com', 'Mcdonald', 'Mégane', 'Zo4ugnfa6', '06 01 01 38 66', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wbanksky@simplemachines.org', 'Banks', 'Yóu', 'WkIwpe1PSP', '06 96 85 54 64', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('awoodskz@auda.org.au', 'Woods', 'Lauréna', 'W7JLpu', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kwatkinsl0@constantcontact.com', 'Watkins', 'Nélie', 'Io8HY03l', '06 24 21 98 14', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jscottl1@deviantart.com', 'Scott', 'Ruì', 'DdaIFCl', '06 29 61 53 41', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sthomasl2@nps.gov', 'Thomas', 'Stévina', '6ybNLhu4VV4K', '06 74 98 87 93', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bgibsonl3@java.com', 'Gibson', 'Angèle', '1HZNwKoVO', '06 37 06 37 11', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lburtonl4@dion.ne.jp', 'Burton', 'Gaétane', 'fifAF0zLoKa', '06 98 53 38 22', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cthomasl5@prnewswire.com', 'Thomas', 'Maëly', 'ScynTx', '06 57 06 23 65', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jallenl6@forbes.com', 'Allen', 'Kù', 'gFI8r0pPDy', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rmartinl7@squarespace.com', 'Martin', 'Océanne', 'ORSp7lCDFDg', '06 48 44 67 79', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dturnerl8@flickr.com', 'Turner', 'Eléonore', '8JU6m7', '06 05 44 41 94', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('atorresl9@meetup.com', 'Torres', 'Torbjörn', '8dF3hhtIz57', '06 61 16 25 20', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kcooperla@forbes.com', 'Cooper', 'Judicaël', 'j4oW0a', '06 25 01 52 56', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bchavezlb@theatlantic.com', 'Chavez', 'Lucrèce', 'ML611C3z1Adn', '06 66 15 99 32', 0, '6c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pperkinslc@alexa.com', 'Perkins', 'Géraldine', 'efWbbaTULS', '06 14 46 61 62', 0, '4b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('swashingtonld@blogtalkradio.com', 'Washington', 'Irène', 'yXOUufbA', '06 60 75 88 90', 0, '4a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vgrantle@oakley.com', 'Grant', 'Stévina', 'VSa5VTRUyK', '06 47 86 00 09', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('acarpenterlf@bluehost.com', 'Carpenter', 'Régine', 'iVZCiBSOmC', '06 08 34 02 13', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pfullerlg@tripod.com', 'Fuller', 'Pélagie', 'tMJzDm0t', '06 59 04 30 49', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jelliottlh@abc.net.au', 'Elliott', 'Bérénice', '8EaoIClR', '06 29 95 30 08', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cortizli@tamu.edu', 'Ortiz', 'Ráo', '77wuLn7A2', '06 60 88 81 13', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pgraylj@arstechnica.com', 'Gray', 'Lén', 'AIly9gTBG', '06 34 69 61 23', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fkimlk@e-recht24.de', 'Kim', 'Estée', 'cE8ynQ5J0k', null, 0, '4a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jperkinsll@seesaa.net', 'Perkins', 'Adèle', '7zKQow9wBBUn', '06 82 45 12 71', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aharveylm@mlb.com', 'Harvey', 'Estève', 'PMNbUYzH', '06 12 41 96 77', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jperkinsln@ifeng.com', 'Perkins', 'Maëlyss', 'zijhHkHFLqen', '06 79 68 39 92', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lbaileylo@symantec.com', 'Bailey', 'Maïly', 'yqInnd1L0k', '06 81 97 86 78', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ejacobslp@canalblog.com', 'Jacobs', 'Måns', 'hxan6F7j5', '06 65 16 87 97', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rcunninghamlq@cnn.com', 'Cunningham', 'Miléna', 'KrkK92bR', '06 86 57 16 09', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pwilliamsonlr@macromedia.com', 'Williamson', 'Loïca', '545djiW', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lreynoldsls@tinyurl.com', 'Reynolds', 'Médiamass', 'e9Gu5Gnr3oV', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('triveralt@so-net.ne.jp', 'Rivera', 'Maï', 'xiU6e4', '06 58 89 08 48', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('amatthewslu@wix.com', 'Matthews', 'Céline', 'qzB5D7mNn', '06 54 28 96 42', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jbrownlv@over-blog.com', 'Brown', 'Bérangère', 'iJLe4s6Iqm0', '06 72 25 07 06', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mcarrolllw@msu.edu', 'Carroll', 'Géraldine', '5EbzSgFpQe', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mmorrisonlx@cdbaby.com', 'Morrison', 'Cléa', 'I32X6B', '06 86 67 87 42', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jspencerly@google.de', 'Spencer', 'Maëlann', 'DW91Iz0b9eI', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhamiltonlz@sciencedaily.com', 'Hamilton', 'Loïs', 'HbgPeCSuB5', '06 89 60 28 57', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cbanksm0@cnbc.com', 'Banks', 'Börje', 'qkjg3o0iaF', '06 73 46 09 51', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ddiazm1@bizjournals.com', 'Diaz', 'Séverine', 'TA8DNDamv', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wbanksm2@independent.co.uk', 'Banks', 'Méng', 'wg3blO', '06 34 80 75 48', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kwebbm3@mit.edu', 'Webb', 'Personnalisée', 'ff9IEe2', '06 83 33 78 62', 0, '7b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('agrahamm4@behance.net', 'Graham', 'Naëlle', 'CcZslNe3tvmz', '06 97 73 70 19', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mwestm5@gmpg.org', 'West', 'Angèle', 'yvNPd1w', '06 52 95 05 89', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tsnyderm6@cornell.edu', 'Snyder', 'Judicaël', '3Qvz2r5Qw', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mjohnstonm7@twitpic.com', 'Johnston', 'Kallisté', 'pYvdLmMLy8n5', null, 0, '6a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hjacksonm8@bloomberg.com', 'Jackson', 'Pénélope', 'q795Vv4', '06 53 39 15 00', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hmccoym9@un.org', 'Mccoy', 'Nélie', 'ai1XqVh8', '06 45 55 64 31', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('chuntma@studiopress.com', 'Hunt', 'Océane', 'AW1Bf4hS', '06 11 27 69 93', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jgraymb@shareasale.com', 'Gray', 'Yú', 'MkG5Oi', null, 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lfraziermc@ask.com', 'Frazier', 'Eloïse', 'QVfsarpM', '06 75 20 34 03', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ewillismd@archive.org', 'Willis', 'Marie-josée', 'gN1XPrW6y', '06 37 33 21 57', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('thallme@mashable.com', 'Hall', 'Estée', 'DXnmacdUNaB0', '06 19 30 14 64', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cwilliamsmf@goo.gl', 'Williams', 'Gösta', 'n7AypUN', '06 91 17 38 86', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('whudsonmg@t.co', 'Hudson', 'Léana', 'EvPXqNtN1A', '06 72 12 02 69', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwallacemh@furl.net', 'Wallace', 'Eloïse', 'yijWl6nXlyR', '06 93 71 61 72', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aharveymi@yale.edu', 'Harvey', 'Zoé', 'F7ESHG', '06 65 82 52 31', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('afranklinmj@slideshare.net', 'Franklin', 'Annotés', '5Jz41cp', '06 91 36 72 02', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bportermk@globo.com', 'Porter', 'Adèle', 'qwMCTX', '06 89 44 46 41', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tmorenoml@ox.ac.uk', 'Moreno', 'Mén', 'udY57IY', '06 95 30 94 32', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('scolemanmm@xinhuanet.com', 'Coleman', 'Mårten', 'wS5eIowH3V', '06 87 69 68 31', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bmyersmn@123-reg.co.uk', 'Myers', 'Athéna', 'XtE5xEuomoXb', null, 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sbutlermo@nyu.edu', 'Butler', 'Méline', 'AZ8dzCx', '06 05 85 22 34', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jrosemp@studiopress.com', 'Rose', 'Eléa', 'KrrV4M', '06 28 75 02 18', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jleemq@oakley.com', 'Lee', 'Sòng', 'TK0OfyzEmBF', '06 08 16 93 07', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jreynoldsmr@pcworld.com', 'Reynolds', 'Gaétane', 'HnrU3m', '06 90 53 97 19', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('awatsonms@msu.edu', 'Watson', 'Torbjörn', 'Uz8w3KROS2M', '06 33 97 78 19', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jburkemt@mlb.com', 'Burke', 'Pål', 'ZmYfV7im2', '06 01 47 11 16', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jlewismu@home.pl', 'Lewis', 'Thérèse', 'uiiz4EU', '06 14 95 76 72', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwellsmv@mtv.com', 'Wells', 'Yénora', 'pkZbXuuM0E', '06 50 23 16 43', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('adunnmw@sbwire.com', 'Dunn', 'Cécilia', 'rLcv5a9m5', null, 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kwestmx@craigslist.org', 'West', 'Wá', 'RplLDYf1cs', '06 45 79 43 63', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sgarrettmy@taobao.com', 'Garrett', 'Tú', 'qCcsfX', '06 68 84 28 11', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lstephensmz@amazon.co.uk', 'Stephens', 'Loïc', 'Z6mInMIRV', '06 94 51 43 58', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ajohnstonn0@ftc.gov', 'Johnston', 'Uò', 'wGsgYAnt9', '06 79 58 03 30', 0, '6a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jcoopern1@dropbox.com', 'Cooper', 'Gisèle', '6v8pCli', '06 56 86 15 21', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('saustinn2@lulu.com', 'Austin', 'Åke', 'u6gdk6lvr', '06 20 75 93 55', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('eduncann3@google.de', 'Duncan', 'Maïlis', 'ESyVbKnH', '06 19 61 01 94', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kcolemann4@hud.gov', 'Coleman', 'Maïlis', 'q4d9naSlxj', '06 39 83 29 47', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('acolen5@slashdot.org', 'Cole', 'Maïlis', 'zUj376cw', '06 70 20 82 39', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gpaynen6@cbsnews.com', 'Payne', 'Cécile', 'qaNLuNZhx8', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jperryn7@time.com', 'Perry', 'Gisèle', 'BMknCQHQ', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mtorresn8@sina.com.cn', 'Torres', 'Cécile', 'gAFKky7', '06 84 89 04 76', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pgriffinn9@disqus.com', 'Griffin', 'Erwéi', 'YFO231', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jkennedyna@who.int', 'Kennedy', 'Naëlle', 'Xf4G6qvS3mzM', '06 79 12 11 52', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mkelleynb@meetup.com', 'Kelley', 'Personnalisée', 'tVzb6yw4G61', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bboydnc@moonfruit.com', 'Boyd', 'Naéva', 'crjnyJjA', '06 05 24 17 30', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cwilliamsnd@go.com', 'Williams', 'Célestine', 'yfqNrpO', '06 42 41 90 92', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jdayne@sourceforge.net', 'Day', 'Tú', 'Xj3K0zpNeU', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('epetersonnf@gov.uk', 'Peterson', 'Clémence', 'RwZUfR0', '06 16 51 27 88', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pbellng@washington.edu', 'Bell', 'Geneviève', 'SqHBhfXFrAFb', '06 47 76 67 17', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lkimnh@mayoclinic.com', 'Kim', 'Bénédicte', 'uSH1rF', null, 0, '7a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmooreni@spiegel.de', 'Moore', 'Styrbjörn', 'veXzD6', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dcarternj@ebay.com', 'Carter', 'Dù', 'eGsJ5r4', '06 82 20 55 61', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sbrooksnk@epa.gov', 'Brooks', 'Mà', 'eOTrVoh', '06 73 51 88 55', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dellisnl@plala.or.jp', 'Ellis', 'Aimée', 'zpUTEfzPgY2', '06 00 06 79 18', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kmcdonaldnm@walmart.com', 'Mcdonald', 'Méghane', '9wHAJFtJE', '06 31 35 92 29', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dhudsonnn@chicagotribune.com', 'Hudson', 'André', 'duhC7e6', '06 07 53 89 36', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tmoralesno@auda.org.au', 'Morales', 'Clémentine', 'I1F54XO', '06 02 15 90 95', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pwallacenp@yandex.ru', 'Wallace', 'Léonie', 'QgYLcfFzBpm', '06 00 03 97 54', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pgrahamnq@go.com', 'Graham', 'Alizée', 'O1ngAweRm', '06 92 09 58 76', 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aturnernr@acquirethisname.com', 'Turner', 'Håkan', 'fW1B1IrRZ3i', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pparkerns@photobucket.com', 'Parker', 'Maëlla', 'LpCLKBjp', '06 11 15 02 92', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jreyesnt@symantec.com', 'Reyes', 'Régine', 'UjQ5a2QvU9', '06 88 38 39 00', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aandrewsnu@va.gov', 'Andrews', 'Laurène', 'tgrswC50CYh', '06 37 27 91 07', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dhuntnv@123-reg.co.uk', 'Hunt', 'Dà', 'W5PXxD3', '06 42 80 16 75', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jrileynw@guardian.co.uk', 'Riley', 'Gösta', 'qoU3YPu0Pa', '06 05 62 76 93', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bgriffinnx@pagesperso-orange.fr', 'Griffin', 'Kévina', 'hAly4Lg87T', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jparkerny@icio.us', 'Parker', 'Lóng', 'Noj7rsRDy', null, 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jharpernz@epa.gov', 'Harper', 'Kallisté', 'i4Sz3PVSk', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('arichardsono0@google.co.uk', 'Richardson', 'Anaël', '4LQ8FPKw7', '06 60 16 21 01', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mowenso1@mac.com', 'Owens', 'Marie-noël', 'Do7lioTvsyOK', '06 19 31 53 20', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('smitchello2@guardian.co.uk', 'Mitchell', 'Cécile', '6Bd3vp', '06 30 46 26 04', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ncoleo3@howstuffworks.com', 'Cole', 'Françoise', 'rUOFLX4SHxD', '06 59 41 73 50', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pwoodo4@istockphoto.com', 'Wood', 'Loïc', 'gPMvV8', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('nbryanto5@vinaora.com', 'Bryant', 'Edmée', 'xtv63QU', '06 84 81 34 11', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmorenoo6@xing.com', 'Moreno', 'Irène', 'gQYae3j', '06 97 62 72 15', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('drichardsono7@miibeian.gov.cn', 'Richardson', 'Vérane', 'oo0sAckcWYS', '06 05 47 48 82', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ldayo8@myspace.com', 'Day', 'Mélanie', 'd5s0UwMHuCv', '06 54 44 65 43', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmorenoo9@usa.gov', 'Moreno', 'Ophélie', 'NqpBMK', '06 31 74 65 46', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('freedoa@etsy.com', 'Reed', 'Cléa', 'mYStGmng', '06 98 68 20 62', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bboydob@merriam-webster.com', 'Boyd', 'Yú', 'yWfrfBadu', '06 40 58 65 12', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ariveraoc@fema.gov', 'Rivera', 'Noëlla', 'bly4UW', '06 74 62 51 51', 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bhansonod@dailymail.co.uk', 'Hanson', 'Marie-françoise', 'rWWPYZTR7', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rfrazieroe@freewebs.com', 'Frazier', 'Maëline', 'Shk2qDo4jVJ', '06 69 46 02 41', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sbarnesof@symantec.com', 'Barnes', 'Illustrée', 'uQhCMghIV', '06 55 86 06 88', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('alopezog@cmu.edu', 'Lopez', 'Crééz', 'oPfdaEc', '06 26 36 22 09', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hwilliamsoh@cisco.com', 'Williams', 'Laurélie', 'OVVCTg', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ephillipsoi@ebay.com', 'Phillips', 'Estée', 'O3PJBOP', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('edeanoj@unesco.org', 'Dean', 'Célia', '2ehgK0MXUzM', '06 84 36 69 52', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rortizok@ucla.edu', 'Ortiz', 'Eloïse', 'pWQDXFyhXQJ1', '06 16 76 12 50', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('erobertsol@toplist.cz', 'Roberts', 'Rachèle', 'lzGCQeqkH7', '06 59 22 60 80', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kmontgomeryom@bbc.co.uk', 'Montgomery', 'Björn', '5RkdK0Kxr', null, 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmooreon@pcworld.com', 'Moore', 'Mårten', 'Ob4JxDI', '06 72 09 88 37', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jcookoo@opera.com', 'Cook', 'Ophélie', 'GnIz2kLuccW', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sburkeop@ibm.com', 'Burke', 'Valérie', 'qnbKlERrGw', '06 71 48 93 88', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jmcdonaldoq@berkeley.edu', 'Mcdonald', 'Gösta', '8E5gYuQceGB3', '06 35 54 64 74', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('eharrisor@independent.co.uk', 'Harris', 'Sòng', 'Z3AI4c', '06 03 18 06 90', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bmontgomeryos@shutterfly.com', 'Montgomery', 'Cécile', 'HgyCoa', null, 0, '7b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('triceot@blog.com', 'Rice', 'Aloïs', 'ic0OKu6X', '06 72 07 78 50', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('holsonou@sakura.ne.jp', 'Olson', 'Clémentine', '9snJ7MZWe', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rmoralesov@i2i.jp', 'Morales', 'Marie-ève', 'IWlHnESdhMr', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ajacobsow@hugedomains.com', 'Jacobs', 'Zhì', 'SbXW86A9rQO', '06 77 14 91 43', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jdiazox@msu.edu', 'Diaz', 'Gérald', 'lNXGz7P', '06 00 91 60 51', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dwallaceoy@mapy.cz', 'Wallace', 'Maëlla', 'hBby7whcv', '06 04 33 98 42', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhendersonoz@addtoany.com', 'Henderson', 'Inès', 'SDtLAMdbu', '06 54 22 12 75', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gthompsonp0@yolasite.com', 'Thompson', 'Dorothée', 'aphiLS', null, 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fnelsonp1@symantec.com', 'Nelson', 'Yú', '6dkbHrHh', '06 96 98 10 62', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vrussellp2@ebay.com', 'Russell', 'Cunégonde', 'E9qKrhxwHIj', '06 91 12 67 21', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fmontgomeryp3@webeden.co.uk', 'Montgomery', 'Léandre', 'RfJJyxLa', '06 80 81 77 28', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cvasquezp4@behance.net', 'Vasquez', 'Gisèle', '9M0EUbVE', '06 64 00 05 06', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rharrisonp5@miibeian.gov.cn', 'Harrison', 'Estève', 'NuctLmkS35T', '06 26 35 72 53', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mthompsonp6@shop-pro.jp', 'Thompson', 'Maëlyss', 'kPSVe6', null, 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gvasquezp7@sina.com.cn', 'Vasquez', 'Åslög', 'ZeyFdjITJR6p', '06 80 94 97 50', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('awalkerp8@ezinearticles.com', 'Walker', 'Véronique', 'owVx7E4', '06 96 60 77 22', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jwilsonp9@alibaba.com', 'Wilson', 'Måns', 'DmFq1tNfiG', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('abarnespa@blogger.com', 'Barnes', 'Marlène', 'KK56NRvfKW8d', '06 40 13 80 98', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hgreenpb@prnewswire.com', 'Green', 'Béatrice', 'V6zh9o', '06 58 45 27 63', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhowardpc@bbc.co.uk', 'Howard', 'Marie-hélène', 'thvuQE', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ekimpd@bbb.org', 'Kim', 'Yáo', 'mQVW2dLFNVb', '06 36 78 56 50', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('volsonpe@blogs.com', 'Olson', 'Anaïs', 'G0GAz7dnFtkj', '06 19 59 43 80', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('eburkepf@tamu.edu', 'Burke', 'Rachèle', 'N9Fv5aecmCw', '06 90 70 36 68', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('esmithpg@disqus.com', 'Smith', 'Fèi', 'ErxjLRlKE8', '06 67 19 77 62', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cdiazph@who.int', 'Diaz', 'Méghane', 'EOqI8yLga', '06 50 04 13 06', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wjacobspi@unesco.org', 'Jacobs', 'Réjane', 'EvbIwcQYk7O', '06 26 27 18 69', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('larnoldpj@feedburner.com', 'Arnold', 'Mén', '90n78K', '06 47 17 06 09', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('fberrypk@latimes.com', 'Berry', 'Marie-josée', 'HwO6krD', '06 25 31 36 98', 0, '6b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('hcrawfordpl@feedburner.com', 'Crawford', 'Réjane', 'wQNJoqFtoTfe', null, 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gedwardspm@drupal.org', 'Edwards', 'Inès', 'clNOW2ZIQ3R4', '06 23 99 47 73', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vwalkerpn@zdnet.com', 'Walker', 'Gisèle', 'XAVKLtXg', '06 21 66 15 83', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sjonespo@google.it', 'Jones', 'Maëline', 'gEYx1B', '06 24 62 59 10', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wcooperpp@cnet.com', 'Cooper', 'Eloïse', 'ybzJ4i2y', '06 59 98 58 01', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jsanchezpq@twitpic.com', 'Sanchez', 'Gaïa', 'yYVsBsAK', '06 61 72 67 85', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('treedpr@blinklist.com', 'Reed', 'Célestine', 'a3aEFtyl4BLZ', '06 34 43 26 05', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rmyersps@google.nl', 'Myers', 'Hélène', 'UO78WKB3ja2', null, 0, '6c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dharrispt@skype.com', 'Harris', 'Rébecca', 'bFN5hIVnAXcR', '06 60 99 89 15', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('vreyespu@hugedomains.com', 'Reyes', 'Méthode', 'T8EKuxB', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cryanpv@flickr.com', 'Ryan', 'Hélèna', 'ATr5l7KyWO', '06 28 40 36 57', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pjordanpw@uiuc.edu', 'Jordan', 'Léone', 'wx8nrsh', '06 07 11 58 20', 0, '7a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lharveypx@ihg.com', 'Harvey', 'Mén', 'RCIMxHLIo9', '06 91 60 64 50', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('abarnespy@ftc.gov', 'Barnes', 'Marlène', 'Po7D6PFo21Dk', '06 74 30 47 13', 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rsnyderpz@yolasite.com', 'Snyder', 'Mélia', 'gDyPeqaI', '06 79 84 37 24', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dwrightq0@soup.io', 'Wright', 'Mårten', '02PWjM', '06 96 77 54 19', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tfowlerq1@europa.eu', 'Fowler', 'Bérengère', 'gQFOiXhzCsx', '06 34 20 36 39', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ataylorq2@va.gov', 'Taylor', 'Céline', 'zTuAjJ9t', '06 69 51 28 95', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jsimsq3@trellian.com', 'Sims', 'Mélia', 'Mg3sk7kYSRH', '06 54 89 60 03', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('thuntq4@auda.org.au', 'Hunt', 'Noëlla', '0FDVZnjPjyB', '06 06 27 47 97', 0, '6c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jclarkq5@wikia.com', 'Clark', 'Nadège', 'CdfPX9leWt', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cfranklinq6@cafepress.com', 'Franklin', 'Uò', 'vnGc0bci', '06 59 95 54 04', 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmatthewsq7@sciencedaily.com', 'Matthews', 'Léonie', 'nkpfdMDgjdI', '06 35 56 79 21', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sbrooksq8@springer.com', 'Brooks', 'Görel', 'BxhMb96jNb', '06 44 50 60 42', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sgriffinq9@behance.net', 'Griffin', 'Marie-françoise', 'ZCHWEelores', null, 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('bmitchellqa@soundcloud.com', 'Mitchell', 'Inès', 'Yih1mzSxBlr', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gwrightqb@networksolutions.com', 'Wright', 'Andréanne', '40FrR0', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rschmidtqc@technorati.com', 'Schmidt', 'Audréanne', 'CnULpLPtgy3', '06 96 49 04 45', 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cpowellqd@bizjournals.com', 'Powell', 'Maëlla', 'UFWhBnM', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('blongqe@meetup.com', 'Long', 'Méthode', 'q5hjSbIqJ9U', null, 0, '5a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rsimsqf@printfriendly.com', 'Sims', 'Maïlis', 'SmJuVQNbkZ5', null, 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pmendozaqg@google.pl', 'Mendoza', 'Sòng', 'ipfndv5GqFy', '06 44 79 49 83', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('gpetersqh@hatena.ne.jp', 'Peters', 'Léana', 'KuiuRlhGm', '06 31 61 35 84', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kturnerqi@nhs.uk', 'Turner', 'Tú', 'bukdEXJVzKgq', '06 18 35 89 53', 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mnelsonqj@google.com.br', 'Nelson', 'Séréna', 'Wx9ANGswur', '06 40 93 33 66', 0, '7c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kbrownqk@google.de', 'Brown', 'Renée', 'VYUNxE6x5xp', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dduncanql@cam.ac.uk', 'Duncan', 'Adélaïde', 'ZB4AVp', '06 77 67 87 50', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jbradleyqm@deliciousdays.com', 'Bradley', 'Lén', 'PqVNMcZYo', '06 07 97 53 68', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dbakerqn@g.co', 'Baker', 'Marylène', '8q1w3V', '06 99 53 63 96', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jfernandezqo@google.it', 'Fernandez', 'Inès', 'krydukr', '06 65 18 20 19', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('crodriguezqp@hhs.gov', 'Rodriguez', 'Méghane', '0t7GwldErLk', '06 79 33 66 13', 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mreyesqq@blogger.com', 'Reyes', 'Audréanne', 'TcsKBA', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('msandersqr@cnet.com', 'Sanders', 'Renée', 'zfY1n3tq', '06 96 71 30 56', 0, '5c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('eadamsqs@amazon.com', 'Adams', 'Marie-noël', 'SVemsoB2Eh', '06 90 04 78 48', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmasonqt@cyberchimps.com', 'Mason', 'Marie-josée', 'b0EkSgBEymM8', '06 69 64 85 12', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lmartinqu@hubpages.com', 'Martin', 'Styrbjörn', '99Z8GMa', null, 0, '8b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('mchapmanqv@disqus.com', 'Chapman', 'Adèle', 'R6HbVYE', '06 00 05 78 65', 0, '8c+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sclarkqw@sciencedaily.com', 'Clark', 'Åke', 'ydHTWP', '06 64 72 32 09', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aberryqx@bbb.org', 'Berry', 'Östen', 'DvORAcuX', '06 04 26 49 88', 0, '8c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('arichardsqy@irs.gov', 'Richards', 'Médiamass', 'ltSD6ORmKA', '06 19 47 95 51', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cmillsqz@bigcartel.com', 'Mills', 'Björn', '9PYRZ4c3oSt', '06 68 24 45 99', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('djenkinsr0@census.gov', 'Jenkins', 'Françoise', 'n4iLfR60NFf0', '06 83 75 14 73', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('cevansr1@weebly.com', 'Evans', 'Solène', 'kzr3Z7FjOjFd', '06 28 31 70 57', 0, '7b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhartr2@lulu.com', 'Hart', 'Océanne', 'QcFwitMRl', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('crussellr3@posterous.com', 'Russell', 'Laïla', 'Asa2h0X', null, 0, '7c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wlawsonr4@geocities.jp', 'Lawson', 'Tú', 'uvrtWhAv564e', '06 65 69 71 24', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('aadamsr5@vistaprint.com', 'Adams', 'Réjane', 'LXIpnc15S', null, 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('smurphyr6@nature.com', 'Murphy', 'Mà', '0wYU60', '06 52 11 56 32', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('chansenr7@ed.gov', 'Hansen', 'Méryl', 'XmED9vE5nJXO', '06 88 42 51 80', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('pburnsr8@ibm.com', 'Burns', 'Marie-françoise', 'A8sswVL', '06 87 51 83 23', 0, '5c');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tburtonr9@github.io', 'Burton', 'Eloïse', 'Aaj25l', '06 53 78 07 44', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('dcarrollra@hibu.com', 'Carroll', 'Magdalène', 'l4kBbzp477m', '06 91 16 51 57', 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ahenryrb@mediafire.com', 'Henry', 'Mà', '95ymLJsieHDD', null, 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('chenryrc@hp.com', 'Henry', 'Eloïse', 'lOarbcb', '06 56 27 12 54', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('wknightrd@wordpress.com', 'Knight', 'Ophélie', 'xXwofiKbvTV', '06 09 20 56 75', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jortizre@ucoz.ru', 'Ortiz', 'Gaëlle', '6jo0V0qZf', '06 26 20 09 90', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('sbowmanrf@phoca.cz', 'Bowman', 'Stévina', 'H9ZZFgmADY0b', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('kcolemanrg@domainmarket.com', 'Coleman', 'Aloïs', 'mJol0E7wkmW', '06 83 52 12 39', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('rstonerh@ucoz.com', 'Stone', 'Magdalène', 'QXhSavybnM6s', '06 86 53 88 06', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tjonesri@instagram.com', 'Jones', 'Tú', 'rXDASl', '06 57 82 96 99', 0, '8a');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tpowellrj@istockphoto.com', 'Powell', 'Hélèna', 'DHF9kDsJ41q', '06 88 66 30 30', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('ltorresrk@skyrock.com', 'Torres', 'Andréa', '7vym9Cxxwk', '06 00 00 80 68', 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('scoxrl@abc.net.au', 'Cox', 'Lèi', '74Tr4tNzYl', null, 0, '8a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('chartrm@opensource.org', 'Hart', 'Séverine', 'vocl1AVCjI', '06 72 12 41 53', 0, null);
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jturnerrn@twitpic.com', 'Turner', 'Hélène', 'QqDKvPOw9Yr', '06 06 33 72 54', 0, '8b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('lporterro@java.com', 'Porter', 'Dorothée', 'MMsVLY', null, 0, '5b');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('phansenrp@a8.net', 'Hansen', 'Mà', 'i9E8EZPv', '06 26 84 33 92', 0, '5a+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('tmurrayrq@aboutads.info', 'Murray', 'Camélia', 'OAY4LT', null, 0, '5b+');
insert into Membre (email, nomMembre, PrenomMembre, mdp, tel, statut, niveau) values ('jhudsonrr@prlog.org', 'Hudson', 'Célia', 'Ad6JqD8Y', '06 44 52 13 39', 0, '8c+');





INSERT INTO Participant (
idSortie ,
idParticipant
)

VALUES ('', '2015-6-15'),

('1', '10'),('1', '125'),('1', '15'),('1', '850'),('1', '13'),('1', '965'),('1', '752'),('1', '600'),('1', '540'),('1', '532'),('1', '398'),('1', '123'),('1', '125'),('1', '741'),('1', '56'),

('2', '15'),('2', '30'),('2', '45'),('2', '70'),('2', '100'),('2', '150'),

('3', '1'),('3', '2'),('3', '3'),('3', '4'),('3', '6'),('3', '100'),('3', '105'),('3', '500'),('3', '653'),('3', '655'),('3', '700'),('3', '750'),('3', '755'),('3', '800'),('3', '802'),('3', '830'),('3', '854'),('3', '900'),('3', '910'),('3', '915'),

 ('4', '15'),('4', '150'),('4', '151'),('4', '51'),('4', '21'),('4', '300'),('4', '315'),('4', '369'),
 ('5', '743');



