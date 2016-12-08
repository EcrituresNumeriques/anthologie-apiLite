<?php
//connect database
try
{
    $bdd = new PDO("mysql:host=".$dbCredential['host'].";dbname=".$dbCredential['base'], $dbCredential['user'], $dbCredential['pass']);
}
catch (Exception $e)
{
    die('Erreur : ' . $e->getMessage());
}
$unset($dbCredential);
$bdd->query("SET NAMES UTF8");


//include function
include('function.php');
//manage token

?>
