<?php
$servername = "localhost";
$username = "root"; 
$password = "";     
$dbname = "booksdb"; 
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Ошибка подключения: " . $conn->connect_error);
}

$sql = "SELECT * FROM books";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "Book ID: " . $row["book_id"]. "<br>";
        echo "Book Name: " . $row["book_name"]. "<br>";
        echo "Year of Publication: " . $row["year_of_publication"]. "<br>";
        echo "Genre: " . $row["genre"]. "<br>";
        echo "Author ID: " . $row["author_id"]. "<br><br>";
    }
} else {
    echo "Нет данных о книгах.";
}

$conn->close();
?>