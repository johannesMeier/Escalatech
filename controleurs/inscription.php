
<?php
$erform ='';
// Si le formulaire est envoyé
if (!empty($_POST['inscription'])) {
		$erform = false;
        if (isset($_POST['email'])){
        	$email = trim(htmlentities($_POST['email'], ENT_QUOTES, 'UTF-8'));
        }
		
        if (isset($_POST['nomMembre'])){
			$nomMembre = trim(htmlentities($_POST['nomMembre'], ENT_QUOTES, 'UTF-8'));
        }  
		         
        if (isset($_POST['prenomMembre'])){
	        $prenomMembre = trim(htmlentities($_POST['prenomMembre'], ENT_QUOTES, 'UTF-8'));
        }
		
		if (isset($_POST['mdp'])){
    	    $mdp = trim(htmlentities($_POST['mdp'], ENT_QUOTES, 'UTF-8'));
        }

		if (isset($_POST['mdp2'])){
    	    $mdp2 = trim(htmlentities($_POST['mdp2'], ENT_QUOTES, 'UTF-8'));
        }
		
        if (isset($_POST['tel'])){
	        $tel = trim(htmlentities($_POST['tel'], ENT_QUOTES, 'UTF-8'));
        }
		
		if (isset($_POST['statut'])){
    	    $statut = trim(htmlentities($_POST['statut'], ENT_QUOTES, 'UTF-8'));
        }
		
		if (isset($_POST['niveau'])){
    	    $niveau = trim(htmlentities($_POST['niveau'], ENT_QUOTES, 'UTF-8'));
        }

		$message = null;
	
		if (isset($email) && $email != "" && $email != null && preg_match('#^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$#', $email)) {
			if (Membre::existMail($email)==false){
				if (isset($mdp) && isset($mdp2) && $mdp!="" && $mdp2!="" && $mdp!=null && $mdp2!=null) {
					if (isset($nomMembre) && $nomMembre!="" && $nomMembre!=null) {
						if (isset($prenomMembre) && $prenomMembre!="" && $prenomMembre!=null) {
							//tous les champs ont été saisis
							if ($mdp == $mdp2) {//verification mdp OK
								$Membre=new Membre();
								$message='Inscription réussi !';
								if (isset($tel) && $tel!="" && $tel!=null && isset($niveau) && $niveau!="" && $niveau!=null) {//info complémentaire : niveau + tel
									$Membre->save($email,$nomMembre,$prenomMembre,md5($mdp),$tel,'',$niveau);
								}elseif(isset($tel) && $tel!="" && $tel!=null){//info complémentaire : tel
									$Membre->save($email,$nomMembre,$prenomMembre,md5($mdp),$tel,'','');
								}elseif(isset($niveau) && $niveau!="" && $niveau!=null){ //info complémentaire : niveau			
										if (preg_match('/^[4-9][A-Ca-c][+]?/',$niveau)){
											$Membre->save($email,$nomMembre,$prenomMembre,md5($mdp),'','',$niveau);
										}else{
											$erform = true;
											$message = 'le niveau d escalade doit etre de la forme [4-9][a-c][+]?  exemple : 6b+ ou 4c';
										}
								}else{
								  $Membre->save($email,$nomMembre,$prenomMembre,md5($mdp),'','','');
								}
							
							}else{
								$erform = true;
								$message = 'Merci de saisir deux mots de passe identiques';
							}
						}else{
							$erform = true;
							$message = 'Merci de saisir votre prenom';
						}
					} else {
							$erform = true;
							$message = 'Merci de saisir votre nom';
					}
				}else {
					$erform = true;
					$message = 'Merci de saisir votre mot de passe';
				}
			}else {
				$erform = true;
				$message = 'Cet email existe deja';
			}
				
		}else {
			$erform = true;
			$message = 'Merci de saisir un email valide';
		}


}




require(dirname(__FILE__).'/../vue/vueInscription.php');

?>

