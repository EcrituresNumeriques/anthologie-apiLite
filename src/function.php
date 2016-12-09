<?php

//Check if user can add new content
function checkCredential($token,$id,$time,$db){
  $data = array();
  if($time < time()+7*24*60*60){
    try{
    $checkUser = $db->prepare("SELECT id,username, salt, password FROM fos_users WHERE id = :id");
    $checkUser->bindParam(":id",$id);
    $checkUser->execute();
    }
    catch(Exception $e){
      errorJSON('SQL error : ' . $e->getMessage(),500);
    }
    if($checkUser->rowCount() > 0){
      //generate token programatically
      $user = $checkUser->fetch(PDO::FETCH_ASSOC);
      $encodedTime = hash('sha512', $user['salt'].$time, true);
      $encodedToken = hash('sha512', $user['password'].$encodedTime);
      if(base64_encode($encodedToken) == $token){
        $data['auth']['success'] = 1;
        unset($user);
      }
      else{
        errorJSON('token failurex4',500);
      }
    }
    else{
      errorJSON('token failurex2',500);
    }
  }
  else{
    errorJSON('token failure',500);
  }
 return $data;
}

//return error JSON message
function errorJSON($why = "Unspecified error",$code = 400){
  http_response_code($code);
  $data = array("error"=>1,"why"=>$why);
  die(json_encode($data));
}

?>
