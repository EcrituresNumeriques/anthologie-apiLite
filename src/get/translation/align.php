<?php

$getTranslations = $db->prepare("SELECT * FROM `entities_translations` where id = :id OR id = :id2");
$getTranslations->bindParam(":id",$_GET['id']);
$getTranslations->bindParam(":id",$_GET['id2']);
$getTranslations->execute() or die('Unable to get translations');
$data['translation'] = $getTranslations->fetchAll(PDO::FETCH_ASSOC);



?>
