<?php



require(dirname(__FILE__).'/../modele/Sortie.php');
require(dirname(__FILE__).'/../modele/Participant.php');

if (!empty($_POST['inscriptionEvt'])) {
	if(Membre::existMail($_COOKIE['email'])){
		$id = Membre::idUser($_COOKIE['email']);
		if (isset($_POST['idEvt'])){
			$numEvt = htmlentities($_POST['idEvt'], ENT_QUOTES, 'UTF-8');
			$particp = new Participant($numEvt,$id,'','','');
			$particp->save();
			$valide = "inscription confirmé";
		}else{
			$erreur = "erreur lors de l'inscription";
		}
	}else{
		$erreur = "vous n'êtes pas membre";
	}
}



if (!empty($_POST['supprimerEvt'])) {
	if(Membre::existMail($_COOKIE['email'])){
		if(Membre::estAdmin($_COOKIE['email'])){
			$id = Membre::idUser($_COOKIE['email']);
			if (isset($_POST['idEvt'])){
				$numEvt = htmlentities($_POST['idEvt'], ENT_QUOTES, 'UTF-8');
				$Evt = new Sortie($numEvt,'','','','','');
				$Evt->SupprEvt();
				$valide = "Sortie supprimée";
			}else{
				$erreur = "erreur lors de la suppression";
			}
		}else{
			$erreur = "erreur lors de la suppression";
		}
	}
}



$ClassSortie=new Sortie('','','','','');
$sorties = $ClassSortie->recupereAllSortie();

if (empty($sorties)) {
	echo'erreur';	
} else {
	require(dirname(__FILE__).'/../vue/vueSortie.php');

}


	

?>