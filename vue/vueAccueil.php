<div class="content1">
	<h2>Sorties à Venir	 :  </h2>
    	<div class="CSSTableGenerator" >
            <table>
                <tr><td>Date</td>
                <td>Heure Depart</td>
                <td>Site</td>
                <td>Organisateur</td>
                </tr>
                <?php
                foreach ($sorties as $s){
                    echo '
                    <tr>
                        <td>'. $s->getDate() .'</td>
                        <td>'. $s->getHeure() .' h</td>
                        <td>'. $s->getSite() .'</td>
                        <td>'. $s->getOrganisateur() .'</td>
                    </tr>';
                    }?>
        
        </table>
	</div>
</div>


<div class="content2">

<img id="imageAccueil" src="<?php echo $path; ?>" alt="Mountain View" >

</div>



<div class="content3">
    
    <h2>Informations Generales</h2>
    
    <p>Escalatech est le club d’escalade de Polytech créée en 2010 qui permet aux grimpeurs de se réunir les jeudi après-midi ou week-end pour aller grimper en salle ou en falaise. L’adhésion au club est gratuite. Les rendez vous se font généralement devant Polytech afin d'aller sur le lieux de grimp' en covoiturage.</p>

</div>