<?php
session_start();
unset($_SESSION["id"]);
unset($_SESSION["firstname"]);
unset($_SESSION["lastname"]);
header("Location:Login.php");
?>