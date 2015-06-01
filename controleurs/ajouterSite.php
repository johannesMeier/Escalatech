<?php


if(Membre::estAdmin($_COOKIE['email'])){
	
			
	require(dirname(__FILE__).'/../modele/Site.php');
	
		// SI le formulaire est envoyé
	
	if (!empty($_POST['ajoutSite'])) {
		if (isset($_POST['nomSite'])){
			$nomSite = htmlentities($_POST['nomSite'], ENT_QUOTES, 'UTF-8');
		}
		if (isset($_POST['SecteurSite'])){
			$SecteurSite = htmlentities($_POST['SecteurSite'], ENT_QUOTES, 'UTF-8');
		}       
		$descriptionSite="";
		if (isset($_POST['descriptionSite'])){
			$descriptionSite = htmlentities($_POST['descriptionSite'], ENT_QUOTES, 'UTF-8');
		}
		$topoSite=NULL;
		if (isset($_POST['topoSite'])){
			$topoSite = htmlentities($_POST['topoSite'], ENT_QUOTES, 'UTF-8');
		}
		
		
		if (!empty($nomSite) && $nomSite != null ){
			if (!empty($SecteurSite) && $SecteurSite != null ){
				if (!empty($descriptionSite) && $descriptionSite != null ){
					$ClassSite=new Site('',$nomSite,$SecteurSite,$descriptionSite,$topoSite);
					if($ClassSite->save()){
						$valide = "succes creation";
					}else{
						$error = "Un problème est survenue";	
					}
				}else{
					$error = "il faut choisir le lieux de la sortie";	
				}
			}else{
				$error = "Il Faut donner un nom au secteur";	
		}
		}else{
			$error = "Il faut donner un nom au site";	
		}
	}
	

	require(dirname(__FILE__).'/../vue/vueAjoutSite.php');
}
?>

