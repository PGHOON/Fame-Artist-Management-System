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

// Query for Artist Event
$query = "SELECT *
FROM event_t e
INNER JOIN agreement_t a ON e.EventID = a.EventID
INNER JOIN contract_t c ON a.ContractID = c.ContractID
INNER JOIN venue_t v ON e.VenueID = v.VenueID
WHERE c.ArtistID = :artistid";

$stmt = $conn->prepare($query);
$stmt->bindParam(':artistid', $_SESSION['id']);
$stmt->execute();


// Execute statement
$stmt->execute();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Artist Dashboard</title>
    <link rel="stylesheet" type="text/css" href="Styles.css">
</head>
<body>
    <nav>
        <ul>
            <li><a href="Dashboard_artist.php">Dashboard</a></li>
            <li><a href="Artist_contract.php">Contract</a></li>
            <li><a href="Artist_payment.php">Payment</a></li>
            <li><a href="Artist_schedule.php">Schedule</a></li>
            <li><a href="Logout.php">Logout</a></li>
        </ul>
    </nav>
    <div class="box">
        <h2>Welcome, <?php echo $_SESSION['firstname'] . " " . $_SESSION['lastname']; ?>!</h2>
        <p>This is your Schedule.</p>
    </div>
    <table>
        <thead>
            <tr>
                <th>Venue</th>
                <th>Description</th>
                <th>Date</th>
                <th>Street</th>
                <th>City</th>
                <th>State</th>
                <th>Zip</th>
                <th>Phone</th>
                <th>Country</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
            <tr>
                <td><?php echo $row['VenueName']; ?></td>
                <td><?php echo $row['EventDesc']; ?></td>
                <td><?php echo $row['DateTime']; ?></td>
                <td><?php echo $row['Street']; ?></td>
                <td><?php echo $row['City']; ?></td>
                <td><?php echo $row['State']; ?></td>
                <td><?php echo $row['Zip']; ?></td>
                <td><?php echo $row['Phone']; ?></td>
                <td><?php echo $row['Country']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
</body>
</html>