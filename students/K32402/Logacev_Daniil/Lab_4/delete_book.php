<?php
$servername = "localhost";
$username = "root"; 
$password = "";     
$dbname = "booksdb"; 
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Ошибка подключения: " . $conn->connect_error);
}

$book_id_to_delete = $_POST['book_id_to_delete'];

$check_sql = "SELECT * FROM books WHERE book_id = '$book_id_to_delete'";
$check_result = $conn->query($check_sql);

if ($check_result->num_rows > 0) {
    $delete_sql = "DELETE FROM books WHERE book_id = '$book_id_to_delete'";

    if ($conn->query($delete_sql) === TRUE) {
        echo "Запись успешно удалена.";
    } else {
        echo "Ошибка при удалении: " . $conn->error;
    }
} else {
    echo "Ошибка: Книга с указанным Book ID не существует.";
}

$conn->close();
?>