<?php
include('config.ini.php');
//prepare the JSON data
header('Content-Type: application/json');
$data = array();

if(!empty($_GET['page']) && $_GET['page'] == "404"){
  errorJSON("Page not found",404);
}

// Check if the page got loaded with GET no need to check credential
if ($_SERVER['REQUEST_METHOD'] === 'GET') {

  //filter out empty request
  if(empty($_GET['page'])){
    errorJSON("No page selected",400);
  }

  //list all entities
  if($_GET['page'] == "entities"){
    include('get/entities/all.php');
  }

  //list all info on one entity
  elseif($_GET['page'] == "entity" && is_numeric($_GET['entity'])){
    include('get/entities/one.php');
  }

  //list all authors
  elseif($_GET['page'] == "authors"){
  include('get/authors/all.php');
  }

  //list all info on translations
  elseif($_GET['page'] == "translations"){
  include('get/translations/entity.php');
  }
  //not in the list
  else{
    errorJSON("Unknown request",400);
  }
}

// if request is a POST, check credential and insert new stuff
elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {

//check login

//check token

//add new entitie

//add new author

//add new translation of a text

//add new align

//add new language

//add new image

//add new keyword

//add new city

}
echo json_encode($data);
?>
