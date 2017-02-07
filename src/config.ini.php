<?php
//include keys.ini
require_once('config.keys.ini.php');

//set crossOrigin valid
header('Access-Control-Allow-Origin: *');
//connect database
try{
    $db = new PDO("mysql:host=".$dbCredential['host'].";dbname=".$dbCredential['base'], $dbCredential['user'], $dbCredential['pass']);
    unset($dbCredential);
}
catch (Exception $e){
    die('Erreur : ' . $e->getMessage());
}

//set UTF by default
$db->query("SET NAMES UTF8");


//include function
include('function.php');

//manage token

?>
