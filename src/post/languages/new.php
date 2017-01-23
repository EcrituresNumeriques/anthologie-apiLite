<?php
if(empty($_POST['family'])){
  errorJSON("no family",400);
}
if(empty($_POST['name'])){
  errorJSON("no name",400);
}
try{
$insertNewLanguage = $db->prepare("INSERT INTO languages (name, family, created_at, updated_at) VALUES (:name,:family,NOW(),NOW())");
$insertNewLanguage->bindParam(":name",$_POST['name']);
$insertNewLanguage->bindParam(":family",$_POST['family']);
$insertNewLanguage->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}


$data['newLanguageId'] = $db->lastInsertId();

?>
