<?php

//select info in database : Model
try{
$getLanguages = $db->prepare("SELECT l.id as id_lang, name, family, created_at,updated_at FROM languages l WHERE l.id = :id");
$getLanguages->bindParam(":id",$_GET['languageId']);
$getLanguages->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler


//put in $data : Vue
$data['langs'] = $getLanguages->fetchAll(PDO::FETCH_ASSOC);
?>
