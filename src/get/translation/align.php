<?php

if(empty($_GET['id'])){
  errorJSON('First ID not specified',500);
}
if(empty($_GET['id2'])){
  errorJSON('Second ID not specified',500);
}

//id is always the smallest
if($_GET['id'] > $_GET['id2']){
  $tmp = $_GET['id'];
  $_GET['id'] = $_GET['id2'];
  $_GET['id2'] = $tmp;
}


$getAlign = $db->prepare("SELECT pair,json FROM entities_translations_align WHERE pair = :pair");
$pair = $_GET['id'].";".$_GET['id2'];
$getAlign->bindParam(":pair",$pair);
$getAlign->execute() or die('unable to get alignements');

if($getAlign->rowCount > 0){
  $data['align'] = $getAlign->fetch(PDO::FETCH_ASSOC);
}
else{
  $getTranslations = $db->prepare("SELECT * FROM `entities_translations` where id = :id OR id = :id2");
  $getTranslations->bindParam(":id",$_GET['id']);
  $getTranslations->bindParam(":id2",$_GET['id2']);
  $getTranslations->execute() or die('Unable to get translations');
  $translations = $getTranslations->fetchAll(PDO::FETCH_ASSOC);
  $json = array();
  $i = 0;
  foreach ($translations as $translation) {
    $json[] = stropheJSON($translation['text_translated'],$i);
    $i++;
    /*
    //generate lines by line
    $lines = explode("\n",$translation['text_translated']);
    $jsonLine = array();
    foreach ($lines as $line) {
     $tmp = preg_split("/[ [:punct:]]+/",$line,-1,PREG_SPLIT_DELIM_CAPTURE);
     $thisLine = array();
     foreach ($tmp as $word) {
       $thisLine[] = array("t"=>$word,"data"=>array(array(),array()));
     }
     $jsonLine[] = $thisLine;
    }
    //add this line to json
    $json[] = $jsonLine;
    */
  }
  $data['align']['json'] = $json;




}


function stropheJSON($strophe,$textNbr){
    $w = 0;
    $return = array();
    $parts = explode('\n', $strophe);
    foreach($parts as $value){
        $tmp = versJSON($value,$w,$textNbr);
        $w += count($tmp);
        $return[] = $tmp;
    }
    return $return;
}


function versJSON($vers,$word,$textNbr){
    $return = array();
    $string = preg_match_all("/\p{Greek}+|\w+|\p{P}+/u",$vers,$matches);
    foreach($matches[0] as $value){
      $tmp = array();
        $word++;
        if(preg_match("/\w+/", $value)){
          $tmp['t'] = $value;
          $tmp['h'] = array_fill(0,$textNbr,array());
          $tmp['h'][$textNbr] = $word;
        }
        elseif(preg_match("/\p{Greek}+/u", $value)){
          $tmp['t'] = $value;
          $tmp['h'] = array_fill(0,$textNbr,array());
          $tmp['h'][$textNbr] = $word;
        }
        else{
          $tmp['p'] = $value;
        }
        $return[] = $tmp;
    }
    return $return;
}



/*
JSON model :

>[
  [
    [{"t":"hello","hl":[[1],[1]]},{"p":","},{"t":"world","hl":[[3],[3]]}],
    []
  ],
  [
    [],
    []
  ]
]

*/


?>
