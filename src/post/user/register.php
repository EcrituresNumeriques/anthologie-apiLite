<?php
//check if user doesn't already exist
try{
$checkUser = $db->prepare("SELECT id,username, salt, password FROM fos_users WHERE username = :username");
$checkUser->bindParam(":username",$_POST['username']);
$checkUser->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}

if($checkUser->rowCount() > 0){
  errorJSON('Username already used',400);
}


//if not, insert into database
$insertUser = $db->prepare("INSERT INTO fos_users (username,salt,password,first_name,last_name,institution,last_login,enabled) VALUES (:username,:salt,:password,:first,:last,:institution,:lastLogin,1)");

//generate salt


//encode password
//



?>
