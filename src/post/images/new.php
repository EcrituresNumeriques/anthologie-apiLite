<?php
if(is_numeric($_POST['entity']) && !empty($_POST['url'])){
  //TODO: If a file is provided, grab a copy on the server

  try{
  $insertNewImage = $db->prepare("INSERT INTO images (user_id,group_id,URL,title,credit) VALUES (:user.:group,:url,:title,:credit)");
  $insertNewImage->bindParam(":url",$_POST['url']);
  $title = (!empty($_POST['title'])?NULL:$_POST['title']);
  $insertNewImage->bindParam(":title",$title);
  $credit = (!empty($_POST['credit'])?NULL:$_POST['credit']);
  $insertNewImage->bindParam(":credit",$credit);
  $insertNewImage->bindParam(":user",$user['user']['id']);
  (!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
  $insertNewImage->bindParam(":group",$user['user']['groups'][0]);
  $insertNewImage->execute();
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
