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
$query = "SELECT *, a.FirstName AS artist_firstname, a.LastName AS artist_lastname,
m.FirstName AS manager_firstname, m.LastName AS manager_lastname
FROM artist_t a
JOIN contractedartist_t c ON a.ArtistID = c.ArtistID
JOIN artistmanager_t m ON c.AManagerID = m.AManagerID
WHERE m.AManagerID = :amanagerid";

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
        <p>This is the Profiles of the Artists you represent.</p>
    </div>
    <table>
        <thead>
            <tr>
                <th>ArtistID</th>
                <th>Artist Name</th>
                <th>Gender</th>
                <th>YearOfBirth</th>
                <th>Street</th>
                <th>City</th>
                <th>State</th>
                <th>Zip</th>
                <th>Phone</th>
                <th>Email</th>
                <th>ArtistType</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
            <tr>
                <td><?php echo $row['ArtistID']; ?></td>
                <td><?php echo $row['artist_firstname'] . " " . $row['artist_lastname']; ?></td>
                <td><?php echo $row['Gender']; ?></td>
                <td><?php echo $row['YearOfBirth']; ?></td>
                <td><?php echo $row['Street']; ?></td>
                <td><?php echo $row['City']; ?></td>
                <td><?php echo $row['State']; ?></td>
                <td><?php echo $row['Zip']; ?></td>
                <td><?php echo $row['Phone']; ?></td>
                <td><?php echo $row['Email']; ?></td>
                <td><?php echo $row['ArtistType']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
</body>
</html>