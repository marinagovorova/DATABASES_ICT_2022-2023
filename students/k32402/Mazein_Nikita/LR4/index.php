<!DOCTYPE html>
<html>
<head>
  <title>Tricks DB</title>
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
    
    input[type="text"] {
      padding: 5px;
      width: 250px;
    }
    
    input[type="submit"] {
      padding: 5px 10px;
      background-color: #337ab7;
      color: #fff;
      border: none;
      cursor: pointer;
    }
    
    input[type="submit"]:hover {
      background-color: #23527c;
    }
  </style>
</head>
<body>
  <h2>Add New Trick</h2>
  <ul>
    <form name="insert" action="process.php" method="POST">
      <li><label>Trick Name:</label> <input type="text" name="name" /></li>
      <li><label>Difficulty:</label> <input type="text" name="difficulty" /></li>
      <li><label>Description:</label> <input type="text" name="description" /></li>
      <li><input type="submit" name="insert" value="Insert" /></li>
    </form>
  </ul>

  <h2>Update Trick</h2>
  <ul>
    <form name="update" action="process.php" method="POST">
      <li><label>Trick ID:</label> <input type="text" name="id" /></li>
      <li><label>Trick Name:</label> <input type="text" name="name" /></li>
      <li><label>Difficulty:</label> <input type="text" name="difficulty" /></li>
      <li><label>Description:</label> <input type="text" name="description" /></li>
      <li><input type="submit" name="update" value="Update" /></li>
    </form>
  </ul>

  <h2>Delete Trick</h2>
  <ul>
    <form name="delete" action="process.php" method="POST">
      <li><label>Trick ID:</label> <input type="text" name="id" /></li>
      <li><input type="submit" name="delete" value="Delete" /></li>
    </form>
  </ul>

  <h2>Display Trick By ID</h2>
  <ul>
    <form name="display" action="process.php" method="POST">
      <li><label>Trick ID:</label> <input type="text" name="id" /></li>
      <li><input type="submit" name="display" value="Display" /></li>
    </form>
  </ul>
</body>
</html>

<h2>Explore Tricks</h2>
  <ul>
    <form name="search" action="process.php" method="POST">
      <li><label>Trick Name:</label> <input type="text" name="search_name" /></li>
      <li><input type="submit" name="search" value="Search" /></li>
    </form>
  </ul>
</body>
</html>