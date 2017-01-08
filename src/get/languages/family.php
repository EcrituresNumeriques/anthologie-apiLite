<?php

//select info in database : Model
try{
$getFamily = $db->prepare("SELECT l.id as id_lang, name, family FROM languages l WHERE family=:family");
$getFamily->bindParam(":family",$_GET['name']);
$getFamily->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler


//put in $data : Vue
$data['langs'] = $getFamily->fetchAll(PDO::FETCH_ASSOC);
?>
