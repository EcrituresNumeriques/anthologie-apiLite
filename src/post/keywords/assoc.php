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
$getKeyword = $db->prepare("SELECT keyword_id FROM keywords_translations kt WHERE language_id = :lang AND title = :text");
$getKeyword->bindParam(":lang",$_POST['language']);
$getKeyword->bindParam(":text",$_POST['text']);
$getKeyword->execute();
if($getKeyword->rowCount() > 0){
  $keyword = $getKeyword->fetch(PDO::FETCH_ASSOC);
  $keyword = $keyword['keyword_id'];
}

//if no keyword found, create one
$insertNewkeyword = $db->prepare("");
$insertNewKeyword->execute();


//Assoc to entity


}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}

?>
