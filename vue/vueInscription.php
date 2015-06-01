  
  <div class="contenu">

    <center><h1>Sites<h1></center>
      	<?php 
		if ($erform==true){
			echo'<div class="isa_error">'.$message.'</div>';
		}elseif($erform==false && ($message!=null or $message!='') ){
			echo'<div class="isa_success">'.$message.'</div>';
		}?>
        <form class="form-container" method="post" action="#">
            <div class="form-title"><h2>Inscription</h2></div>
            <div class="form-title">inscription</div>
            <input class="form-field" type="text" placeholder="email" name="email" id="email" required="required"/><br />
			<input class="form-field" type="password" placeholder="mot de passe" name="mdp" id="mdp" required="required" /><br />
			<input class="form-field" type="password" placeholder="mot de passe" name="mdp2" id="mdp2" required="required" /><br />	
            <input class="form-field" type="text" placeholder="Nom" name="nomMembre" id="nomMembre" required="required"/><br />
			<input class="form-field" type="text" placeholder="Prenom" name="prenomMembre" id="prenomMembre" required="required" /><br />

            <div class="form-title">information complementaire</div>

            <input class="form-field" type="text" placeholder="niveau escalade" name="niveau" /><br />
			<input class="form-field" type="int" placeholder="Tel" name="tel" id="tel"/><br />
           
            <div class="submit-container">
            <input name="inscription" class="submit-button" type="submit" value="Envoyer" />
            </div>
		</form>
  </div>