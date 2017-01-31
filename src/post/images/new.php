<?php
if(is_numeric($_POST['entity']) && (!empty($_POST['url']) OR !empty($_FILES['file']))){


  //If file is provided, this is the source
  if(!empty($_FILES['file'])){
    $raw = $_FILES["file"]["tmp_name"];
  }
  else{
    $raw=$_POST['url'];
  }

  if (!empty($raw)) {
      // AJAX call
      $time = time();
      $path = "media/img/";
      if (!file_exists($path)) {
          //echo("creating folder");
          mkdir($path, 0777, true);
      }
      $myUpload = file_get_contents($raw);
      $image = imagecreatefromstring($myUpload);
      if($image !== false){
          $imageName = $user['user']['id']."-".time()."cover.jpg";
          imagealphablending($image, FALSE);
          imagesavealpha($image, TRUE);
          imagejpeg($image,$path.$imageName,75);
      }
      else{
        errorJSON("Unable to process image",400);
      }


      //file_put_contents('media/img/'.$_POST['campaign']."/".$fn,$myUpload);
  }
  else{
      errorJSON("Unable to access image",400);
  }



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
