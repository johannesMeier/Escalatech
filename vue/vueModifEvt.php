<div class="contenu">
    <center><h1> Modifier Sortie<h1></center>
	<?php 
	if (isset($error)){
		echo'
		<div class="isa_error">
			'.$error.'
		</div>';
	}
	if (isset($valide)){
		echo'
		<div class="isa_success">
			'.$valide.'
		</div>';
	}
	?>
    
    
    
    <form class="form-container" method="post" action="#">
		 <input class="form-field" type="date" value="<?php echo $sortie->getDate(); ?>" placeholder="" name="dateSortie" />
         <input class="form-field" type="time" value="<?php echo $sortie->getHeure(); ?>" placeholder="" name="heureDebut" /> 
			<?php 
			choixSite($sortie->getSite());
			?>
            
            
          <div class="submit-container">
          	<input name="modifSortie" class="submit-button" type="submit" value="Proposer" />
           </div>
    </form>
</div>