<?php
session_start();
if (!isset($_SESSION['id'])) {
    header("Location: ../login/Login2.php");
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

// Query for Artist payment
$query = "SELECT *
FROM artist_t a
JOIN contractedartist_t c ON a.ArtistID = c.ArtistID
JOIN prospectiveartist_t pa ON pa.ArtistID = a.ArtistID
WHERE pa.ArtistID = :artistid";

$stmt = $conn->prepare($query);
$stmt->bindParam(':artistid', $_SESSION['id']);
$stmt->execute();
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
            <li><a href="Dashboard_prospective.php">Dashboard</a></li>
            <li><a href="Prospective_recommendation.php">Recommendation</a></li>
            <li><a href="Prospective_portfolio.php">Submit Portfolio</a></li>
            <li><a href="Prospective_application.php">Status of Application</a></li>
            <li><a href="../login/Logout.php">Logout</a></li>
        </ul>
    </nav>
    <div class="box">
        <h2>Welcome, Prospective Artist <?php $row = $stmt->fetch(PDO::FETCH_ASSOC); echo $row['FirstName'] . " " . $row['LastName']; ?>!</h2>
        <p>This is your Status of Application Dashboard.</p>
    </div>
    <div class="Center">
    <?php
    $stmt->execute();
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!empty($row)) {
        echo "<h2>Congratulations, " . $row['FirstName'] . " " . $row['LastName'] . "!<br>You're now a Contracted Artist!</h2>
        <br><p>/*There's a contradiction in the data I generated for the case5 task. Currently, the artists in the artist_t table are stored in both the contracted and prospective tables, which is inconvenient to modify. That is the reason why the message above has printed. If changes are needed, a possible solution is to add new data to the artist_t table and change the key values between the prospective and contracted tables.*/</p>";
    } else {
        echo "<h2>Your application is still under examination...</h2>";
    }
    ?>
    </div>
</body>
</html>