
<?php
require('./includes/config.php');
require('./includes/connexion.php');
require('./modele/Membre.php');

// Si le formulaire de connexion est envoyé
if (!empty($_POST['deconnexion'])) {
   // Suppression de la valeur du tableau $_COOKIE
  unset($_COOKIE['Connexion']);
  unset($_COOKIE['email']);
  // Suppression du cookie 
  setcookie('Connexion');
  setcookie('email');

	
}

if (!empty($_POST['connexion'])) {
        if (isset($_POST['email'])){
        	$email = trim(htmlentities($_POST['email'], ENT_QUOTES, 'UTF-8'));
        }

		if (isset($_POST['mdp'])){
    	    $mdp = trim(htmlentities($_POST['mdp'], ENT_QUOTES, 'UTF-8'));
        }

		$message = null;

		if (isset($email) && $email != "" && $email != null && preg_match('#^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$#', $email)) {

			if (Membre::existMail($email)==true){

				if (isset($mdp) && $mdp!="" && $mdp!=null ) {
					if (Membre::mdpCorrect($email,md5($mdp))) {
						$cookie=hash('sha256',(md5(time())));
						Membre::insertCookie($cookie,$email);
						setcookie('Connexion',$cookie);
						setcookie('email',$email);
						
					}else{
						$form = true;
						$message = 'Merci de saisir votre mot de passe';
					}
				}else {
					$form = true;
					$message = 'Merci de saisir un mot de passe';
				}
			}else {
					$form = true;
					$message = 'Merci de saisir votre addresse mail';
			}	
		}else {
			$form = true;
			$message = 'Merci de saisir un email valide';
		}
}

require('./includes/header.php');


?>

<div id="fond">


<?php
if (isset($message) && $message!=''){
	echo'<div class="isa_error">'.$message.'</div>';
}

//On inclut le contrôleur s'il existe et s'il est spécifié
if (!empty($_GET['page']) && is_file(dirname(__FILE__).'/controleurs/'.$_GET['page'].'.php')){
	include './controleurs/'.$_GET['page'].'.php';
}else{
	include './controleurs/accueil.php';
}

?>
</div> 




<?php
//On inclut le pied de page
include("./includes/footer.php");
?>