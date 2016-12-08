<?php

//select info in database : Model
try{
$getAuthors = $db->prepare("SELECT * FROM authors");
$getAuthors->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler


//put in $data : Vue
$data['authors'] = $getAuthors->fetchAll(PDO::FETCH_ASSOC);
?>
