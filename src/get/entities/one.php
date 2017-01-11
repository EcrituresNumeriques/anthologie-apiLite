<?php

//select info in database : Model
try{
  $getEntities = $db->prepare("SELECT e.id as id_entity,e.book_id,e.era_id,e.genre_id,e.title,e.date,e.date_range FROM entities e WHERE id = :id");
  $getEntities->bindParam(":id",$_GET['entity']);
  $getEntities->execute();

  $getAuthors = $db->prepare("SELECT a.*,at.name,l.name as lang,l.family FROM entities_authors_assoc eaa JOIN authors a ON eaa.authors_id = a.id JOIN author_translations at ON a.id = at.author_id JOIN languages l ON at.language_id = l.id WHERE eaa.entities_id = :id");
  $getAuthors->bindParam(":id",$_GET['entity']);
  $getAuthors->execute();

  $getTitleTranslation = $db->prepare("SELECT et.id,et.text_translated,l.name as lang,l.family FROM entities_translations et JOIN languages l ON et.language_id = l.id WHERE et.entity_id = :id");
  $getTitleTranslation->bindParam(":id",$_GET['entity']);
  $getTitleTranslation->execute();

  $getURI = $db->prepare("SELECT s.name,d.value,d.URN FROM URId d LEFT JOIN URI_source s ON d.urid_source_id = s.id WHERE d.id_entity = :id");
  $getURI->bindParam(":id",$_GET['entity']);
  $getURI->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}


//treat information : Controler

$intermediaire = $getAuthors->fetchAll(PDO::FETCH_ASSOC);
$authors = array();
foreach ($intermediaire as $author) {
  if(empty($authors[$author['id']])){
    $authors[$author['id']] = array(
      "id" => $author['id'],
      "born" => $author['born'],
      "died" => $author['died'],
      "born_range" => $author['born_range'],
      "died_range" => $author['died_range'],
    );
  }
  $authors[$author['id']]['name'][] = array(
    "name"=>$author['name'],
    "lang"=>$author['lang'],
    "family"=>$author['family']
  );
}
//remove indexes
$unorderedAuthors = array();
foreach ($authors as $key => $value) {
  array_push($unorderedAuthors,$value);
}
unset($authors);


//put in $data : Vue
$data['entities'] = $getEntities->fetchAll(PDO::FETCH_ASSOC);
$data['entities'][0]['authors'] = $unorderedAuthors;
$data['entities'][0]['translation'] = $getTitleTranslation->fetchAll(PDO::FETCH_ASSOC);
$data['entities'][0]['URI'] = $getURI->fetchAll(PDO::FETCH_ASSOC);
?>
