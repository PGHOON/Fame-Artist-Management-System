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

// Insert new record into newsitem_t
$query = "INSERT INTO newsitem_t (NewsItemID, NewsItemSource, NewsItemDate, NewsItemSummary, NewsItemContent)
          VALUES (:newsitemid, :source, :date, :summary, :content)";
$stmt = $conn->prepare($query);
$nextNewsItemId = $conn->query("SELECT MAX(NewsItemID) FROM newsitem_t")->fetchColumn() + 1;
$stmt->bindParam(':newsitemid', $nextNewsItemId);
$stmt->bindParam(':source', $_POST['source']);
$stmt->bindParam(':date', $_POST['date']);
$stmt->bindParam(':summary', $_POST['summary']);
$stmt->bindParam(':content', $_POST['content']);
$stmt->execute();

// Insert new record into artistnews_t
$query = "INSERT INTO artistnews_t (ArtistID, NewsItemID)
          VALUES (:artistid, :newsitemid)";
$stmt = $conn->prepare($query);
$stmt->bindParam(':artistid', $_SESSION['id']);
$stmt->bindParam(':newsitemid', $nextNewsItemId);
$stmt->execute();

// Redirect back to the portfolio dashboard
header("Location: Prospective_portfolio.php");
exit();
?>
