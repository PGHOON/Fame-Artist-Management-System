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

// Query for Prospective Artist Information
$query = "SELECT *
FROM newsitem_t n
JOIN artistnews_t an ON n.NewsItemID = an.NewsItemID
JOIN artist_t a ON an.ArtistID = a.ArtistID
JOIN prospectiveartist_t pa ON a.ArtistID = pa.ArtistID
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
        <p>This is your Portfolio Dashboard.</p>
    </div>
    <table>
        <thead>
            <tr>
                <th>Source</th>
                <th>Date</th>
                <th>Summary</th>
                <th>Content</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':artistid', $_SESSION['id']);
            $stmt->execute();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
            <tr>
                <td><?php echo $row['NewsItemSource']; ?></td>
                <td><?php echo $row['NewsItemDate']; ?></td>
                <td><?php echo $row['NewsItemSummary']; ?></td>
                <td><?php echo $row['NewsItemContent']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
    <div class="center">
    <h2>Submit News Item</h2>
    <form method="post" action="Submit.php">
        <input type="text" name="source" placeholder="Source" required>
        <input type="date" name="date" placeholder="Date" required>
        <input type="text" name="summary" placeholder="Summary" required>
        <input type="text" name="content" placeholder="Content" required>
        <button type="submit">Submit</button>
    </form>
</div>
</body>
</html>