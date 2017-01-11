<?php

//select info in database : Model
try{
$getURIs = $db->prepare("SELECT id as id_URI,name,base,created_at,updated_at FROM URI_source");
$getURIs->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler


//put in $data : Vue
$data['URIs'] = $getURIs->fetchAll(PDO::FETCH_ASSOC);
?>
