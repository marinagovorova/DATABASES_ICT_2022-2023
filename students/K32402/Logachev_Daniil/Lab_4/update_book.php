<?php
$servername = "localhost";
$username = "root"; 
$password = "";     
$dbname = "booksdb"; 
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Ошибка подключения: " . $conn->connect_error);
}

$book_id_to_update = $_POST['book_id_to_update'];
$updated_book_name = $_POST['updated_book_name'];
$updated_year_of_publication = $_POST['updated_year_of_publication'];
$updated_genre = $_POST['updated_genre'];

$sql = "UPDATE books SET book_name = '$updated_book_name', year_of_publication = '$updated_year_of_publication', genre = '$updated_genre' WHERE book_id = '$book_id_to_update'";

if ($conn->query($sql) === TRUE) {
    echo "Данные успешно обновлены.";
} else {
    echo "Ошибка: " . $conn->error;
}

$conn->close();
?>