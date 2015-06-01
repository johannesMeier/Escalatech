<?php



require(dirname(__FILE__).'/../modele/Site.php');



$ClassSite = new Site('','','','','');

$sites = $ClassSite->recupereAllSites();

if (empty($sites)) {

	echo'erreur';	

} else {

	require(dirname(__FILE__).'/../vue/vueSites.php');

}

	

	

?>

