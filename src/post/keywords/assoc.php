<?php
if(empty($_POST['language'])){
  errorJSON("no language",400);
}
if(empty($_POST['text'])){
  errorJSON("no text",400);
}
if(empty($_POST['entity'])){
  errorJSON("no entity",400);
}
try{
//Find keyword


//if no keyword found, create one
$insertNewkeyword = $db->prepare("");
$insertNewKeyword->execute();


//Assoc to entity


}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}

?>
