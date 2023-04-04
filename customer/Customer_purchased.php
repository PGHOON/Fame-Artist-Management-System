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

// Query for Events
$query = "SELECT *
FROM customer_t c
JOIN customerpayment_t p ON c.CustomerID = p.CustomerID
JOIN event_t e ON e.CustomerID = c.CustomerID

WHERE c.CustomerID = :customerid";

$stmt = $conn->prepare($query);
$stmt->bindParam(':customerid', $_SESSION['id']);
$stmt->execute();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
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
        <p>This is your Purchased History.</p>
    </div>
    <table>
        <thead>
            <tr>
                <th>Event Description</th>
                <th>Event Date</th>
                <th>Purchased Date</th>
                <th>Amout</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
            <tr>
                <td><?php echo $row['EventDesc']; ?></td>
                <td><?php echo $row['DateTime']; ?></td>
                <td><?php echo $row['CPaymentDate']; ?></td>
                <td><?php echo $row['Amount']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
</body>
</html>