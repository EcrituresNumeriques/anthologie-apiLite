<?php
if(is_numeric($_POST['entity']) && (!empty($_POST['url']) OR !empty($_FILES['file']))){
  try{
  $insertNewImage = $db->prepare("INSERT INTO images (user_id,group_id,URL) VALUES (:user.:group,:url)");
  $insertNewImage->bindParam(":url",$_POST['url']);
  $insertNewImage->bindParam(":user",$user['user']['id']);
  (!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
  $insertNewImage->bindParam(":group",$user['user']['groups'][0]);
  $insertNewImage->execute();
  }
  catch(Exception $e){
    errorJSON('SQL error : ' . $e->getMessage(),500);
  }
}
else{
  errorJSON("missing information",400);
}
?>
