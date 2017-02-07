<?php

if(empty($_POST['pair'])){
  errorJSON('Pair not specified',400);
}
if(empty($_POST['data'])){
  errorJSON('JSON data align not specified',400);
}

if($_POST['data'] != json_encode(json_decode($_POST['data']))){
  errorJSON('JSON data align not proper JSON',400);
}

$setAlign = $db->prepare("INSERT INTO entities_translations_align (pair,json,user_id,group_id,created_at,modified_at) VALUES (:pair,:json,:user,:group,NOW(), NOW()) ON DUPLICATE KEY UPDATE SET modified_at = NOW(), json = :json");
$setAlign->bindParam(":pair",$_POST['pair']);
$setAlign->bindParam(":json",$_POST['data']);
$setAlign->bindParam(":user",$user['user']['id']);
(!empty($user['user']['groups'][0])?:$user['user']['groups'][0] = NULL);
$setAlign->bindParam(":group",$user['user']['groups'][0]);
$setAlign->execute() or die('unable to get alignements');
?>
