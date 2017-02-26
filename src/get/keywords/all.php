<?php

//select info in database : Model
try{
$getKeywords = $db->prepare("SELECT k.id, kf.name as category, kt.title, kt.description, l.name, l.family FROM `keywords` k
    JOIN keywords_families kf ON k.keyword_family = kf.id
    JOIN keywords_translations kt ON k.id = kt.keyword_id
    JOIN languages l ON kt.language_id = l.id ORDER BY k.id
  ");
$getKeywords->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler
$rawKeywords = $getKeywords->fetchAll(PDO::FETCH_ASSOC);
$keywords = array();
foreach ($rawKeywords as $keyword) {
  $keywords[$keyword['id']]['id'] = $keyword['id'];
  $keywords[$keyword['id']]['category'] = $keyword['category'];
  $keywords[$keyword['id']]['translations'][] = array(
    "title"=>$keyword['title'],
    "description"=>$keyword['description'],
    "lang"=>$keyword['name'],
    "family"=>$keyword['family'],
  );
}

//put in $data : Vue
$data['keywords'] = array_values($keywords);
?>
