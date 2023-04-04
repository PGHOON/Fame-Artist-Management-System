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

// Query for related artist.
$query = "SELECT *, a.FirstName AS artist_firstname, a.LastName AS artist_lastname
FROM contract_t c
JOIN contractedartist_t coa ON c.ArtistID = coa.ArtistID
JOIN artist_t a ON coa.ArtistID = a.ArtistID
WHERE c.EndDate BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 1 MONTH)
AND coa.AManagerID = :amanagerid";

$stmt = $conn->prepare($query);
$stmt->bindParam(':amanagerid', $_SESSION['id']);
$stmt->execute();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../Styles.css">
</head>
<body>
    <nav>
        <ul>
            <li><a href="Dashboard_manager.php">Dashboard</a></li>
            <li><a href="Manager_contract.php">Contract Calendar</a></li>
            <li><a href="Manager_payment.php">Artist's Payment</a></li>
            <li><a href="Manager_schedule.php">Artist's Schedule</a></li>
            <li><a href="../login/Logout.php">Logout</a></li>
        </ul>
    </nav>
    <div class="box">
        <h2>Welcome, Manager <?php echo $_SESSION['firstname'] . " " . $_SESSION['lastname']; ?>!</h2>
        <p>This is your Contract Information which would be expiring within a month.</p>
    </div>
    <?php if ($stmt->rowCount() == 0) { ?>
    <p>No contract would be expiring within a month.</p>
    <?php } else { ?>
    <table>
        <thead>
            <tr>
                <th>Artist Name</th>
                <th>Contract ID</th>
                <th>Start Date</th>
                <th>End Date</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
            <tr>
                <td><?php echo $row['artist_firstname'] . " " . $row['artist_lastname']; ?></td>
                <td><?php echo $row['ContractID']; ?></td>
                <td><?php echo $row['StateDate']; ?></td>
                <td><?php echo $row['EndDate']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
    <?php } ?>
</body>
</html>