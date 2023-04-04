<?php
session_start();
if (!isset($_SESSION['id'])) {
    header("Location: Login2.php");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Prospective Artist Dashboard</title>
    <link rel="stylesheet" type="text/css" href="Styles.css">
</head>
<body>
    <nav>
        <ul>
            <li><a href="Dashboard_prospective.php" class="active">Dashboard</a></li>
            <li><a href="Logout.php">Logout</a></li>
        </ul>
    </nav>
    <div class="box">
        <h2>Welcome, !</h2>
        <p>This is your Prospective Artist Dashboard.</p>
    </div>
    <table>
  <thead>
    <tr>
      <th colspan="2">Prospective Artist Dashboard</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Prospective Artist ID:</td>
      <td><?php echo $_SESSION['id']; ?></td>
    </tr>
  </tbody>
</table>
</body>
</html>
