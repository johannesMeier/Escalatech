<?php






class Membre{
	//ATTRIBUTS
	private $IDMembre;
	private $email;
	private $nomMembre;
	private $prenomMembre;
	private $mdp;
	private $tel;
	private $statut; //1==admin
	private $niveau;
	//CONSTRUCTEUR
	public function __construct($IDMembre='',$mail=NULL,$nomMembre='',$prenomMembre='',$pass=NULL,$tel=NULL,$statut=0,$niveau=NULL){
		$this->IDMembre = $IDMembre ;
		$this->email = $mail ;
		$this->nomMembre = $nomMembre ;
		$this->prenomMembre = $prenomMembre ;
		$this->mdp=$pass;
		$this->tel=$tel;
		$this->statut = $statut ;
		$this->niveau=$niveau;
		
		
	}

	//METHODES
	//Getteurs
	public function getMail(){return $this->email;}
	public function getnomMembre(){return $this->nomMembre;}
	public function getPrenomMembre(){return $this->prenomMembre;}
	public function getTel(){return $this->tel;}
	public function getStatut(){return $this->statut;}
	public function getNiveau(){return $this->niveau;}

	//Retourne -1 si le mail n'eiste pas, 0 si le mdp est faux, 1 si tout bon
	
	public static function existMail($email){
		$dbh=new Connexion();
		$dbh=$dbh->pdo();
		try {
			// On envois la requete
			$select = $dbh->prepare("SELECT COUNT(*) FROM Membre WHERE email=?"); //dbh est dans connexion.php
			$select->execute(array($email));
			$result=$select->fetch();
			if ($result[0]==0){
				return false;
			}
			else{
				return true;
			}
		} catch ( Exception $e ) {
			echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
		}
	}
	
	
	public static function insertCookie($cookie,$email){
            $dbh=new Connexion();
			try{
				$dbh=$dbh->pdo();
				$sql =	("UPDATE Membre
						  SET cookie= :cookie
						  WHERE email=:email");
				$req = $dbh->prepare($sql);
				$req->bindValue(":cookie", $cookie);
				$req->bindValue(":email", $email);
				$req=$req->execute();
				} catch (Exception $e){
					echo 'Erreur de requete : ', $e->getMessage();
				}
			
	}
	
	
	
	public static function estConnecter($cookie=NULL,$email){
		        $dbh=new Connexion();
                $dbh=$dbh->pdo();
			try {
				// On envois la requete
				$select = $dbh->prepare("SELECT cookie FROM Membre WHERE email=?"); //dbh est dans connexion.php
				$select->execute(array($email));
				$result=$select->fetch();
				if ($result['cookie']==$cookie){
                	return true;
                }else{
                    return false;
				}
			} catch ( Exception $e ) {
				echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
			}
	}
	
	
	public static function mdpCorrect($mail,$mdp){
                $dbh=new Connexion();
                $dbh=$dbh->pdo();
			try {
				// On envois la requete
				$select = $dbh->prepare("SELECT mdp FROM Membre WHERE email=?"); //dbh est dans connexion.php
				$select->execute(array($mail));
				$result=$select->fetch();
				if ($result['mdp']==$mdp){
                	return true;
                }else{
                    return false;
				}
			} catch ( Exception $e ) {
				echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
			}
	}
        

		
		


        //RETOURNE 5 si le mail existe deja
        //RETOURNE 1 SI L AJOUT A ETE FAI
        //SINON PROBLEME
	public function save($email,$nomMembre,$prenomMembre,$mdp,$tel=NULL,$statut=0,$niveau='inconnu'){
		//Retourne true si l'ajout a ete fait
		$dbh=new Connexion();
		$dbh=$dbh->pdo();
		if (Membre::existMail($email)){	
		}else{
			$req = $dbh->prepare("INSERT INTO
			Membre(IDMembre,email,nomMembre,prenomMembre,mdp,tel,statut,niveau) VALUES(?,?,?,?,?,?,?,?)");
			try{
				$req=$req->execute(array('',$email,$nomMembre,$prenomMembre,$mdp,$tel,$statut,$niveau));
				return $req;
			} catch (Exception $e){
				echo 'Erreur de requete : ', $e->getMessage();
			}
				}
	}
	
	
	public static function nombreDePage(){
		try {
			$dbh=new Connexion();
			$dbh=$dbh->pdo();
			$tab=array();
			$select = $dbh->prepare("SELECT COUNT(*) FROM Membre;");
			$select->execute(array());
			// On indique que nous utiliserons les resultats en tant qu'objet
			$select->execute(array());
			$result=$select->fetch();
			return $result[0]/50;

		} catch ( Exception $e ) {
			echo "Une erreur est survenue lors de la recuceration : ", $e->getMessage();
		}
	}

	
	
		public function afficheListeMembres($page=0,$nombreLigne=50){
		try {
			$dbh=new Connexion();
			$dbh=$dbh->pdo();
			$tab=array();
			$req = $dbh->prepare("SELECT email,nomMembre,prenomMembre,tel,niveau FROM Membre ORDER BY nomMembre,prenomMembre LIMIT ".($page*$nombreLigne) .",".$nombreLigne.";");
			$req->execute(array());
			// On indique que nous utiliserons les resultats en tant qu'objet
				
			// Nous traitons les resultats en boucle
			while( $tuple=$req->fetch(PDO::FETCH_OBJ) )
			{
				$tab[]=new Membre('',$tuple->email,$tuple->nomMembre,$tuple->prenomMembre,'',$tuple->tel,'',$tuple->niveau,'');
			}
			return $tab;
		} catch ( Exception $e ) {
			echo "Une erreur est survenue lors de la recuceration : ", $e->getMessage();
		}
	}


	public function updateNiveau_Phone(){
		$dbh=new Connexion();
		$dbh=$dbh->pdo();	
		
	}


        public static function estAdmin($mail){
            if (Membre::existMail($mail)){
                $dbh=new Connexion();
                $dbh=$dbh->pdo();
				try {
					// On envois la requete
					$select = $dbh->prepare("SELECT statut FROM Membre WHERE email = :mail"); //dbh est dans connexion.php
					$select->bindValue(":mail", $mail);
					$select->execute();
					$result=$select->fetch();
					if ($result['statut']==1){
						return true;							
					}else{
						return false;
					}
				} catch ( Exception $e ) {
					echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
				}
			}else{
				return false;
			}
      	}


        public static function nomUser($mail){
            if (Membre::existMail($mail)){
                $dbh=new Connexion();
                $dbh=$dbh->pdo();
				try {
					// On envois la requete
					$select = $dbh->prepare("SELECT nomMembre FROM Membre WHERE email = :mail"); //dbh est dans connexion.php
					$select->bindValue(":mail", $mail);
					$select->execute();
					$result=$select->fetch();
					return $result['nomMembre'];
				} catch ( Exception $e ) {
					echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
				}
			}else{
				return false;
			}
      	}
		
		
		        public static function idUser($mail){
            if (Membre::existMail($mail)){
                $dbh=new Connexion();
                $dbh=$dbh->pdo();
				try {
					// On envois la requete
					$select = $dbh->prepare("SELECT idMembre FROM Membre WHERE email = :mail"); //dbh est dans connexion.php
					$select->bindValue(":mail", $mail);
					$select->execute();
					$result=$select->fetch();
					return $result['idMembre'];
				} catch ( Exception $e ) {
					echo "Une erreur est survenue lors de la recuperation : ", $e->getMessage();
				}
			}else{
				return false;
			}
      	}

}

?>
