<?php

class Site {

    //ATTRIBUTS
    private $idSite;
    private $nomSite;
    private $SecteurSite;
    private $descriptionSite;
	private $topoSite;

    //CONSTRUCTEUR
    public function __construct($idSite, $nomSite, $SecteurSite, $descriptionSite, $topoSite="NULL") {
        $this->idSite = $idSite;
        $this->nomSite = $nomSite;
        $this->SecteurSite = $SecteurSite;
        $this->descriptionSite = $descriptionSite;
		$this->topoSite = $topoSite;
    }

    //METHODES
    //Getteurs
    public function getID() {
        return $this->idSite;
    }

    public function getNomSite() {
        return $this->nomSite;
    }
	
    public function getSecteurSite() {
        return $this->SecteurSite;
    }
		
	public function getDescriptionSite() {
        return $this->descriptionSite;
    }

    public function getTopoSite() {
        return $this->topoSite;
    }





//enregistre le site courant dans la base de donnees
    public function save() {
        //Retourne true si l'ajout a ete fait
        $dbh = new Connexion();
        $dbh = $dbh->pdo();
        $req = $dbh->prepare("INSERT INTO Site	(idSite,nomSite,SecteurSite,descriptionSite,topoSite) VALUES(?,?,?,?,?)");
        try {
            $req = $req->execute(array('', $this->nomSite, $this->SecteurSite, $this->descriptionSite, $this->topoSite));
            return $req;
        } catch (Exception $e) {
            echo 'Erreur de requete : ', $e->getMessage();
        }
    }
//---------------------------------------------------------------------------------------------------------
//affiche la liste de tous les Sites
    public function recupereAllSites() {
        try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("SELECT nomSite,SecteurSite,descriptionSite,topoSite FROM Site ");
            // On indique que nous utiliserons les resultats en tant qu'objet
            $prepare->execute(array());
            // Nous traitons les resultats en boucle
            while ($tuple = $prepare->fetch(PDO::FETCH_OBJ)) {
				$path=NULL;
				if($tuple->topoSite!=NULL){
				$path = "/Escalatech/topos/".$tuple->topoSite;
				}
                $tab[] = new Site('',$tuple->nomSite, $tuple->SecteurSite, $tuple->descriptionSite, $path);
            }
            return $tab;
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
        }
    }
	
	
	
	
	
	//affiche la liste de tous les Sites
    public function recupereListeSites() {
        try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("SELECT idSite,nomSite FROM Site ");
            // On indique que nous utiliserons les resultats en tant qu'objet
            $prepare->execute(array());
            // Nous traitons les resultats en boucle
            while ($tuple = $prepare->fetch(PDO::FETCH_OBJ)) {
                $tab[] = new Site($tuple->idSite,$tuple->nomSite,'','','');
            }
            return $tab;
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
        }
    }
	
		public function update() {
			echo'DEBUT';
		echo $this->nomSite;$this->SecteruSite;$this->descriptionSite;$this->topoSite;$this->idSite;
		try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("UPDATE Site 
									SET nomSite=?,
									SecteruSite=?,
									DescriptionSite=?
									topoSite=?
									Where idSite=?
			");
		
            $prepare->execute(array($this->nomSite,$this->SecteruSite,$this->descriptionSite,$this->topoSite,$this->idSite));
            // Nous traitons les resultats en boucle
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
        }
		
	}
		
	public function SupprSite(){
			try {
            $dbh = new Connexion();
            $dbh = $dbh->pdo();
            $tab = array();
            $prepare = $dbh->prepare("DELETE FROM Sortie 
									Where idSite=?
			");
            $prepare->execute(array($this->idSite));
            // Nous traitons les resultats en boucle
        } catch (Exception $e) {
            echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
        }
		
		}
	

}


?>
