<?php

//select info in database : Model
try{
$getEntities = $db->prepare("SELECT * FROM URId d WHERE d.value = :value");
$uri = urldecode($_GET['uri']);
$getEntities->bindParam(":value",$uri);
$getEntities->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler


//put in $data : Vue
$data['entities'] = $getEntities->fetchAll(PDO::FETCH_ASSOC);
$data['query'] = $uri;
?>
