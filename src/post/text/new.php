<?php
if(is_numeric($_POST['entity']) && is_numeric($_POST['language']) && !empty($_POST['text'])){
  try{
    //add new Texts
    $insertTexts = $db->prepare("INSERT INTO `texts` (user_id,group_id,created_at,updated_at) VALUES (:user, :group, NOW(), NOW())");
    $insertTexts->bindParam(":user",$user['user']['id']);
    (!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
    $insertTexts->bindParam(":group",$user['user']['groups'][0]);
    $insertTexts->execute() or die('Unable to add texts');

    $textsID = $db->lastInsertId();

    //assoc this Texts with entity
    $assocTexts = $db->prepare("INSERT INTO entities_texts_assoc (entities_id,texts_id) VALUES (:entity,:texts)");
    $assocTexts->bindParam(":entity",$_POST['entity']);
    $assocTexts->bindParam(":texts", $textsID);
    $assocTexts->execute() or die('Unable to assoc texts');

    //translate this Texts
    $translateTexts = $db->prepare("INSERT INTO texts_translations (texts_id,user_id,group_id,language_id,text_translated,created_at,updated_at) VALUES (:textid, :user, :group, :language, :text, NOW(), NOW())");
    $translateTexts->bindParam(":textid", $textsID);
    $translateTexts->bindParam(":user",$user['user']['id']);
    (!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
    $translateTexts->bindParam(":group",$user['user']['groups'][0]);
    $translateTexts->bindParam(":language",$_POST['language']);
    $translateTexts->bindParam(":text",$_POST['text']);
    $translateTexts->execute() or die('Unable to add Texts translation');

  }
  catch(Exception $e){
    errorJSON('SQL error : ' . $e->getMessage(),500);
  }
}
else{
  errorJSON("missing information",400);
}
?>
