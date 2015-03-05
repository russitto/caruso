<?php
header("Access-Control-Allow-Origin: *");

$fields = $_POST;
$fields_string = '';
foreach($fields as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }
rtrim($fields_string, '&');

$ch = curl_init();
$url = 'http://servicesv5.qbst.com.ar/index.php/v1/json/1/content/search';
curl_setopt($ch,CURLOPT_URL, $url);
// curl_setopt($ch,CURLOPT_POST, count($fields));
curl_setopt($ch,CURLOPT_POSTFIELDS, $fields_string);
curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    'Content-Type: application/x-www-form-urlencoded',
    'Content-Length: ' . strlen($fields_string),
    'Timestamp: 1425492662',
    'Signature: b9adb38412ed8e0c331b14dc0d7758e1c65a3a86',
    'Connection: close',
));
$result = curl_exec($ch);
curl_close($ch);

header("Content-type: application/json");
echo $result;
