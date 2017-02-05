<?php
if(is_numeric($_POST['entity']) && !empty($_POST['url'])){
  //TODO: If a file is provided, grab a copy on the server

  try{
  $insertNewImage = $db->prepare("INSERT INTO images (user_id,group_id,URL,title,credit) VALUES (:user,:group,:url,:title,:credit)");
  $insertNewImage->bindParam(":url",$_POST['url']);
  $title = (!empty($_POST['title'])?$_POST['title']:NULL);
  $insertNewImage->bindParam(":title",$title);
  $credit = (!empty($_POST['credit'])?$_POST['credit']:NULL);
  $insertNewImage->bindParam(":credit",$credit);
  $insertNewImage->bindParam(":user",$user['user']['id']);
  (!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
  $insertNewImage->bindParam(":group",$user['user']['groups'][0]);
  $insertNewImage->execute();

  $imageId = $db->lastInsertId();
  //add assoc
  $insertAssocImage = $db->prepare("INSERT INTO entities_images_assoc (entity_id,image_id) VALUES(:entity,:image)");
  $insertAssocImage->bindParam(":entity",$_POST['entity']);
  $insertAssocImage->bindParam(":image",$imageId);
  $insertAssocImage->execute();
  }
  catch(Exception $e){
    errorJSON('SQL error : ' . $e->getMessage(),500);
  }
  $data['newImage'] = $_POST['url'];
}
else{
  errorJSON("missing information",400);
}
?>
