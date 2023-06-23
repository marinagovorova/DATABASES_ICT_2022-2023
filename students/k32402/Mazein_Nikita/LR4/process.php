<?php
// settings
$host = 'localhost';
$dbname = 'lab4';
$username = 'root';
$password = '';

// db connection
try {
    $db = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  } catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
  }
  
  $searchResults = [];

if (isset($_POST['insert'])) {
  // Insert new trick
  $name = $_POST['name'];
  $difficulty = $_POST['difficulty'];
  $description = $_POST['description'];

  $stmt = $db->prepare("INSERT INTO tricks (name, difficulty, description) VALUES (:name, :difficulty, :description)");
  $stmt->bindParam(':name', $name);
  $stmt->bindParam(':difficulty', $difficulty);
  $stmt->bindParam(':description', $description);
  $stmt->execute();

  header("Location: index.php");
  exit();

} elseif (isset($_POST['update'])) {
  // Update trick
  $id = $_POST['id'];
  $name = $_POST['name'];
  $difficulty = $_POST['difficulty'];
  $description = $_POST['description'];

  $stmt = $db->prepare("UPDATE tricks SET name = :name, difficulty = :difficulty, description = :description WHERE id = :id");
  $stmt->bindParam(':name', $name);
  $stmt->bindParam(':difficulty', $difficulty);
  $stmt->bindParam(':description', $description);
  $stmt->bindParam(':id', $id);
  $stmt->execute();

  header("Location: index.php");
  exit();

} elseif (isset($_POST['delete'])) {
  // Delete trick
  $id = $_POST['id'];

  $stmt = $db->prepare("DELETE FROM tricks WHERE id = :id");
  $stmt->bindParam(':id', $id);
  $stmt->execute();

  header("Location: index.php");
  exit();

} elseif (isset($_POST['display'])) {
  // Display trick by ID
  $id = $_POST['id'];

  $stmt = $db->prepare("SELECT * FROM tricks WHERE id = :id");
  $stmt->bindParam(':id', $id, PDO::PARAM_INT);
  $stmt->execute();
  $searchResults = $stmt->fetchAll(PDO::FETCH_ASSOC);

} elseif (isset($_POST['search'])) {
  // Search tricks by name
  $searchName = $_POST['search_name'];

  $stmt = $db->prepare("SELECT * FROM tricks WHERE name LIKE :name");
  $stmt->bindValue(':name', '%' . $searchName . '%');
  $stmt->execute();
  $searchResults = $stmt->fetchAll(PDO::FETCH_ASSOC);

} else {

}
?>

<!DOCTYPE html>
<html>
<head>
  <title>Search Results</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    
    h2 {
      margin-top: 0;
    }
    
    ul {
      list-style: none;
      padding: 0;
    }
    
    li {
      margin-bottom: 10px;
    }
    
    .result-container {
      background-color: #f8f8f8;
      padding: 10px;
      border-radius: 5px;
      margin-bottom: 20px;
    }
    
    .result-container h3 {
      margin: 0;
      padding-bottom: 5px;
      border-bottom: 1px solid #ccc;
    }
  </style>
</head>
<body>
  <?php if (is_array($searchResults) && count($searchResults) > 0): ?>
    <h2>Search Results</h2>
    <?php foreach ($searchResults as $trick): ?>
      <?php if (is_array($trick)): ?>
        <div class="result-container">
          <h3>Trick ID: <?php echo $trick['id']; ?></h3>
          <ul>
            <li><strong>Trick Name:</strong> <?php echo $trick['name']; ?></li>
            <li><strong>Difficulty:</strong> <?php echo $trick['difficulty']; ?></li>
            <li><strong>Description:</strong> <?php echo $trick['description']; ?></li>
          </ul>
        </div>
      <?php endif; ?>
    <?php endforeach; ?>
  <?php else: ?>
    <h2>No Results Found</h2>
  <?php endif; ?>
</body>
</html>

