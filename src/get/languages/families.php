<?php

//select info in database : Model
try{
$getFamilies = $db->prepare("SELECT DISTINCT family FROM languages l");
$getFamilies->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler


//put in $data : Vue
$data['lang_families'] = $getFamilies->fetchAll(PDO::FETCH_ASSOC);
?>
