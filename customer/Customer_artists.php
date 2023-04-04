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

// Query for Artist informations
$query = "SELECT *
FROM customer_t c
JOIN artist_t a
JOIN artistinstrument_t ai ON a.ArtistID = ai.ArtistID
JOIN instrument_t i ON ai.InstrumentID = i.InstrumentID
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
        <p>These are Artists Information.</p>
    </div>
    <table>
        <thead>
            <tr>
                <th>Artist ID</th>
                <th>Name</th>
                <th>Gender</th>
                <th>Year Of Birth</th>
                <th>State</th>
                <th>Email</th>
                <th>Artist Type</th>
                <th>Instrument</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
            <tr>
                <td><?php echo $row['ArtistID']; ?></td>
                <td><?php echo $row['FirstName'] . " " . $row['LastName']; ?></td>
                <td><?php echo $row['Gender']; ?></td>
                <td><?php echo $row['YearOfBirth']; ?></td>
                <td><?php echo $row['State']; ?></td>
                <td><?php echo $row['Email']; ?></td>
                <td><?php echo $row['ArtistType']; ?></td>
                <td><?php echo $row['InstrumentName']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
</body>
</html>