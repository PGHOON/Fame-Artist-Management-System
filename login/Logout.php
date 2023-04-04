<?php
session_start();
unset($_SESSION["id"]);
unset($_SESSION["firstname"]);
unset($_SESSION["lastname"]);
unset($_SESSION['manager_name']);
header("Location:Login.php");
?>