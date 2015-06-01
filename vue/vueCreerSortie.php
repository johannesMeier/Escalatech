<div class="contenu">
    <center><h1>Creer Sortie<h1></center>
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
		 <input class="form-field" type="date" value="<?php if (isset($_POST['dateSortie']))?>" placeholder="Date Sortie" name="dateSortie" />
         <input class="form-field" type="time" value="14:00" placeholder="HH" name="heureDebut" /> 
			<?php 
			choixSite();
			?>
            
            
          <div class="submit-container">
          	<input name="creerSortie" class="submit-button" type="submit" value="Proposer" />
           </div>
    </form>
</div>