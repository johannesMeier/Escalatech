

<div class="contenu">
    <center><h1>Sites<h1></center>

        <?php
		foreach ($sites as $s){
			echo '
				<div class="site">
					<div class="TitreSite">
						<h2>'. $s->getNomSite() .'</h2>
						<h3>'. $s->getSecteurSite() .'</h3>
					</div>
					<div class="informationSite">'. $s->getDescriptionSite() .' 
					</div>
                    	<a href="'.$s->getTopoSite().'" onclick="window.open(this.href,"Topo","menubar=no,width=700,height=750,toolbar=no,location=no,screenX=200,scrollbars=yes,screenY=200"
        );
        return false;">'; 
					if ($s->getTopoSite()==NULL){}else {echo '<div class="voirTopo"></div>';}
					echo'</a>
        			
					
				</div>
				<hr/>';
			}?>		
</div>
