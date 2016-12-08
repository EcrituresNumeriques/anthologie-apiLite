<?php

//select info in database : Model
try{
$getAuthors = $db->prepare("SELECT * FROM authors a JOIN author_translations at ON a.id = at.author_id");
$getAuthors->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}
//treat information : Controler
$intermediaire = $getAuthors->fetchAll(PDO::FETCH_ASSOC);
$authors = array();
foreach ($intermediaire as $author) {
  $authors[$author['id']] = $author;
}

//put in $data : Vue
$data['authors'] = $authors



?>
