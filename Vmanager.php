<html>
<link rel="stylesheet" type="text/css" href="Styles.css">
    <head>
    <title>FAME</title>
    <h1>Fame Artist Management System</h1>
    <hr>
        <nav>
            <ul>
                <li><a href="index.php">Home</a></li>
                <li><a href="Vartist.php">View Artist</a></li>
                <li><a href="Vmanager.php">View Manager</a></li>
                <li><a href="Vinvoices.php">Invoices</a></li>
                <li><a href= "Support.php">Support</a></li>
                <li><a href="login/Login.php">Log in</a></li>
            </ul> 
        </nav>
    <hr>
    </head>
    <body>   
  <?php                                                                                       
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //      Database Connection     // 
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
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //  PHP for the Selection Dropdown    //
            $forms = ""; // Initialize $forms variable
            if ($_SERVER["REQUEST_METHOD"] == "POST") {
                if (isset($_POST["submit"])) {
                    // get inputted table name from form
                    $table = trim($_POST["table"]);
            
                    // Prepare the SQL query with a parameter for the table name
                    $select_sql = "SELECT * FROM `" . $table . "`";
                    $columns_sql = "SHOW COLUMNS FROM `" . $table . "`";
            
                    // Use prepared statements to execute the queries
                    $select_result = $conn->prepare($select_sql);
                    $select_result->execute();
                    $columns_result = $conn->prepare($columns_sql);
                    $columns_result->execute();
            
                    // Show Table From Database
                    if ($select_result->rowCount() > 0) {
                        echo "<table>";
                        echo "<tr>";
                        foreach ($columns_result->fetchAll(PDO::FETCH_COLUMN) as $column) {
                            echo "<th>" . $column . "</th>";
                        }
                        echo "</tr>";
                        while ($row = $select_result->fetch(PDO::FETCH_ASSOC)) {
                            echo "<tr>";
                            foreach ($row as $column) {
                                echo "<td>" . $column . "</td>";
                            }
                            echo "</tr>";
                        }
                        echo "</table>";
                    }
                } 
            }
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        // Section for PHP code that displays data on a artist based on the manager ID  ///


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //   PHP for the Default Shown Table  // 
            else {
                // Display the default table
                $table = "artistmanager_t";
                $select_sql = "SELECT * FROM " . $table;
                $columns_sql = "SHOW COLUMNS FROM " . $table;

                $select_result = $conn->prepare($select_sql);
                $select_result->execute();
                $columns_result = $conn->prepare($columns_sql);
                $columns_result->execute();

                if ($select_result->rowCount() > 0) {
                    echo "<table>";
                    echo "<tr>";
                    foreach ($columns_result->fetchAll(PDO::FETCH_COLUMN) as $column) {
                        echo "<th>" . $column . "</th>";
                    }
                    echo "</tr>";
                    while ($row = $select_result->fetch(PDO::FETCH_ASSOC)) {
                        echo "<tr>";
                        foreach ($row as $column) {
                            echo "<td>" . $column . "</td>";
                        }
                        echo "</tr>";
                    }
                    echo "</table>";
                } else {
                    echo "0 results";
                }
            }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // PHP for the Update Forms   //  |||  Update Action Not Working  ||| 

        if (isset($_POST['submit'])) {
            $table = trim($_POST['table']);

        
            // Get the column names 
            $columns = $conn->query("SHOW COLUMNS FROM $table");
            $forms = "";
            foreach($columns as $column) {
            $forms .= "<label for='" . $column[0] . "'>" . $column[0] . ":</label>";
            $forms .= "<input type='text' name='" . $column[0] . "' id='" . $column[0] . "'><br>";
            }
            // Display the generated forms
        
            } else if (isset($_POST["Update"])) {
            $table = $_POST["table"];
            // Get the column names for the selected table
        
            
            // Generate SET statement for update query  * ||||  Not Working  ||||| *
            $set = "";
            foreach($columns as $column) {
            if (isset($_POST[$column[0]])) {
                $set .= $column[0] . "='" . $_POST[$column[0]] . "',";
            }
            }
            $set = rtrim($set, ",");
            // Get the primary key column name
            $primaryKey = $conn->query("SHOW KEYS FROM $table WHERE Key_name = 'PRIMARY'")->fetch()["Column_name"];
            // Update the table with the entered values
            $sql = "UPDATE " . $table . " SET " . $set . " WHERE " . $primaryKey . "='" . $_POST[$primaryKey] . "'";
            if ($conn->query($sql) === TRUE) {
                echo "Table " . $table . " updated successfully";
            } else {
                echo "Error updating table: " . $conn->error;
            }
        }
///////////////////////////////////////////////////////////////////////////////////////
    ?>

       <!--------------------------     Update Button  -------------------------------------->
       <div class="Udate">
            <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                <?php echo $forms; ?>
                <input type="submit" name="Update" value="Update">
            </form>
        </div>

        <!---------------------------  Drop Down Menu For Tables  ---------------------------->
        <div class="Tmenu">
            <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                <label for="table">Select a Artist Manager Table To View:</label>
                <select name="table" id="table">
                    <?php
                        $tables = $conn->query(
                        "SELECT DISTINCT TABLE_NAME
                        FROM INFORMATION_SCHEMA.COLUMNS
                        WHERE COLUMN_NAME = 'AManagerID';");
                        foreach($tables as $table){
                            echo "<option value='". $table[0] ."'>". $table[0] ."</option>";
                        }
                    ?>
                </select>
                <input type="submit" name="submit" value="Submit">
            </form>
        </div>
       
        
    </body>
    
</html>