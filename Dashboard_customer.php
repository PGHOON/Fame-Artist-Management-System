<?php
session_start();
if (!isset($_SESSION['id'])) {
    header("Location: Login3.php");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <link rel="stylesheet" type="text/css" href="Styles.css">
</head>
<body>
    <nav>
        <ul>
            <li><a href="Dashboard_customer.php" class="active">Dashboard</a></li>
            <li><a href="Logout.php">Logout</a></li>
        </ul>
    </nav>
    <div class="box">
        <h2>Welcome, <?php echo $_SESSION['fullname']; ?>!</h2>
        <p>This is your Customer Dashboard.</p>
    </div>
    <table>
  <thead>
    <tr>
      <th colspan="2">Customer Dashboard</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Customer ID:</td>
      <td><?php echo $_SESSION['id']; ?></td>
    </tr>
  </tbody>
</table>
</body>
</html>