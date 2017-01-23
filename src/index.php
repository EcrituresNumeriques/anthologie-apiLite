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
  if($_GET['page'] == "entities" || $_GET['page'] == "export"){
    include('get/entities/all.php');
  }

  //list all info on one entity
  if($_GET['page'] == "entity" && is_numeric($_GET['entity'])){
    include('get/entities/one.php');
  }
  //list all info on one entity
  if($_GET['page'] == "uriEntity" && !empty($_GET['uri'])){
    include('get/entities/one.php');
  }

  //list all authors
  if($_GET['page'] == "authors" || $_GET['page'] == "export"){
    include('get/authors/all.php');
  }

  //list all info on translations
  if($_GET['page'] == "translations"){
    include('get/translations/entity.php');
  }

  //list all languages
  if($_GET['page'] == "languages" || $_GET['page'] == "export"){
    include('get/languages/all.php');
  }
  //list all info on one language
  if($_GET['page'] == "language" && is_numeric($_GET['languageId'])){
    include('get/languages/language.php');
  }

  //list all language families
  if($_GET['page'] == "languagesFamilies" || $_GET['page'] == "export"){
    include('get/languages/families.php');
  }

  //list all language families
  if($_GET['page'] == "languagesFamily" && !empty($_GET['name'])){
    include('get/languages/family.php');
  }
  //list all URIs
  if($_GET['page'] == "URIs" || $_GET['page'] == "export"){
    include('get/URIs/all.php');
  }


  //not in the list
  if(empty($data)){
    errorJSON("Unknown get request",400);
  }
}

// if request is a POST, check credential and insert new stuff
elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
  //filter out empty request
  if(empty($_GET['page'])){
    errorJSON("No page selected",400);
  }

  //check login
  if($_GET['page'] == "login"){
    include('post/user/login.php');
  }
  else{
    $user = checkCredential($_POST['token'],$_POST['user'],$_POST['time'],$db);
    if(empty($user)){
      errorJSON("Token invalide",400);
    }
    else{
      $data['auth']['success'] = 1;
    }

    //add new entitie
    if($_GET['page'] == "newEntity"){
      include('post/entities/new.php');
    }

    //add new author

    //add new translation of a text
    elseif($_GET['page'] == "newTranslation"){
      include('post/translations/new.php');
    }

    //add new align

    //add new language
    elseif ($_GET['page'] == "newLanguage") {
      include('post/languages/new.php');
    }
    //add new URI destination
    elseif ($_GET['page'] == "addURId") {
      include('post/URIs/addURId.php');
    }
    //add new image

    //add new keyword

    //add new city

    //No post found
    else{
        errorJSON("No valid post request",400);
    }
  }


  //not in the list
  if(empty($data)){
    errorJSON("Unknown post request",400);
  }
}
echo json_encode($data);
?>
