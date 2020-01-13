<?php
$servername = "localhost";
$username = "root";
$password = "";
$db = 'adise19_uno_game_db';

// Create connection
$mysqli = new mysqli($servername, $username, $password, $db);

// Check connection
if (mysqli_connect_error()) {
    die("Database connection failed: " . mysqli_connect_error());   
}

?>