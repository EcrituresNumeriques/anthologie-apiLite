<?php

//select info in database : Model
try{
  $getEntities = $db->prepare("SELECT e.id as id_entity,e.book_id,e.era_id,e.genre_id,e.title,e.date,e.date_range FROM entities e WHERE id = :id");
  $getEntities->bindParam(":id",$_GET['entity']);
  $getEntities->execute();

  $getAuthors = $db->prepare("SELECT a.id,a.name as defaultName,a.born,a.born_range,a.died,a.died_range,at.name,l.name as lang,l.family FROM entities_authors_assoc eaa JOIN authors a ON eaa.authors_id = a.id LEFT JOIN author_translations at ON a.id = at.author_id LEFT JOIN languages l ON at.language_id = l.id WHERE eaa.entities_id = :id");
  $getAuthors->bindParam(":id",$_GET['entity']);
  $getAuthors->execute();

  $getTitleTranslation = $db->prepare("SELECT et.id,et.text_translated,l.name as lang,l.family FROM entities_translations et JOIN languages l ON et.language_id = l.id WHERE et.entity_id = :id");
  $getTitleTranslation->bindParam(":id",$_GET['entity']);
  $getTitleTranslation->execute();

  $getURI = $db->prepare("SELECT s.name,d.value,d.URN FROM URId d LEFT JOIN URI_source s ON d.urid_source_id = s.id WHERE d.entity_id = :id");
  $getURI->bindParam(":id",$_GET['entity']);
  $getURI->execute();

  $getImages = $db->prepare("SELECT i.URL,i.file,i.credit,i.date,:baseURL as baseURL FROM entities_images_assoc eia JOIN images i ON eia.image_id = i.id WHERE eia.entity_id = :id");
  $getImages->bindParam(":id",$_GET['entity']);
  $baseURl = (empty($_SERVER['HTTPS'])?"http://":"https://").$_SERVER['HTTP_HOST']."/media/";
  $getImages->bindParam(":baseURL",$baseURl);
  $getImages->execute();

  $getScholies = $db->prepare("SELECT * FROM entities_scholies_assoc esa JOIN scholies_translations st ON esa.scholies_id = st.scholie_id JOIN languages l ON st.language_id = l.id WHERE esa.entities_id = :id ORDER BY scholies_id ASC")
  $getScholies->bindParam(":id",$_GET['entity']);
  $getScholies->execute()

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
      "defaultName" => $author['defaultName'],
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

//filter scholies
$rawScholies = $getScholies->fetchAll(PDO::FETCH_ASSOC);
foreach ($rawScholies as $translation) {
  $scholies[$translation['scholies_id']]['id'] = $translation['scholies_id']
  $scholies[$translation['scholies_id']]['translation'][] = array(
    "family"=>$translation['family'],
    "name"=>$translation['name'],
    "text_translated"=>$translation['text_translated']
  )
}
$unorderedScholies = array();
foreach ($scholies as $key => $value) {
  array_push($unorderedScholies,$value);
}
unset($scholies);


//put in $data : Vue
$data['entities'] = $getEntities->fetchAll(PDO::FETCH_ASSOC);
$data['entities'][0]['authors'] = $unorderedAuthors;
$data['entities'][0]['translation'] = $getTitleTranslation->fetchAll(PDO::FETCH_ASSOC);
$data['entities'][0]['URI'] = $getURI->fetchAll(PDO::FETCH_ASSOC);
$data['entities'][0]['images'] = $getImages->fetchAll(PDO::FETCH_ASSOC);
$data['entities'][0]['scholies'] = $unorderedScholies;
?>
