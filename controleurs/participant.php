
<?php


require(dirname(__FILE__).'/../modele/Sortie.php');
require(dirname(__FILE__).'/../modele/Participant.php');

if (isset($_GET['numEvt'])){
	$numEvt = htmlentities($_GET['numEvt'], ENT_QUOTES, 'UTF-8');
	$sortie=Sortie::recupereLaSortie($numEvt);
	$Participants = Participant::recupereListeParticipant($numEvt);
	
	if (empty($Participants)  ) {
	}
	
	if (empty($sortie) or empty($Participants) ) {
		
		require(dirname(__FILE__).'/../vue/vueErreurListeParticipant.php');
	} else {
	
		require(dirname(__FILE__).'/../vue/vueListeParticipants.php');
	
	}


}



?>

