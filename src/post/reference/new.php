<?php
if(is_numeric($_POST['entity']) && is_numeric($_POST['destination'])){
  try{
    //add new Texts
    $insertRefs = $db->prepare("INSERT INTO `entities_references` (source,destination) VALUES (:source, :destination)");
    $insertRefs->bindParam(":source",$_POST['entity']);
    $insertRefs->bindParam(":destination",$_POST['destination']);
    $insertRefs->execute() or die('Unable to add texts');
  }
  catch(Exception $e){
    errorJSON('SQL error : ' . $e->getMessage(),500);
  }
}
else{
  errorJSON("missing information",400);
}
?>
