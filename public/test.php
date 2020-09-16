<?php 

header("Access-Control-Allow-Origin: *");

header("Access-Control-Allow-Headers: Content-Type, origin");
$postdata = file_get_contents("php://input");
register($postdata);
function register($data){
	phpinfo();
	print_r($data);
}
?>