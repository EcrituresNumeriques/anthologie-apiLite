<?php

//select info in database : Model
try{
$getLanguages = $db->prepare("SELECT l.id as id_lang, name, family FROM languages l");
$getLanguages->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler


//put in $data : Vue
$data['langs'] = $getLanguages->fetchAll(PDO::FETCH_ASSOC);
?>
