<?php

//select info in database : Model
try{
  $getEntities = $db->prepare("SELECT e.id as id_entity,e.book_id,e.era_id,e.genre_id,e.title,e.date,e.date_range FROM entities e WHERE id = :id");
  $getEntities->bindParam(":id",$_GET['entity']);
  $getEntities->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler


//put in $data : Vue
$data['entities'] = $getEntities->fetchAll(PDO::FETCH_ASSOC);
?>
