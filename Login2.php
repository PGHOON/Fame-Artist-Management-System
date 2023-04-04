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
        $id = $_POST['id'];

        // Set session variables
        $_SESSION['id'] = $id;
        
        // Check if user is a Prospective Artist
        $stmt = $conn->prepare("SELECT * FROM prospectiveartist_t WHERE artistid=:id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if($row) {
            // Login Successful
            // Redirect to Prospective Artist Dashboard
            if(isset($_SESSION["id"])) {
                header("location: Dashboard_prospective.php");
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
		<form method="POST" action="Login2.php">
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