<?php
if(is_numeric($_POST['URI']) && is_numeric($_POST['entity']) && !empty($_POST['destination'])){
  try{
    //grab info from URI_source
    $getURI_source = $db->prepape("SELECT * FROM URI_source WHERE id = :URI");
    $getURI_source->bindParam(":URI",$_POST['URI']);
    $getURI_source->execute();
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

  $insertNewURId = $db->prepare("INSERT INTO URI (entity_id,user_id,group_id,urid_source_id, value, URN) VALUES (:entity,:user,:group,:URI,:text,:URN,NOW(),NOW())");
  $insertNewURId->bindParam(":entity",$_POST['entity']);
  $insertNewURId->bindParam(":user",$user['user']['id']);
  (!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
  $insertNewURId->bindParam(":group",$user['user']['groups'][0]);
  $insertNewURId->bindParam(":URI",$_POST['URI']);
  $insertNewURId->bindParam(":text",$source);
  $insertNewURId->bindParam(":URN",$URN);
  $insertNewURId->execute();
  }
  catch(Exception $e){
    errorJSON('SQL error : ' . $e->getMessage(),500);
  }
}
else{
  errorJSON("missing information",400);
}
