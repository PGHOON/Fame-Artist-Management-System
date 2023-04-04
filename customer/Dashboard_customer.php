<?php
session_start();
if (!isset($_SESSION['id'])) {
    header("Location: ../login/Login3.php");
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

// Query for Customer information
$query = "SELECT *
FROM customer_t c
WHERE c.CustomerID = :customerid";

$stmt = $conn->prepare($query);
$stmt->bindParam(':customerid', $_SESSION['id']);
$stmt->execute();

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $customerid = $_POST['customerid'];
    $customername = $_POST['customername'];
    $street = $_POST['street'];
    $city = $_POST['city'];
    $state = $_POST['state'];
    $zip = $_POST['zip'];
    $phone = $_POST['phone'];
    $email = $_POST['email'];

    $query = "UPDATE customer_t SET CustomerName = :customername, street = :street, Street = :street, City = :city, State = :state, Zip = :zip, Phone = :phone, Email = :email WHERE customerid = :customerid";

    $stmt = $conn->prepare($query);
    $stmt->bindParam(':customerid', $customerid);
    $stmt->bindParam(':customername', $customername);
    $stmt->bindParam(':street', $street);
    $stmt->bindParam(':city', $city);
    $stmt->bindParam(':state', $state);
    $stmt->bindParam(':zip', $zip);
    $stmt->bindParam(':phone', $phone);
    $stmt->bindParam(':email', $email);
    $stmt->execute();
  }
?>

<!DOCTYPE html>
<html>
<head>
    <title>Prospective Artist Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../Styles.css">
</head>
<body>
    <nav>
        <ul>
            <li><a href="Dashboard_customer.php">Dashboard</a></li>
            <li><a href="Customer_artists.php">Artist Profiles</a></li>
            <li><a href="Customer_events.php">Events</a></li>
            <li><a href="Customer_purchased.php">Purchased History</a></li>
            <li><a href="../login/Logout.php">Logout</a></li>
        </ul>
    </nav>
    <div class="box">
        <h2>Welcome, Customer <?php echo $_SESSION['fullname']; ?>!</h2>
        <p>This is your Customer Dashboard.</p>
    </div>
    <div class="center">
    <?php
      $stmt = $conn->prepare($query);
      $stmt->bindParam(':customerid', $_SESSION['id']);
      $stmt->execute();
      while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
      <form method="POST" action="Dashboard_customer.php">
        <input type="hidden" name="customerid" value="<?php echo $row['CustomerID']; ?>">
        <label>customername:</label>
        <input type="text" name="customername" value="<?php echo $row['CustomerName']; ?>"><br>
        <label>Street:</label>
        <input type="text" name="street" value="<?php echo $row['Street']; ?>"><br>
        <label>City:</label>
        <input type="text" name="city" value="<?php echo $row['City']; ?>"><br>
        <label>State:</label>
        <input type="text" name="state" value="<?php echo $row['State']; ?>"><br>
        <label>Zip:</label>
        <input type="text" name="zip" value="<?php echo $row['Zip']; ?>"><br>
        <label>Phone:</label>
        <input type="text" name="phone" value="<?php echo $row['Phone']; ?>"><br>
        <label>Email:</label>
        <input type="text" name="email" value="<?php echo $row['Email']; ?>"><br>
        <input type="submit" value="Edit">
      </form>
    <?php } ?>
    </div>
</body>
</html>