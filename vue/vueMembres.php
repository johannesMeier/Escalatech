

<div class="contenu">
    <center><h1>Liste des Membres<h1></center>
    <div class="CSSTableGenerator" >
        <table>
            <tr>
                <td>Nom</td>
                <td>Prenom</th>
                <td>Niveau escalade</td>
                <td>numero</td>
                <td>Mail</td>
            </tr>
            <?php
            foreach ($membres as $s){
                echo '
                <tr>
    
                    <td>'. $s->getnomMembre() .' </td>
                    <td>'. $s->getPrenomMembre() .'</td>
                    <td>'. $s->getNiveau() .'</td>
                    <td>'. $s->getTel() .'</td>
                    <td>'. $s->getMail() .'</td>
    
                </tr>';
                }?>
    
        </table>
	</div>
    <ul id="menu-bar">
        <?php
        $i=0;
        while ($nombre_page >0){
            echo'
            <li class="pagination">
                <a href="index.php?page=membres&index='.$i.'">'.$i.'</a> 
            </li>';
        $nombre_page--;
        $i++;	
        }
        ?>
    </ul>
</div>