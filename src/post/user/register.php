<?php
//User need at least a username and a password
if(empty($_POST['username'])){
  errorJSON('Username not specified',400);
}
if(empty($_POST['password'])){
  errorJSON('Username not specified',400);
}
if(empty($_POST['email'])){
  errorJSON('Email not specified',400);
}
//check if user doesn't already exist
try{
$checkUser = $db->prepare("SELECT id,username, salt, password FROM fos_users WHERE username = :username OR email = :email");
$checkUser->bindParam(":username",$_POST['username']);
$checkUser->bindParam(":email",$_POST['email']);
$checkUser->execute();
}
catch(Exception $e){
  errorJSON('SQL error : ' . $e->getMessage(),500);
}

if($checkUser->rowCount() > 0){
  errorJSON('Username or Email already used',400);
}


//if not, insert into database
$insertUser = $db->prepare("INSERT INTO fos_users (username,username_canonical,salt,password,first_name,last_name,institution,last_login,enabled,roles,email,email_canonical) VALUES (:username,:username,:salt,:password,:first,:last,:institution,NOW(),1,:roles,:email,:email)");

//generate salt
$salt = bin2hex(openssl_random_pseudo_bytes(31));
//encode password
$password = $_POST['password'];
$salted = $password.'{'.$salt.'}';
$digest = hash('sha512', $salted, true);
for ($i=1; $i<5000; $i++) {
    $digest = hash('sha512', $digest.$salted, true);
}
$encodedPassword = base64_encode($digest);

//generate dummy values
(!empty($_POST['firstName'])?:$_POST['firstName'] = NULL);
(!empty($_POST['email'])?:$_POST['email'] = NULL);
(!empty($_POST['lastName'])?:$_POST['lastName'] = NULL);
(!empty($_POST['institution'])?:$_POST['institution'] = NULL);
$role = serialize(array());
//bindEverything
$insertUser->bindParam(":username",$_POST['username']);
$insertUser->bindParam(":email",$_POST['email']);
$insertUser->bindParam(":first",$_POST['firstName']);
$insertUser->bindParam(":last",$_POST['lastName']);
$insertUser->bindParam(":institution",$_POST['institution']);
$insertUser->bindParam(":roles",$role);
$insertUser->bindParam(":salt",$salt);
$insertUser->bindParam(":password",$encodedPassword);
$insertUser->execute() or die('Unabled to add new user');
$data['success'] = 1;
?>
