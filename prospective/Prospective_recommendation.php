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
FROM recommendation_t r
JOIN prospectiveartist_t pa ON r.ArtistID = pa.ArtistID
JOIN artist_t a ON pa.ArtistID = a.ArtistID
JOIN source_t s ON r.SourceID = s.SourceID
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
        <p>This is your Prospective Artist Dashboard.</p>
    </div>
    <table>
        <thead>
            <tr>
                <th>Source Name</th>
                <th>Source Type</th>
                <th>Recommendation Summary</th>
                <th>Quality Evaluation</th>
                <th>Quality</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':artistid', $_SESSION['id']);
            $stmt->execute();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
            <tr>
                <td><?php echo $row['SourceName']; ?></td>
                <td><?php echo $row['SourceType']; ?></td>
                <td><?php echo $row['RecSummary']; ?></td>
                <td><?php echo $row['QualityEvaluation']; ?></td>
                <td><?php echo $row['Quality']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
</body>
</html>