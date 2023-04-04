<!DOCTYPE html>
<html>
<head>
	<title>Login Page</title>
    <?php
    session_start();
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
    
    // Login Logic
    if($_SERVER["REQUEST_METHOD"] == "POST") {
        $firstname = $_POST['firstname'];
        $lastname = $_POST['lastname'];
        $id = $_POST['id'];

        // Set session variables
        $_SESSION['id'] = $id;
        $_SESSION['firstname'] = $firstname;
        $_SESSION['lastname'] = $lastname;
        
        // Check if user is an Artist
        $stmt = $conn->prepare("SELECT * FROM artist_t WHERE firstname=:firstname AND lastname=:lastname AND artistid=:id");
        $stmt->bindParam(':firstname', $firstname);
        $stmt->bindParam(':lastname', $lastname);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if($row) {
            // Login Successful
            // Redirect to Artist Dashboard
            if(isset($_SESSION["id"])) {
                header("location: Dashboard_artist.php");
                exit;
            }
        }
        
        // Check if user is an Artist Manager
        $stmt = $conn->prepare("SELECT * FROM artistmanager_t WHERE firstname=:firstname AND lastname=:lastname AND amanagerid=:id");
        $stmt->bindParam(':firstname', $firstname);
        $stmt->bindParam(':lastname', $lastname);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if($row) {
            // Login Successful
            // Redirect to Artist Manager Dashboard
            if(isset($_SESSION["id"])) {
                header("location: Dashboard_manager.php");
                exit;
            }
        }
        
        // Check if user is an Admin
        $stmt = $conn->prepare("SELECT * FROM admin_t WHERE firstname=:firstname AND lastname=:lastname AND adminid=:id");
        $stmt->bindParam(':firstname', $firstname);
        $stmt->bindParam(':lastname', $lastname);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if($row) {
            // Login Successful
            // Redirect to Admin Dashboard
            if(isset($_SESSION["id"])) {
                header("location: Dashboard_admin.php");
                exit;
            }
        }

        // Login Failed
        echo "Invalid login credentials";
    }
    ?>
	<link rel="stylesheet" type="text/css" href="Styles.css">
</head>
<body>
	<nav>
		<ul>
            <li><a href="index.php">Home</a></li>
            <li><a href="Login1.php">Artist</a></li>
            <li><a href="Login1.php">Manager</a></li>
            <li><a href="Login1.php">Admin</a></li>
            <li><a href="Login2.php">Prospective Artist</a></li>
            <li><a href="Login3.php">Customer</a></li>
		    <!--<li><a href="#">Signup</a></li>-->
		</ul>
	</nav>
	<div class="box">
		<h2>Login</h2>
		<form method="POST" action="Login1.php">
			<p>
				<label for="username">Firstname:</label>
				<input type="text" id="firstname" name="firstname">
			</p>
            <p>
				<label for="username">Lastname:</label>
				<input type="text" id="lastname" name="lastname">
			</p>
			<p>
				<label for="password">ID Number:</label>
				<input type="text" id="id" name="id">
			</p>
			<p>
				<input type="submit" value="Login">
			</p>
		</form>
	</div>
</body>
</html>
