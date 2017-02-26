<?php

//select info in database : Model
try{
$getKeywordsFamilies = $db->prepare("SELECT id,name FROM keywords_families kf");
$getKeywordsFamilies->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler

//put in $data : Vue
$data['keywordsFamilies'] = $getKeywordsFamilies->fetchAll();
?>
