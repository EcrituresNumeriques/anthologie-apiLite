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
$insertNewkeyword = $db->prepare("");
$insertNewKeyword->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}

?>
