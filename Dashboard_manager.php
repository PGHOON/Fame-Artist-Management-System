<?php
session_start();
if (!isset($_SESSION['id'])) {
    header("Location: Login1.php");
    exit();
}

// Database Connection
$host = 'localhost';
$dbname = 'case5';
$username = 'root';
$password = '';

// Test Connection
try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
    <link rel="stylesheet" type="text/css" href="Styles.css">
</head>
<body>
    <nav>
        <ul>
            <li><a href="Dashboard_manager.php" class="active">Dashboard</a></li>
            <li><a href="Logout.php">Logout</a></li>
        </ul>
    </nav>
    <div class="box">
        <h2>Welcome, <?php echo $_SESSION['firstname'] . " " . $_SESSION['lastname']; ?>!</h2>
        <p>This is your Manager Dashboard.</p>
    </div>
    <table>
  <thead>
    <tr>
      <th colspan="2">Manager Dashboard</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Manager ID:</td>
      <td><?php echo $_SESSION['id']; ?></td>
    </tr>
  </tbody>
</table>
</body>
</html>