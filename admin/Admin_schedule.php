<?php
session_start();
if (!isset($_SESSION['id'])) {
    header("Location: ../login/Login1.php");
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
INNER JOIN contractedartist_t coa ON c.ArtistID = coa.ArtistID
INNER JOIN artistmanager_t m ON coa.AManagerID = m.AManagerID
INNER JOIN admin_t ad ON m.AManagerID = ad.AManagerID
WHERE ad.adminID = :adminid";

$stmt = $conn->prepare($query);
$stmt->bindParam(':adminid', $_SESSION['id']);
$stmt->execute();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Administrative Assistant Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../Styles.css">
</head>
<body>
    <nav>
        <ul>
            <li><a href="Dashboard_admin.php">Dashboard</a></li>
            <li><a href="Admin_contract.php">Contract Calendar</a></li>
            <li><a href="Admin_payment.php">Artist's Payment</a></li>
            <li><a href="Admin_schedule.php">Artist's Schedule</a></li>
            <li><a href="../login/Logout.php">Logout</a></li>
        </ul>
    </nav>
    <div class="box">
        <h2>Welcome, Manager <?php echo $_SESSION['firstname'] . " " . $_SESSION['lastname']; ?>!</h2>
        <p>This is your Artists's Schedule.</p>
        <p>You are assisting Manager <?php echo $_SESSION['manager_name']; ?></p>
    </div>
    <table>
        <thead>
            <tr>
                <th>Artist ID</th>
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
                <td><?php echo $row['ArtistID']; ?></td>
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