<?php
if( isset($_GET['index']) && is_numeric($_GET['index']) )
    $page = $_GET['index'];
else
    $page = 0;


$nombre_page=Membre::nombreDePage();
$ClassMembree=new Membre('','','','','','','','','');
$membres = $ClassMembree->afficheListeMembres($page);
if (empty($membres)) {
	echo'erreur';	
} else {
	require(dirname(__FILE__).'/../vue/vueMembres.php');
}
?>

