<?php

$password = 'Gromlech';
$salt = 'tirjvnflc28cgccg40ws0os0cok0ogs';
$salted = $password.'{'.$salt.'}';
$digest = hash('sha512', $salted, true);

for ($i=1; $i<5000; $i++) {
    $digest = hash('sha512', $digest.$salted, true);
}

$encodedPassword = base64_encode($digest);
$data['password'] = $encodedPassword;
?>
