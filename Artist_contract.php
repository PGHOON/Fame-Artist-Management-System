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

// Query for Artist Contract
$query = "SELECT *
FROM contract_t c
INNER JOIN artist_t a ON c.ArtistID = a.ArtistID
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
        <p>This is your Contract Information.</p>
    </div>
    <table>
        <thead>
            <tr>
                <th>Contract ID</th>
                <th>Start Date</th>
                <th>End Length</th>
                <th>Royalty Percentage</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
            <tr>
                <td><?php echo $row['ContractID']; ?></td>
                <td><?php echo $row['StateDate']; ?></td>
                <td><?php echo $row['EndDate']; ?></td>
                <td><?php echo $row['RoyaltyPerc']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
</body>
</html>