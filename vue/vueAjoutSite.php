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
    
    
    
    <form class="form-container" method="post" action="#" >
		 <input class="form-field" value="" placeholder="nomSite" name="nomSite" />
         <input class="form-field" value="" placeholder="SecteurSite" name="SecteurSite" />
         <textarea maxlength="5000" value="" placeholder="descriptionSite" name="descriptionSite">
         </textarea>
          <div class="submit-container">
          	<input name="ajoutSite" class="submit-button" type="submit" value="Proposer" />
           </div>
    </form>
</div>