<?php

//Check if user can add new content
function checkCredential($token){

}

//return error JSON message
function errorJSON($why = "Unspecified error",$code = 400){
  http_response_code($code);
  $data = array("error"=>1,"why"=>$why);
  die(json_encode($data));
}

?>
