<?php


if(Membre::estAdmin($_COOKIE['email'])){
	
			
	require(dirname(__FILE__).'/../modele/Sortie.php');
	require(dirname(__FILE__).'/../modele/Site.php');


		// SI le formulaire est envoyé
	if (!empty($_POST['modifSortie'])) {
		if (isset($_GET['numEvt'])){
			$numEvt = htmlentities($_GET['numEvt'], ENT_QUOTES, 'UTF-8');	
		}
		
		if (isset($_POST['dateSortie'])){
			$date = htmlentities($_POST['dateSortie'], ENT_QUOTES, 'UTF-8');
		}
		$heureDebut="";
		if (isset($_POST['heureDebut'])){
			$heureDebut = htmlentities($_POST['heureDebut'], ENT_QUOTES, 'UTF-8');
		}       
		$site="";
		if (isset($_POST['site'])){
			$site = htmlentities($_POST['site'], ENT_QUOTES, 'UTF-8');
		}
		if (!empty($date) && $date != null ){
			if (!empty($heureDebut) && $heureDebut != null ){
				if (!empty($site) && $site != null ){
					$ClassSortie=new Sortie($numEvt,$date,$heureDebut,$site,Membre::nomUser($_COOKIE['email']));
					$ClassSortie->update();
					$valide = "succes modification";
				}else{
					$error = "il faut choisir le lieux de la sortie";	
				}
			}else{
				$error = "Il manque l'heure de début";	
		}
		}else{
			$error = "Il manque la date de la sortie";	
		}
	}
	
	
	
	
	
	function choixSite($site=0){
		$ClassSite=new Site('','','','','');
		$sites = $ClassSite->recupereListeSites();
		echo 'Lieux : <select name="site">';
		
		foreach ($sites as $s){
			echo '<option ';
			if($s->getNomSite() == $site){
				echo'selected="selected"';
			}
			echo 'value='.$s->getID().'>
			'.$s->getNomSite().'
			</option>
			';
		}
		echo '</select>';
		
	}
	
	
	if (isset($_GET['numEvt'])){
		$numEvt = htmlentities($_GET['numEvt'], ENT_QUOTES, 'UTF-8');
		$sortie=Sortie::recupereLaSortie($numEvt);
		require(dirname(__FILE__).'/../vue/vueModifEvt.php');
		
		
	}

	
}
?>

