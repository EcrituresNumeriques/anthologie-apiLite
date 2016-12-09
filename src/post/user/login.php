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
$intermed['password'] = $_POST['password'];
$intermed['salted'] = $intermed['password'].'{'.$user['salt'].'}';
$intermed['digest'] = hash('sha512', $intermed['salted'], true);

for ($i=1; $i<5000; $i++) {
    $intermed['digest'] = hash('sha512', $intermed['digest'].$intermed['salted'], true);
}
$encodedPassword = base64_encode($intermed['digest']);

//cleanup intermeds
unset($intermed);

//Compare with password in database
if($encodedPassword == $user['password']){
  //success
  $data['username'] = $user['username'];
  $data['success'] = 1;

  //generate TOKEN here : tableless token v1
  $data['token']['time'] = time();
  $data['token']['user'] = $user['id'];
  $data['token']['token'] = hash('sha512', $encodedPassword.hash('sha512', $user['salt'].$data['token']['time'], true), true);
}
else{
    errorJSON('Password mismatch',500);
}

?>
