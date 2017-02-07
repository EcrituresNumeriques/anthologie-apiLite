<?php
if(is_numeric($_POST['entity']) && is_numeric($_POST['language']) && !empty($_POST['text'])){
  try{
    //add new scholie
    $insertScholie = $db->prepare("INSERT INTO scholies (user_id,group_id,created_at,updated_at) VALUES (:user, :group, NOW(), NOW())");
    $insertScholie->bindParam(":user",$user['user']['id']);
    (!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
    $insertScholie->bindParam(":group",$user['user']['groups'][0]);
    $insertScholie->execute() or die('Unable to add scholie');

    $scholieID = $db->lastInsertId();

    //assoc this scholie with entity
    $assocScholie = $db->prepare("INSERT INTO entities_scholies_assoc (entities_id,scholies_id) VALUES (:entity,:scholie)");
    $assocScholie->bindParam(":entity",$_POST['entity']);
    $assocScholie->bindParam(":scholie", $scholieID);
    $assocScholie->execute() or die('Unable to assoc scholie');

    //translate this scholie
    $translateScholie = $db->prepare("INSERT INTO scholies_translation (scholie_id,user_id,group_id,language_id,text_translated,created_at,updated_at) VALUES (:scholie, :user, :group, :language, :text, NOW(), NOW())");
    $translateScholie->bindParam(":scholie", $scholieID);
    $translateScholie->bindParam(":user",$user['user']['id']);
    (!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
    $translateScholie->bindParam(":group",$user['user']['groups'][0]);
    $translateScholie->bindParam(":language",$_POST['language']);
    $translateScholie->bindParam(":text",$_POST['text']);
    $translateScholie->execute() or die('Unable to add scholie translation');

  }
  catch(Exception $e){
    errorJSON('SQL error : ' . $e->getMessage(),500);
  }
}
else{
  errorJSON("missing information",400);
}
?>
