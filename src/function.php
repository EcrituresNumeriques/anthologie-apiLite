<?php

//Check if user can add new content
function checkCredential($user, $password){

}

//return error JSON message
function errorBadRequest($why = "Unspecified error"){
  http_response_code(400);
  $data = array("error"=>1,"why"=>$why);
  die(json_encode($data));
}

?>
