<?php
if(is_numeric($_POST['URI']) && is_numeric($_POST['entity']) && !empty($_POST['destination'])){
  try{
    //grab info from URI_source
    $getURI_source = $db->prepare("SELECT * FROM URI_source WHERE id = :URI");
    $getURI_source->bindParam(":URI",$_POST['URI']);
    $getURI_source->execute();
  }
  catch(Exception $e){
    errorJSON('SQL error : ' . $e->getMessage(),500);
  }
  if($getURI_source->rowCount() > 0){
    $URI = $getURI_source->fetch(PDO::FETCH_ASSOC);
    //comparaison de la destination et de la source (voir si les URI match)
    if(startsWith($_POST['destination'],$URI['base'])){
        $source = $_POST['destination'];
        $URN = str_replace($URI['base'],'',$_POST['destination']);
    }
    else{
          errorJSON("URI destination doesn't match base source URI",400);
    }
  }
  else{
      errorJSON("unknown entity",400);
  }

  try{
  $insertNewURId = $db->prepare("INSERT INTO URId (entity_id,user_id,group_id,urid_source_id, value, URN,created_at,updated_at) VALUES (:entity,:user,:group,:URI,:text,:URN,NOW(),NOW())");
  $insertNewURId->bindParam(":entity",$_POST['entity']);
  $insertNewURId->bindParam(":user",$user['user']['id']);
  (!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
  $insertNewURId->bindParam(":group",$user['user']['groups'][0]);
  $insertNewURId->bindParam(":URI",$_POST['URI']);
  $insertNewURId->bindParam(":text",$source);
  $insertNewURId->bindParam(":URN",$URN);
  $insertNewURId->execute();
  $data['action'] = "URId added";
  }
  catch(Exception $e){
    errorJSON('SQL error : ' . $e->getMessage(),500);
  }

  if(!empty($_POST[authors])){
    $checkAuthor = $db->prepare("SELECT id_author FROM authors_authority WHERE URI = :uri");
    $addAuthor = $db->prepare("INSERT INTO authors (name) VALUES (:name)");
    $addAuthorURI = $db->prepare("INSERT INTO authors_authority (id_author,URI) VALUES (:author,:uri)");
    $addAuthorToEntity = $db->prepare("INSERT INTO entities_authors_assoc (entities_id,authors_id) VALUES(:entity,:author) ON DUPLICATE KEY update authors_id = authors_id");
    foreach ($_POST[authors] as $author) {
      $checkAuthor->bindParam(":uri",$authors['uri']);
      $checkAuthor->execute() or die('Unable to retrieve Author from URI');
      if($checkAuthor->rowCount() > 0){
        //Author found
        $authorInfo = $checkAuthor->fetch(PDO::FETCH_ASSOC);
        $authorID = $authorInfo['id_author'];
      }
      else{
        $addAuthor->bindParam(":name",$author['name']);
        $addAuthor->execute() or die('Unable to add New Author');
        $authorID = $db->lastInsertedId();
        $addAuthorURI->bindParam(":author",$authorID);
        $addAuthorURI->bindParam(":uri",$authors['uri']);
        $addAuthorURI->execute() or die('Unable to add Author URI');
      }
      //add Author to entity (if not already in it)
      $addAuthorToEntity->bindParam(":entity",$_POST['entity']);
      $addAuthorToEntity->bindParam(":author",$authorID);
      $addAuthorToEntity->execute() or die('Unable to bind author to entity');
    }
    $data['authors'] = $_POST['authors'];
  }

}
else{
  errorJSON("missing information",400);
}
