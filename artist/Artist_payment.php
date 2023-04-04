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

// Query for Artist payment
$query = "SELECT ar.FirstName AS Artist,
SUM(GrossAmount) AS Revenue,
SUM(GrossAmount)*(co.RoyaltyPerc/100) AS FameFee,
SUM(ex.Amount) AS Expense,
SUM(GrossAmount) - SUM(GrossAmount)*(co.RoyaltyPerc/100) - SUM(ex.Amount) AS ArtistPayment
FROM agreement_t ag
INNER JOIN contract_t co ON ag.ContractID = co.ContractID
INNER JOIN contractedartist_t coa ON co.ArtistID = coa.ArtistID
INNER JOIN artistexpense_T ae ON coa.ArtistID = ae.ArtistID
INNER JOIN expense_t ex ON ae.ExpenseID = ex.ExpenseID
INNER JOIN artist_t ar ON coa.ArtistID = ar.ArtistID
WHERE coa.ArtistID = :artistid
GROUP BY ar.FirstName, co.RoyaltyPerc";

$stmt = $conn->prepare($query);
$stmt->bindParam(':artistid', $_SESSION['id']);
$stmt->execute();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Artist Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../Styles.css">
</head>
<body>
    <nav>
        <ul>
            <li><a href="Dashboard_artist.php">Dashboard</a></li>
            <li><a href="Artist_contract.php">Contract</a></li>
            <li><a href="Artist_payment.php">Payment</a></li>
            <li><a href="Artist_schedule.php">Schedule</a></li>
            <li><a href="../login/Logout.php">Logout</a></li>
        </ul>
    </nav>
    <div class="box">
        <h2>Welcome, Artist <?php echo $_SESSION['firstname'] . " " . $_SESSION['lastname']; ?>!</h2>
        <p>This is your Payment Information.</p>
    </div>
    <table>
        <thead>
            <tr>
                <th>Artist</th>
                <th>Revenue</th>
                <th>Fame Fee</th>
                <th>Expense</th>
                <th>Artist Payment</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
            <tr>
                <td><?php echo $row['Artist']; ?></td>
                <td><?php echo $row['Revenue']; ?></td>
                <td><?php echo $row['FameFee']; ?></td>
                <td><?php echo $row['Expense']; ?></td>
                <td><?php echo $row['ArtistPayment']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
    </table>
</body>
</html>