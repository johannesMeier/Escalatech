<?php

class Participant {

    //ATTRIBUTS
    private $idSortie;
    private $idParticipant;
	private $nomMembre;
	private $prenomMembre;
	private $tel;

    //CONSTRUCTEUR
    public function __construct($idSortie, $idParticipant,$nomMembre,$prenomMembre,$tel) {
        $this->idSortie = $idSortie;
        $this->idParticipant = $idParticipant;
        $this->nomMembre = $nomMembre;
		$this->prenomMembre = $prenomMembre;
        $this->tel = $tel;

    }

    //METHODES
    //Getteurs
    public function getidSortie() {
        return $this->idSortie;
    }

    public function getidParticipant() {
        return $this->idParticipant;
    }

    public function getidnomMembre() {
        return $this->nomMembre;
    }
    public function getprenomMembre() {
        return $this->prenomMembre;
    }

    public function gettel() {
        return $this->tel;
    }




//enregistre le site courant dans la base de donnees
    public function save() {
        //Retourne true si l'ajout a ete fait
        $dbh = new Connexion();
        $dbh = $dbh->pdo();
        $format='Y-m-d H:i:s';
        $req = $dbh->prepare("INSERT INTO Participant(idSortie,idParticipant) VALUES(?,?)");
        try {
            $req = $req->execute(array($this->idSortie, $this->idParticipant));
            return $req;
        } catch (Exception $e) {
            echo 'Erreur de requete : ', $e->getMessage();
        }
    }
//------------------------------------------------------------------------------------------
	
	
	//////////////////////////////////////////////////AFAIRE
	//affiche la liste de tous les Sites
    public static function recupereListeParticipant($idSortie) {
        try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("SELECT 
			nomMembre,
			PrenomMembre,
			tel
			FROM Participant,Membre
			WHERE Participant.idParticipant=Membre.IDMembre
			AND Participant.idSortie=:idSor ");
            // On indique que nous utiliserons les resultats en tant qu'objet
			$prepare->bindValue(":idSor", $idSortie);
            $prepare->execute();
            // Nous traitons les resultats en boucle
            while ($tuple = $prepare->fetch(PDO::FETCH_OBJ)) {
                $tab[] = new Participant('','',$tuple->nomMembre,$tuple->PrenomMembre,$tuple->tel);
            }
            return $tab;
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
        }
    }
	
	
	
	    public static function estInscrit($idSortie,$idMembre) {
        try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("SELECT COUNT(*)
			FROM Participant
			WHERE idParticipant=:idMembre
			AND idSortie=:idSor ");
            // On indique que nous utiliserons les resultats en tant qu'objet
			$prepare->bindValue(":idSor", $idSortie);
			$prepare->bindValue(":idMembre", $idMembre);
            $prepare->execute();
            // Nous traitons les resultats en boucle
            $result=$prepare->fetch();
			if ($result[0]==0){
				return false;
			}
			else{
				return true;
			}
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
        }
    }
	
	

}


?>
