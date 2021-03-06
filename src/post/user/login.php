<?php

try{
$checkUser = $db->prepare("SELECT id,username, salt, password FROM fos_users WHERE username = :username");
$checkUser->bindParam(":username",$_POST['username']);
$checkUser->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}

if($checkUser->rowCount() < 1){
  errorJSON('User not found',500);
}

$user = $checkUser->fetch(PDO::FETCH_ASSOC);

//Generate hashed password from user
$password = $_POST['password'];
$salt = $user['salt'];
$salted = $password.'{'.$salt.'}';
$digest = hash('sha512', $salted, true);

for ($i=1; $i<5000; $i++) {
    $digest = hash('sha512', $digest.$salted, true);
}
$encodedPassword = base64_encode($digest);

//Compare with password in database
if($encodedPassword == $user['password']){
  //success
  $data['username'] = $user['username'];
  $data['success'] = 1;

  //update last_login
  $updateUser = $db->prepare("UPDATE fos_users SET last_login = NOW() WHERE id = :id");
  $updateUser->bindParam(":id",$user['id']);
  $updateUser->execute();

  //generate TOKEN here : tableless token v1
  $data['token']['time'] = time();
  $data['token']['user'] = $user['id'];
  $encodedTime = hash('sha512', $salt.$data['token']['time'], true);
  $encodedToken = hash('sha512', $encodedPassword.$encodedTime);
  $data['token']['token'] = base64_encode($encodedToken);
}
else{
    errorJSON('Password mismatch',500);
}

?>
