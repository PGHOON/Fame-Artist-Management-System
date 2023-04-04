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
FROM event_t e
JOIN venue_t v ON e.VenueID = v.VenueID 
JOIN agreement_t ag ON e.EventID = ag.EventID
JOIN contract_t co ON co.ContractID = ag.ContractID
JOIN contractedartist_t coa ON co.ArtistID = coa.ArtistID
JOIN artist_t a ON coa.ArtistID = a.ArtistID
JOIN customer_t c
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
        <p>These are Events Information.</p>
    </div>
    <table>
        <thead>
            <tr>
                <th>Artist Name</th>
                <th>Event Description</th>
                <th>Date</th>
                <th>Venue Name</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
            <tr>
                <td><?php echo $row['FirstName'] . " " . $row['LastName']; ?></td>
                <td><?php echo $row['EventDesc']; ?></td>
                <td><?php echo $row['DateTime']; ?></td>
                <td><?php echo $row['VenueName']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
</body>
</html>