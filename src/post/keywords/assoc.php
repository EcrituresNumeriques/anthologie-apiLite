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
  $data['KeywordFound'] = $keyword;
}
else{
  if(empty($_POST['description'])){
    errorJSON("no description",400);
  }
  if(empty($_POST['family'])){
    errorJSON("no family",400);
  }

//if no keyword found, create one
$insertNewkeyword = $db->prepare("INSERT INTO keywords (keyword_family,user_id,group_id,created_at,updated_at) VALUES (:family,:user,:group,NOW(),NOW())");
$insertNewkeyword->bindParam(":family",$_POST['family']);
$insertNewkeyword->bindParam(":user",$user['user']['id']);
(!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
$insertNewkeyword->bindParam(":group",$user['user']['groups'][0]);
$insertNewkeyword>execute();
$keyword = $db->lastInsertId();
$data['newKeyword'] = $keyword;
//add new translation
$insertTranslation = $db->prepare("INSERT INTO keywords_translations kt (keyword_id,user_id,group_id,language_id,title,description,created_at,updated_at) VALUES (:keyword,:user,:group,:lang,:text,:description,NOW(),NOW())");
$insertTranslation->bindParam(":keyword",$keyword);
$insertTranslation->bindParam(":user",$user['user']['id']);
(!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
$insertTranslation->bindParam(":group",$user['user']['groups'][0]);
$insertTranslation->bindParam(":lang",$_POST['language']);
$insertTranslation->bindParam(":text",$_POST['text']);
$insertTranslation->bindParam(":description",$_POST['description']);
$insertTranslation->execute();
}

//Assoc to entity
$assocKeyword = $db->prepare("INSERT INTO entities_keywords_assoc eka (entities_id,keywords_id) VALUES (:entity,:keyword) ON DUPLICATE KEY UPDATE keyword_id = keywords_id");
$assocKeyword->bindParam(":entity",$_POST['entity']);
$assocKeyword->bindParam(":keyword",$keyword);
$assocKeyword->execute();

}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}

?>
