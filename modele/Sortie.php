<?php

class Sortie {

    //ATTRIBUTS
    private $idEvt;
    private $dateEvt;
    private $heureEvt;
    private $site;
	private $organisateur;

    //CONSTRUCTEUR
    public function __construct($idEvt, $dateEvt, $heureEvt, $site, $organisateur) {
        $this->idEvt = $idEvt;
        $this->dateEvt = $dateEvt;
        $this->heureEvt = $heureEvt;
        $this->site = $site;
		$this->organisateur = $organisateur;
    }

    //METHODES
    //Getteurs
    public function getID() {
        return $this->idEvt;
    }

    public function getDate() {
        return $this->dateEvt;
    }
	
    public function getHeure() {
        return $this->heureEvt;
    }
		
	public function getSite() {
        return $this->site;
    }

    public function getOrganisateur() {
        return $this->organisateur;
    }





//enregistre l event courant dans la base de donnees
    public function save() {
        //Retourne true si l'ajout a ete fait
        $dbh = new Connexion();
        $dbh = $dbh->pdo();
        $format='Y-m-d H:i:s';
        $req = $dbh->prepare("INSERT INTO Sortie(idEvt,dateEvt,heureEvt,site,organisateur) VALUES(?,?,?,?,?)");
        try {
            $req = $req->execute(array('', $this->dateEvt, $this->heureEvt, $this->site, $this->organisateur));
            return $req;
        } catch (Exception $e) {
            echo 'Erreur de requete : ', $e->getMessage();
        }
    }
//---------------------------------------------------------------------------------------------------------
//affiche la liste de tous les evenements
    public function recupereAllSortie() {
        try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("SELECT idEvt, dateEvt,heureEvt,nomSite,organisateur
			 FROM Sortie sor,Site sit 
			 Where sit.idSite=sor.site
			 ORDER BY dateEvt ");
            // On indique que nous utiliserons les resultats en tant qu'objet
            $prepare->execute(array());
            // Nous traitons les resultats en boucle
            while ($tuple = $prepare->fetch(PDO::FETCH_OBJ)) {
                $tab[] = new Sortie($tuple->idEvt,strftime("%A %d %B %Y",strtotime($tuple->dateEvt)), $tuple->heureEvt, $tuple->nomSite,$tuple->organisateur);
            }
            return $tab;
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
        }
    }


//affiche la liste des evenements a suivre
    public function recupereSortie() {
        try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("SELECT dateEvt,heureEvt,nomSite,organisateur,site 
			FROM Sortie sor,Site sit 
			Where sit.idSite=sor.site AND dateEvt>CURDATE()
			ORDER BY dateEvt DESC");
            // On indique que nous utiliserons les resultats en tant qu'objet
            $prepare->execute(array());
            // Nous traitons les rÃ©sultats en boucle
            while ($tuple = $prepare->fetch(PDO::FETCH_OBJ)) {
                $tab[] = new Sortie('',strftime("%A %d %B %Y",strtotime($tuple->dateEvt)), $tuple->heureEvt, $tuple->nomSite,$tuple->organisateur);
            }
            return $tab;
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la rÃ©cupÃ©ration : ", $e->getMessage();
        }
    }



    public static function recupereLaSortie($idSortie) {
		try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("SELECT dateEvt,heureEvt,nomSite
			FROM Sortie sor,Site sit 
			Where sit.idSite=sor.site 
			AND sor.idEvt=:idsort
			");
			$prepare->bindValue(":idsort", $idSortie);
            $prepare->execute();
			$result=$prepare->fetch();
            // Nous traitons les resultats en boucle
			$tab = new Sortie('',$result['dateEvt'], $result['heureEvt'], $result['nomSite'],'');
   			
            return $tab;
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
        }
    }
	
	
	
	
	public function update() {
		try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("UPDATE Sortie 
									SET dateEvt=?,
									heureEvt=?,
									site=?
									Where idEvt=?
			");
		
            $prepare->execute(array($this->dateEvt,$this->heureEvt,$this->site,$this->idEvt));
            // Nous traitons les resultats en boucle
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
        }
		
	}
	
	
	public function SupprEvt(){
			try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("DELETE FROM Sortie 
									Where idEvt=?
			");
            $prepare->execute(array($this->idEvt));
            // Nous traitons les resultats en boucle
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
        }
		
		}
	
	
}
//faire suppr

?>
