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

// Query for Artist information
$query = "SELECT * FROM artist_t WHERE ArtistID = :artistid";

$stmt = $conn->prepare($query);
$stmt->bindParam(':artistid', $_SESSION['id']);
$stmt->execute();

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $artistid = $_POST['artistid'];
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $gender = $_POST['gender'];
    $yearofbirth = $_POST['yearofbirth'];
    $street = $_POST['street'];
    $city = $_POST['city'];
    $state = $_POST['state'];
    $zip = $_POST['zip'];
    $phone = $_POST['phone'];
    $email = $_POST['email'];

    $query = "UPDATE artist_t SET FirstName = :firstname, LastName = :lastname, Gender = :gender, YearOfBirth = :yearofbirth, Street = :street, City = :city, State = :state, Zip = :zip, Phone = :phone, Email = :email WHERE ArtistID = :artistid";

    $stmt = $conn->prepare($query);
    $stmt->bindParam(':artistid', $artistid);
    $stmt->bindParam(':firstname', $firstname);
    $stmt->bindParam(':lastname', $lastname);
    $stmt->bindParam(':gender', $gender);
    $stmt->bindParam(':yearofbirth', $yearofbirth);
    $stmt->bindParam(':street', $street);
    $stmt->bindParam(':city', $city);
    $stmt->bindParam(':state', $state);
    $stmt->bindParam(':zip', $zip);
    $stmt->bindParam(':phone', $phone);
    $stmt->bindParam(':email', $email);
    $stmt->execute();
  }
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
        <p>This is your Artist Dashboard.</p>
    </div>
    <div class="center">
    <?php while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) { ?>
      <form method="POST" action="Dashboard_artist.php">
        <input type="hidden" name="artistid" value="<?php echo $row['ArtistID']; ?>">
        <label>First Name:</label>
        <input type="text" name="firstname" value="<?php echo $row['FirstName']; ?>"><br>
        <label>Last Name:</label>
        <input type="text" name="lastname" value="<?php echo $row['LastName']; ?>"><br>
        <label>Gender:</label>
        <input type="text" name="gender" value="<?php echo $row['Gender']; ?>"><br>
        <label>Year of Birth:</label>
        <input type="text" name="yearofbirth" value="<?php echo $row['YearOfBirth']; ?>"><br>
        <label>Street:</label>
        <input type="text" name="street" value="<?php echo $row['Street']; ?>"><br>
        <label>City:</label>
        <input type="text" name="city" value="<?php echo $row['City']; ?>"><br>
        <label>State:</label>
        <input type="text" name="state" value="<?php echo $row['State']; ?>"><br>
        <label>Zip:</label>
        <input type="text" name="zip" value="<?php echo $row['Zip']; ?>"><br>
        <label>Phone:</label>
        <input type="text" name="phone" value="<?php echo $row['Phone']; ?>"><br>
        <label>Email:</label>
        <input type="text" name="email" value="<?php echo $row['Email']; ?>"><br>
        <input type="submit" value="Save">
      </form>
    <?php } ?>
    </div>
</body>
</html>