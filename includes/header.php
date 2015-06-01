<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
  xml:lang="fr" lang="fr">
<head>
  <meta http-equiv="Content-Type"
    content="text/html; charset=UTF-8" />
  <title>Escalatech</title>
  <meta name="description"
    content="" />
  <meta name="keywords"
    content="" />
   <script type="text/javascript" src="./script/menu.js"></script>
  <link rel="stylesheet" href="./styles/css/global.css"/>

<!--  <link rel="stylesheet" href="./styles/css/bootstrap.css"/> -->
</head>
    <body>
    
    <div id="global">
      <header id="header">
		<?php
		if (isset($email) && isset($mdp)){
			if (Membre::mdpCorrect($email,md5($mdp))){
				require(dirname(__FILE__).'/../vue/vueConnecte.php'); 
			}
			}elseif (isset($_COOKIE['Connexion'])){
				if (Membre::estConnecter($_COOKIE['Connexion'],'maildejohannes.34@gmail.com') or Membre::mdpCorrect(isset($email),md5(isset($mdp)))){//$_COOKIE['email']
					require(dirname(__FILE__).'/../vue/vueConnecte.php'); 
				}else{
					require(dirname(__FILE__).'/../vue/vueConnexion.php');
				}
			}else{
				require(dirname(__FILE__).'/../vue/vueConnexion.php');
			}?>
		<nav >
          <ul id="menu">
          
            <li><a href="index.php?page=accueil">Club</a> 
                <ul>
					<li><a href="index.php?page=membres">Membres</a></li>
				</ul>
            </li>
            
            <li><a href="index.php?page=sortie">Sortie</a> 
            <?php 	if(Membre::estAdmin($_COOKIE['email'])){
    		            echo'<ul>
								<li><a href="index.php?page=creerSortie">Créer Sortie</a></li>
							</ul>';
					}
			?>
            </li>
            
            <li><a href="index.php?page=sites">Sites</a>
             <?php 	if(Membre::estAdmin($_COOKIE['email'])){
    		          echo'<ul>
					  			<li><a href="index.php?page=ajouterSite">Ajouter Site</a></li>
						   </ul>';
					}
			?>
            </li>
          </ul>
        </nav> 
      </header>