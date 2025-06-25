<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
// Headers CORS (ajuste l'origine selon ton frontend)
header("Access-Control-Allow-Origin: *");
//header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, OPTIONS,PUT");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Credentials: true");

require_once "../../config/database.php";
require_once "../../model/magasin.php";

$host = $_GET['host'];
$dbname = $_GET['dbname'];
$username = $_GET['username'];
$password = $_GET['password'];

$database = new database($host, $dbname, $username, $password);
$db = $database->getConnexion();

$magasin = new magasin($db);
$data = json_decode(file_get_contents("php://input"));

$result = $magasin->updateMagasin(
    htmlspecialchars($data->codeMag),
    htmlspecialchars($data->nomMag),
    htmlspecialchars($data->adresseMag),
    htmlspecialchars($data->telMag)
    //htmlspecialchars($data->typeMag)
);

echo json_encode([
    "success" => $result,
    "message" => $result ? "Magasin modifié avec succès" : "Échec de la modification"
]);