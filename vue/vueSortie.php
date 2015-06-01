

<div class="contenu">
    <center><h1>Sortie<h1></center>
    
    
    	<?php 
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
    
    
    <div class="CSSTableGenerator" >
        <table>
            <tr>
                <td>Date</td>
                <td>Heure Depart</td>
                <td>Site</td>
                <td>Organisateur</td>
                <td>inscription</td>
                <td>Participants</td>
<?php       if(Membre::estAdmin($_COOKIE['email'])){
                echo'<td>Modifiacation</td>
                <td>Suppression</td>';}?>
            </tr>
            <?php
            foreach ($sorties as $s){
                echo '
                <tr>
                    <td>'. $s->getDate() .'</td>
                    <td>'. $s->getHeure() .' h</td>
                    <td>'. $s->getSite() .'</td>
                    <td>'. $s->getOrganisateur() .'</td>
                    <td>';
					if (!Participant::estInscrit($s->getID(),Membre::idUser($_COOKIE['email']))){
                     echo '<form method="post" action="#">
                        <div class="submit-container">
                            <input name="idEvt" type="hidden" value="'.$s->getID().'" />
                            <input name="inscriptionEvt" class="submit-button" type="submit" value="Inscrire" />
                         </div>
                     </form>';}
					echo'
                    </td>
                    <td><a href="index.php?page=participant&numEvt='.$s->getID().'">Voir</a></td>';
                    if(Membre::estAdmin($_COOKIE['email'])){
                        echo '<td><a href="index.php?page=modifierEvt&numEvt='.$s->getID().'">Modifier</a></td>
                        <td>
                        <form method="post" action="#">
                            <input name="idEvt" type="hidden" value="'.$s->getID().'" />
                            <input class="supprimerElt" name="supprimerEvt"  type="submit" value="supprimer"/>
                        </form>
                        </td>
                    </tr>';
                    }
                
                }?>
    
        </table>
       </div>
</div>