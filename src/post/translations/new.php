<?php
if(is_numeric($_POST['entity']) && is_numeric($_POST['language']) && !empty($_POST['text'])){
  try{
  $insertNewTranslation = $db->prepare("INSERT INTO entities_translations (entity_id, user_id, group_id, language_id, text_translated, created_at, updated_at) VALUES (:entity,:user,:group,:language,:text,NOW(),NOW())");
  $insertNewTranslation->bindParam(":entity",$_POST['entity']);
  $insertNewTranslation->bindParam(":user",$user['user']['id']);
  (!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
  $insertNewTranslation->bindParam(":group",$user['user']['groups'][0]);
  $insertNewTranslation->bindParam(":language",$_POST['language']);
  $insertNewTranslation->bindParam(":text",$_POST['text']);
  $insertNewTranslation->execute();
  }
  catch(Exception $e){
    errorJSON('SQL error : ' . $e->getMessage(),500);
  }
}
else{
  errorJSON("missing information",400);
}
?>
