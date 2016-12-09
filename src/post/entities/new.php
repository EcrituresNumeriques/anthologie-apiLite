<?php
if(empty($_POST['title'])){
  errorJSON("no title",400);
}
try{
$insertNewEntity = $db->prepare("INSERT INTO entities (title, created_at, updated_at) VALUES (:title,NOW(),NOW())");
$insertNewEntity->bindParam(":title",$_POST['title']);
$insertNewEntity->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}


$data['newEntityId'] = $db->lastInsertId();

?>
