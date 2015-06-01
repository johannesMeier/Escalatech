<?php
class Connexion{
	private static $user='';
	private static $pass='';
	private $dbh;
	
	public function __construct(){
		$u=self::$user;
		$m=self::$pass;
		try{
			$this->dbh= new PDO('mysql:host='._DB_SERVER_.';dbname='._DB_NAME_.'',$u,$m);
		} 
		catch ( Exception $e ) {
			echo "Connection à MySQL impossible : ", $e->getMessage();
			die();
		}
		
	}
	
	public function pdo(){
		return $this->dbh;
	}
}
