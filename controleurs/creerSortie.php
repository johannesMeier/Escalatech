<?php


if(Membre::estAdmin($_COOKIE['email'])){
	
			
	require(dirname(__FILE__).'/../modele/Sortie.php');
	require(dirname(__FILE__).'/../modele/Site.php');
	
		// SI le formulaire est envoyé
	if (!empty($_POST['creerSortie'])) {
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
					$ClassSortie=new Sortie('',$date,$heureDebut,$site,Membre::nomUser($_COOKIE['email']));
					if($ClassSortie->save()){
						$valide = "succes creation";}
					else{
						$error = "Un Problème est survenue";	
					}
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
	
	
	
	
	
	function choixSite(){
		$ClassSite=new Site('','','','','');
		$sites = $ClassSite->recupereListeSites();
		echo 'Lieux : <select name="site">';
		foreach ($sites as $s){
			echo '<option value='.$s->getID().'>
			'.$s->getNomSite().'
			</option>
			';
		}
		echo '</select>';
		
	}
	
	/*$ClassSite = new Site('','','','','');
	$sites = $ClassSite->recupereAllSites();*/
	require(dirname(__FILE__).'/../vue/vueCreerSortie.php');
}
?>

