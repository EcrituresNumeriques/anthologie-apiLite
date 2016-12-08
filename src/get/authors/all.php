<?php

//select info in database : Model
try{
$getAuthors = $db->prepare("SELECT a.*,at.name,l.name as lang,l.family FROM authors a JOIN author_translations at ON a.id = at.author_id JOIN languages l ON at.language_id = l.id");
$getAuthors->execute();
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

//put in $data : Vue
$data['authors'] = $authors



?>
