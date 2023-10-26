<?php
$servername = "localhost";
$username = "root"; 
$password = "";     
$dbname = "booksdb"; 

$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Ошибка подключения: " . $conn->connect_error);
}


$book_id = $_POST['book_id'];
$book_name = $_POST['book_name'];
$year_of_publication = $_POST['year_of_publication'];
$genre = $_POST['genre'];
$author_id = $_POST['author_id'];

$check_sql = "SELECT * FROM books WHERE book_id = '$book_id'";
$check_result = $conn->query($check_sql);

if ($check_result->num_rows > 0) {
    echo "Ошибка: Книга с таким Book ID уже существует.";
} else {
    $insert_sql = "INSERT INTO books (book_id, book_name, year_of_publication, genre, author_id) 
                    VALUES ('$book_id', '$book_name', '$year_of_publication', '$genre', '$author_id')";

    if ($conn->query($insert_sql) === TRUE) {
        echo "Запись успешно добавлена.";
    } else {
        echo "Ошибка: " . $conn->error;
    }
}

$conn->close();
?>