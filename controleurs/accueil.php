<?php



require(dirname(__FILE__).'/../modele/Sortie.php');

$ClassSortie = new Sortie('','','','','');

$sorties = $ClassSortie->recupereSortie();

if (empty($sorties)) {

	echo'erreur';	

} else {
	$i=rand(1, 22);
	$path = '/Escalatech/photos/photo'. $i .'.png';
	require(dirname(__FILE__).'/../vue/vueAccueil.php');

}

	

	

?>



