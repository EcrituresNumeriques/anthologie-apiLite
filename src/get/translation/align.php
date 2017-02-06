<?php

if(empty($_GET['id'])){
  errorJSON('First ID not specified',500);
}
if(empty($_GET['id2'])){
  errorJSON('Second ID not specified',500);
}

//id is always the smallest
if($_GET['id'] > $_GET['id2']){
  $tmp = $_GET['id'];
  $_GET['id'] = $_GET['id2'];
  $_GET['id2'] = $tmp;
}


$getAlign = $db->prepare("SELECT json FROM entities_translations_align WHERE pair = :pair");
$pair = $_GET['id'].";".$_GET['id2'];
$getAlign->bindParam(":pair",$pair);
$getAlign->execute() or die('unable to get alignements');

if($getAlign->rowCount > 0){
$data['align'] = $getAlign->fetch(PDO::FETCH_ASSOC);
}
else{
$getTranslations = $db->prepare("SELECT * FROM `entities_translations` where id = :id OR id = :id2");
$getTranslations->bindParam(":id",$_GET['id']);
$getTranslations->bindParam(":id2",$_GET['id2']);
$getTranslations->execute() or die('Unable to get translations');
$data['translation'] = $getTranslations->fetchAll(PDO::FETCH_ASSOC);
}



?>
