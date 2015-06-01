    
    	<?php 
		
		
	echo'<div class="contenu">
    <center><h1>Sortie "'.$sortie->getSite().'" le '.$sortie->getDate().' a '.$sortie->getHeure().'<h1></center>';
  
	if (isset($erreur)){
		echo'
		<div class="isa_error">
			'.$erreur.'
		</div>';
	}
	if (isset($valide)){
		echo'
		<div class="isa_success">
			'.$valide.'
		</div>';
	}
	?>
    
 

	<div class="CSSTableGenerator">
        <table>
          
            <tr>
            <td>Nom</td>
            <td>Prenom</td>
            <td>Numero</td>
            </tr>
            <?php
            foreach ($Participants as $p){
                echo '
                <tr>
                    <td>'. $p->getidnomMembre() .'</td>
                    <td>'. $p->getprenomMembre() .' </td>
                    <td>'. $p->gettel() .'</td>
                </tr>';
                }?>
    
        </table>
    </div>
</div>  